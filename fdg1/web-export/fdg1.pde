HashMap<String, Node> nodes;
HashMap<String, HashMap<String, Float>> net;

float k =0.01;
float x0 = 10;
float q = -20;
float damp = 1;
float minDamp = 0.1;
float edgeConstant = 1000;
float maxEdge = 0;
float prevMax = 0;

float edgeThreshold = 1;
float minThreshold = 0.2;

float chargeRadius = 100;
float ellipseSize = 30;
float g;

color foreStroke = color(117, 47, 164);
color nodeFill = color(209, 0,93);
color linkFill = color(250,181,23);


void setup()
{
    size(500, 500);
    nodes  = new HashMap<String, Node>();
    net = new HashMap<String, HashMap<String, Float>>();
    loadData();
    reset();

}

void reset()
{
    damp = 0.9;
    g = 0.001;
    edgeThreshold = 1;
}

void loadData()
{
    String[] rows = loadStrings("reasonsdata2.csv");
    for(String r:rows)
    {
        String[] thisRow = split(r,',');
        String source = thisRow[0];
        String dest = thisRow[1];
        Float strength = float(thisRow[2]);
        
        if(!source.equals("NULL") && !dest.equals("NULL") && !source.equals(dest))
        {
          if(nodes.get(source)==null)
          {
              Node n = new Node();
              n.name = source;
              nodes.put(source, n);
          }
          
          nodes.get(source).prev += strength;
          
          if(net.get(source)==null)
          {
              net.put(source, new HashMap<String, Float>());
          }
          
          net.get(source).put(dest, strength);
          if(strength>maxEdge) maxEdge = strength;
        }
    }
    
    for(Node n:nodes.values())
    {
       if(n.prev>prevMax) prevMax = n.prev;
    }
    
    //println(maxEdge);
}

void draw()
{
    background(255);
    strokeWeight(0.5);
    damp = damp - 0.0001*(damp-minDamp);
    edgeThreshold*=0.995;
    //edgeThreshold = 0.1;
    if(edgeThreshold<minThreshold)edgeThreshold=minThreshold;
    forces();
    
    
    //noStroke();  
    
    stroke(linkFill);
    drawEdges();
    
    stroke(foreStroke);
    for(Node n:nodes.values())
    {
        n.display();
    }
    
    
    
    //noFill();
    //saveFrame("images/####.jpg");
    
}

void drawEdges()
{
  
    float minEdge = maxEdge;
    for(String source:net.keySet())
    {
        HashMap<String, Float> outs = net.get(source);
        for(String dest: outs.keySet())
        {
            float edge = outs.get(dest);
            
            if(edge/maxEdge>edgeThreshold)
            {
                if(edge<minEdge) minEdge = edge;
                
                PVector start = nodes.get(source).p;
                PVector end = nodes.get(dest).p;
                strokeWeight(3*edge/maxEdge);
                //stroke(0, 255*edge/maxEdge);
                PVector between  = PVector.sub(end, start);
                float bdist = between.mag();
                //line(start.x, start.y, end.x, end.y);
                
                pushMatrix();
                  translate(start.x, start.y);
                  //line(0,0,between.x, between.y);
                  
                  rotate(atan2(between.y, between.x));
                  
                  //shape
                  fill(red(linkFill),green(linkFill), blue(linkFill), 255*edge/maxEdge);
                  beginShape();
                    vertex(0,0.5*nodes.get(source).rad);
                    bezierVertex(0.1*bdist,  0.5*nodes.get(source).rad, 0.5*bdist,  bdist*0.1, bdist-0.5*nodes.get(dest).rad, 0);
                    vertex(0,0);
                    //bezierVertex(0.5*bdist, 0.05*bdist, 0.1*bdist, 0.1*bdist, 0,0);
                  endShape(CLOSE);
                   
                popMatrix();
            }
        }
    }
    //bit of debugging
    //println(minEdge);
}

void forces()
{
    PVector centre = new PVector(width/2, height/2);
    for(Node n:nodes.values())
    {
        n.a = new PVector(0,0);        
        
        PVector gravy = PVector.sub(centre, n.p);
        float gd = gravy.mag();
        
        if(gd>0)
        {
            gravy.normalize();
            gravy.mult(g*gd);
            n.a.add(gravy);
        }
        
        for(Node m:nodes.values())
        {
            if(n!=m)
            {
              //println(n.name + " " + m.name);
              PVector diff = PVector.sub(m.p, n.p);
              float d = diff.mag();
              
              if(d<chargeRadius)
              {
                  //spring
                  float dd = 0;
                  if(d>0) dd = q/d;
                  diff.normalize();
                  diff.mult(dd);
                  n.a.add(diff);
              }
            }
        }
        
 
    }
    
    for(String source:net.keySet())
    {
        HashMap<String, Float> outs = net.get(source);
        for(String dest: outs.keySet())
        {
            
                float edge = outs.get(dest);
                if(edge/maxEdge>edgeThreshold)
                {
                    PVector start = nodes.get(source).p;
                    PVector end = nodes.get(dest).p;
                    
                    PVector diff = PVector.sub(end, start);
                    float d = diff.mag();
                    
                    //spring
                    float dd = d-x0;
                    diff.normalize();
                    diff.mult(k*dd);
                    diff.mult(3*edge/maxEdge);
                    //diff.mult(exp(edge/(maxEdge)));
                    nodes.get(source).a.add(diff);
                    nodes.get(dest).a.sub(diff);
                }
        }
        
    }
    
    for(Node n:nodes.values())
    {
        n.v.add(n.a);
        n.v.mult(damp);
        n.p.add(n.v);
        
        //n.a.mult(damp);
        
        //verlet physics
//        PVector v = n.p.get();
//        v.add(n.a);
//        v.sub(n.pold);
//        v.mult(damp);
//       
//        
//        n.pold = n.p.get();
        
        //crude hackery
        //if(n.v.mag()>3)n.p.add(n.v);        
    }
}

class Node
{
    PVector p,a, pold,v;
    float source;
    float prev;
    float rad = 0;
    String name;
    
    Node()
    {
        //p = new PVector(random(-50,50), random(-50,50));
        //p.add(new PVector(width/2, height/2));
        p = new PVector(random(width), random(height));
        v=new PVector (0,0);
        prev = 0;
        pold = p.get();
    }
    
    void display()
    {
        //stroke(0);
        //fill(255,20);
        //println(prev);
        noFill();
        stroke(foreStroke);
        ellipse(p.x, p.y, ellipseSize, ellipseSize);
        rad = ellipseSize*prev/prevMax;
        noStroke();
        fill(red(nodeFill), green(nodeFill), blue(nodeFill));

        ellipse(p.x, p.y, rad, rad);
        
        
        if(dist(mouseX,mouseY,p.x,p.y)<0.5*ellipseSize)
        {
           
            fill(0);
            text(name,p.x,p.y);
        }
        
        
    }
    
   
    
    
    
    
}

void keyPressed()
{
    if(key=='f')saveFrame("images/####.png");
    if(key=='r') setup();
}

//void mouseDragged()
//{
//    for(Node n: nodes.values())
//    {
//        if(dist(n.p.x, n.p.y, mouseX, mouseY)<n.rad)
//        {
//            n.p.x = mouseX;
//            n.p.y = mouseY;
//        }
//    }
//    
//}


