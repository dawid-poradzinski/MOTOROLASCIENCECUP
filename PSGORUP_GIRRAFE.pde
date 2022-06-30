import controlP5.*;
import java.util.List;
import toxi.geom.*;
import toxi.geom.mesh2d.Voronoi;

/*                                                             */
/* PROJECT CREATED BY P.S GROPUP 2021 FOR MOTOROLA SCIENCE CUP */
/*                                                             */
ControlP5 cp5;

List<Vec2D> pointsPlace;

int timer, time, fR, fG, fB, sR, sG, sB, divideSpot, patchCount;
float noisePower, t = 1;
PImage screen, img;
PGraphics pg, girrafeSkin, lightMask, irregularMask;
boolean hidden = false, ifNoise, strokeIn;

void setup(){
 size(1400,1000);
 background(0);
 noFill();

 //image in background
 img = loadImage("girrafe.jpg");
 
 //craeting graphics
 girrafeSkin = createGraphics(width,height);
 lightMask = createGraphics(width,height);
 irregularMask = createGraphics(width,height);
 
 //menu
 cp5 = new ControlP5(this);
 Tab tab1 = cp5.getTab("Pierwszy Etap");
 Tab tab2 = cp5.getTab("Drugi Etap");
 Tab tab3 = cp5.getTab("Trzeci Etap");
 Tab tab4 = cp5.getTab("Czwarty Etap");
 tab1.setActive(true);
 cp5.addButton("girrafe0").setPosition(width/2-100,100).setSize(200,200).moveTo(tab1).setLabel("Zyrafa siatkowana");
 cp5.addButton("girrafe1").setPosition(width/2-100,350).setSize(200,200).moveTo(tab1).setLabel("Zyrafa zachodnioafrykanska");
 cp5.addButton("girrafe2").setPosition(width/2-100,100).setSize(200,200).moveTo(tab2).setLabel("Zyrafa numbijska");
 cp5.addButton("girrafe3").setPosition(width/2-100,350).setSize(200,200).moveTo(tab2).setLabel("Zyrafa kordafanska");
 cp5.addButton("girrafe4").setPosition(width/2-100,600).setSize(200,200).moveTo(tab2).setLabel("Zyrafa angolska");
 cp5.addButton("girrafe5").setPosition(width/2-100,100).setSize(200,200).moveTo(tab3).setLabel("Zyrafa poludniowoafrykanska");
 cp5.addButton("girrafe6").setPosition(width/2-100,350).setSize(200,200).moveTo(tab3).setLabel("Zyrafa rotszylda");
 cp5.addButton("girrafe7").setPosition(width/2-100,100).setSize(200,200).moveTo(tab4).setLabel("Zyrafa rodyjska");
 cp5.addButton("girrafe8").setPosition(width/2-100,350).setSize(200,200).moveTo(tab4).setLabel("Zyrafa masajska");
 cp5.getTab("default").remove();
 Textlabel repeatTextLabel = cp5.addTextlabel("label").setText("Aby powrócić do wyboru, kliknij q").setPosition(width/2-150, 850).setFont(createFont("Georgia",20));
 Textlabel saveTextLabel= cp5.addTextlabel("label1").setText("Aby zapisać, kliknij inny klawisz").setPosition(width/2-180, 900).setFont(createFont("Georgia",25)).setColorValue(0xffffff00);
}

void draw(){
  background(0);
  image(img, 0, 0, width, height);

  
}

//each girrafe and their colors itp
void girrafe0(float f){
  patchCount = 30;
 beginDrawingGirrafeSkin( 200, 190, 180, 115, 63, 39, 200, 190, 180, 45, false, false, 1, 10, false, false);
}

void girrafe1(float f){
  patchCount = 26;
  beginDrawingGirrafeSkin(170, 170, 170, 150, 106, 60, 198, 182, 152, 110, true, false, 1, 10, false, false);
}

void girrafe2(float f){
    patchCount = 26;
  beginDrawingGirrafeSkin(93, 60, 18, 199, 155, 94, 255, 252, 218, 49, true, false, 12, 10, false, false);
}

void girrafe3(float f){
    patchCount = 26;
  beginDrawingGirrafeSkin(50, 29, 6, 134, 104, 69, 187, 172, 153, 56, true, true, 34, 12, false, false);
}

void girrafe4(float f){
    patchCount = 26;
  beginDrawingGirrafeSkin(83, 49, 21, 132, 90, 47, 188, 164, 127, 58, true, true, 34, 12, false, false);
}

void girrafe5(float f){
    patchCount = 26;
 beginDrawingGirrafeSkin(100, 63, 26, 173, 134, 95, 244, 220, 181, 72, true, true, 30, 62, true, false);
}

void girrafe6(float f){
   patchCount = 26;
   beginDrawingGirrafeSkin(121,78, 48, 165, 108, 69, 229, 190, 149, 98, true, true, 26, 42, false, true);

}

void girrafe7(float f){
   patchCount = 20;
   beginDrawingGirrafeSkin(112,87,76,141,116,95,203,190,174, 30, false, true, 40, 60, true, true);
}

void girrafe8(float f){
 patchCount = 16;
 beginDrawingGirrafeSkin(170, 170, 170, 67, 57, 54, 215, 185, 167, 82, true, true, 50, 70, true, false);
}

void beginDrawingGirrafeSkin(int bGR, int bGG, int bGB, int fiR, int fiG, int fiB, int stR, int stG, int stB, int timeWait, boolean light, boolean noise, float nP, int divide, boolean in, boolean lightV2){
  fR = fiR;
  fG = fiG;
  fB = fiB;
  sR = stR;
  sG = stG;
  sB = stB;
  noisePower = nP;
  ifNoise = noise;
  divideSpot = divide;
  strokeIn = in;
  
  pg = girrafeSkin;
  
  Voronoi voronoi;
  //creating regions for voronoi
  List<Polygon2D> regions;
  
  time = millis();
 
 pointsPlace = new ArrayList<Vec2D>();
 //we put random points
 for(int c = 0; c < patchCount; c++){
   pointsPlace.add(new Vec2D(getPoissonRandom(random(width + 400)), getPoissonRandom(random(height + 400)))); 
 }


  //normal color for background
  background(bGR,bGG,bGB);
  screen = get(0,0,width,height);
  //color for stroke
  background(stR,stG,stB);
  
  do{
    //we add points to voronoi
  voronoi = new Voronoi();
  voronoi.addPoints(pointsPlace);
  //we cut our window into smaller window and that help normalize our voronoi
  Rect bound_rect = new Rect(-120,-120,width+240,height+240);
  
  SutherlandHodgemanClipper clipper = new SutherlandHodgemanClipper(bound_rect);
  
  regions = voronoi.getRegions();
    
  
   for(int i = 0; i < regions.size(); i ++){
     regions.set(i, clipper.clipPolygon(regions.get(i)));
     Vec2D centroid = regions.get(i).getCentroid();
     pointsPlace.set(i, centroid);
   }

  //we do it for certain amount of time, bigger time = more precission
  }while((millis() - time) - timer <= timeWait);
  
     pg.beginDraw();
     pg.blendMode(ADD);
     //we draw polygons
     drawPolygons(regions);
     pg.endDraw();
     image(pg,0,0);
     //we do some light
     if(light){
     drawPoints(pointsPlace);
     image(screen,0,0);
     }
     if(lightV2){  
       for(int i = 0; i < 2; i++){
       irregularLight(regions);
       image(screen,0,0); 
       }
     }
     //we hide menu
     cp5.hide();
     noLoop();
     hidden = true;
     


}

void drawPolygon(Polygon2D point){
  pg.blendMode(REPLACE);
  pg.beginShape();
  pg.fill(fR, fG, fB);
  pg.stroke(sR, sG, sB);
  
  pg.strokeWeight(26);  
  smooth(1);
   
  float firstX = 0, firstY = 0, nowX = 0, nowY = 0, lastX = 0, lastY = 0;
   
  boolean started = true;
  
  Vec2D vertices;
  //we need to do +1 loop cuz we do nothing on first loop
 for(int j=0; j < point.vertices.size() + 1; j++){
   if(j < point.vertices.size()){
        vertices = point.vertices.get(j);
   }else{
        vertices = new Vec2D(firstX, firstY); 
   }
    
    //we save first position
   if(started){
    started = !started; 
    firstX = vertices.x;
    firstY = vertices.y;
    lastX = firstX;
    lastY = firstY;
   }else{
    nowX = vertices.x;
    nowY = vertices.y;
    
    //we do now some noise
    float dist = dist(lastX, lastY, nowX, nowY);
    if(ifNoise){
      //if we want to have it more sharp
      while(dist > 1){
       dist /= divideSpot; 
      }
    }else{
      //and if not
     dist = 0.34; 
    }
    //we look if we need x or y to - + 0
    getCoordinates(lastX,lastY,nowX,nowY,point.getCentroid().x,point.getCentroid().y);
    //we chop it into smaller version
    for(float distance = 0.04; distance <= 1; distance += dist){
      //we now create noise value
      t = t + 1;
      float x = noise(t);
      x = map(x, 0, 1, 5, noisePower);
      
      float segmentX = lerp(lastX, nowX, distance);
      float segmentY = lerp(lastY, nowY, distance);
      //only if we want a one bigger stroke
      if(strokeIn){
        //some low chance to to his
        if(distance > 0.48 && distance < 0.51){
          if(random(2) > 1.7){
            float lineX = 0, lineY = 0;
            pg.vertex(segmentX + (x * noiseX), segmentY + (x * noiseY));
            t += 1;
            for(float lineChange = 0; lineChange < 0.8; lineChange+=0.2){
            lineX = lerp(segmentX, point.getCentroid().x, lineChange);  
            lineY = lerp(segmentY, point.getCentroid().y, lineChange);
            pg.vertex(lineX + (x * noiseX), lineY + (x * noiseY));
              t += 1;
            }
            //we change distane to make it better
            distance += dist*4;
            lineX = lerp(lineX, lerp(lastX, nowX, distance), 0.35);
            lineY = lerp(lineY, lerp(lastY, nowY, distance), 0.35);
            pg.vertex(lineX - (x * noiseX), lineY + (x * noiseY));
            pg.ellipse(lineX - (x * noiseX), lineY + (x * noiseY), 2 ,2);
            t=t+1;
            lineX = lerp(lineX, lerp(lastX, nowX, distance), 0.7);
            lineY = lerp(lineY, lerp(lastY, nowY, distance), 0.7);
            pg.vertex(lineX + (x * noiseX), lineY + (x * noiseY));
            pg.ellipse(lineX - (x * noiseX), lineY + (x * noiseY), 2 ,2);
            continue;
          }
        }
      }
      pg.vertex(segmentX + (x * noiseX),segmentY + (x * noiseY));
      
    }
   lastX = nowX;
   lastY = nowY;
   }
 
}

  pg.endShape(CLOSE);
}

void drawPoints(List<Vec2D> points){
  //we draw some "normal" lights
  for(Vec2D point : points){
    drawLight((int)point.x, (int)point.y, 160);
  }

   
}
//drawing each polygon
void drawPolygons(List<Polygon2D> points){
  for(Polygon2D point : points){
      drawPolygon(point); 
   }
}

//function for lights
void drawLight(int x, int y, int radius) {
  lightMask.beginDraw();
  lightMask.blendMode(ADD);
  lightMask.noStroke();
  
  for (int i=0; i<=radius/2; i++) {
    lightMask.fill(1.2);
    lightMask.ellipse(x, y, radius-i*6, radius-i*6);
  }
  lightMask.endDraw();
  screen.mask(lightMask);
  
}

//function for lights that doesnt work
void irregularLight(List<Polygon2D> points){
  irregularMask.beginDraw();
  irregularMask.blendMode(EXCLUSION);
  irregularMask.noStroke();
  for(Polygon2D point : points){
  Vec2D center = point.getCentroid();
  for(float m = 0.9; m > 0.3; m-=0.2){
    irregularMask.beginShape();
    for(Vec2D vector : point){

      t += 1;
      float x = noise(t);
      x = map(x,0,1,0,6);

        irregularMask.fill(16);
        float random = random(0.2,m);
      

        float distX = lerp(center.x,vector.x,random);
        float distY = lerp(center.y,vector.y,random);
        irregularMask.vertex(distX + x, distY + x);
      }
      irregularMask.endShape();
    }
  }
  irregularMask.endDraw();
  screen.mask(irregularMask);
}



//more natural random
int getPoissonRandom(double random){
 double negative = Math.exp(-random);
 int c = 0;
 double p = 1.0;
 do{
   p *= Math.random();
   c++;
}while(p > negative);
  return c-1;
}

int noiseX, noiseY;

//we look for this coordinates
void getCoordinates(float lastX, float lastY, float nowX, float nowY, float centroidX, float centroidY){
  if(lastX - nowX == 0){
    
    //from bottom to top
    noiseX = 0;
    if(lastY < centroidY){
      
      //if its higher
      noiseY = -1;
      
    }else{
     noiseY = 1; 
    }
    
  }else if(lastY - nowY == 0){
    
   //from left to right 
   noiseY = 0;
   if(lastX < centroidX){
    //if its lower 
    noiseX = -1;
   }else{
    noiseX = 1; 
   }
   
  }else if((lastY < nowY && lastX < nowX) || (lastY > nowY && lastX > nowX)){
    
    //from top left to bottom right
    if((lastX < centroidX && nowX > centroidX) || (lastX > centroidX && nowX < centroidX)){
      
      noiseX = 0;
      if(lastY < centroidY && nowY > centroidY){
        noiseY = 1;
      }else{
        noiseY = -1;
      }
      
    }else if((lastX > centroidX && nowX > centroidX) || (lastX < centroidX && nowX < centroidX)){
      noiseX = 0;
      if(lastX < centroidX){
       //noiseX = 1; 
      }else{
       //noiseX = -1; 
      }
      
      if(lastY < centroidY){
       noiseY = 1;
      }else{
        noiseY = -1;
    }
    }else{
     //from bottom left to top right 
      if(lastY < centroidY){
        noiseY = -1;
      }else{
        noiseY = 1; 
      }
      
      if(lastX < centroidX){
       noiseX = 1; 
      }else{
       noiseX = -1; 
      }
    }
  }
  
}

//saving image and exiting to ui
void keyPressed(){
  try{
  if(key == 'q' || key == 'Q'){
   redraw();
   cp5.show();
   pg.clear();
   try{
    lightMask.clear();
    irregularMask.clear();
   }catch(Exception e){
     
   }

   loop();
  }else if(hidden){
   save("image.png"); 
   System.out.println("saved");
  }
  }catch(Exception e){
    
  }
}
