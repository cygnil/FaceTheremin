// Pretty basic code, here. Not sure how much of it is still working.
// This should use the Microsoft Kinect as a face-tracking theremin,
// generating noise based on the position of the first three faces
// found in the video frame.

import org.openkinect.*;
import org.openkinect.processing.*;
import hypermedia.video.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import java.awt.Rectangle;

Kinect kinect;
OpenCV opencv;
Minim minim;
AudioOutput aout;
boolean depth = true;
boolean rgb = true;
boolean ir = false;
int vibrato_rate = 15;
int vibrato_cap = 100;
int vibrato = 0;
ArrayList sines = new ArrayList();

float deg = 15; // Start at 15 degrees

void setup() {
  size(640,520);
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(depth);
  kinect.enableRGB(rgb);
  kinect.enableIR(ir);
  kinect.tilt(deg);

  opencv = new OpenCV( this );
  opencv.capture(640, 480);
  opencv.cascade( OpenCV.CASCADE_FRONTALFACE_ALT );
  
  minim = new Minim(this);
  aout = minim.getLineOut(Minim.MONO);
  for (int i = 0; i < 3; i++)
  {
    SineWave s = new SineWave(440, 0.5, aout.sampleRate());
    s.portamento(200);
    sines.add(s);
    aout.addSignal(s);
  }
}


void draw() {
  background(0);

  PImage rgbImg = kinect.getVideoImage();
  PImage zImg = kinect.getDepthImage();
  
  opencv.copy(rgbImg);
  opencv.convert( GRAY );
  Rectangle[] faces = opencv.detect( 1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40 );
  
  image(rgbImg, 0, 0);
  // draw face area(s)
  noFill();
  stroke(255,0,0);
  for( int i=0; i<faces.length; i++ ) {
      rect( faces[i].x, faces[i].y, faces[i].width, faces[i].height ); 
  }
  
  text("RGB/IR FPS: " + (int) kinect.getVideoFPS() + "        Camera tilt: " + (int)deg + " degrees",10,495);
//  text("DEPTH FPS: " + (int) kinect.getDepthFPS(),320,495);

  int samples = min(faces.length, sines.size());
  changeVibratoMax(faces, samples);
  changeVibratoRate(faces, samples, zImg);
  for (int i = 0; i < samples; i++)
  {
    SineWave s = (SineWave) sines.get(i);
    s.setFreq(applyVibrato(faces[i].x + faces[i].width / 2));
  }
  for (int i = min(faces.length, sines.size()); i < sines.size(); i++)
  {
    SineWave s = (SineWave) sines.get(i);
    s.setFreq(0);
  }
  text("Framerate: " + frameRate,10,515);
}

void keyPressed() {
  if (key == 'r') {
    rgb = !rgb;
    if (rgb) ir = false;
    kinect.enableRGB(rgb);
  }
  else if (key == CODED) {
    if (keyCode == UP) {
      deg++;
    } 
    else if (keyCode == DOWN) {
      deg--;
    }
    deg = constrain(deg,0,30);
    kinect.tilt(deg);
  }
}

void stop() {
  kinect.quit();
  opencv.stop();
  super.stop();
}

int applyVibrato(int freq) {
  if (abs(vibrato) > vibrato_cap)
    vibrato_rate *= -1;
  vibrato += vibrato_rate;
  return freq + vibrato;
}

void changeVibratoMax(Rectangle[] faces, int sampleSize)
{
  vibrato_cap = 0;
  for (int i = 0; i < sampleSize; i++)
  {
    vibrato_cap += (faces[i].y + faces[i].height / 2) / sampleSize;
  }
}

void changeVibratoRate(Rectangle[] faces, int sampleSize, PImage img)
{
  vibrato_rate = vibrato_rate / abs(vibrato_rate);
  int new_rate = 0;
  for (int i = 0; i < sampleSize; i++)
  {
  }
}
