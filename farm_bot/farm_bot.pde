import peasy.*;
PeasyCam camera;
WorkSpace workspace;
Bot bot;

void settings() {
  // Format vidéo HD
  size(1280, 720, P3D);
  //size(1600, 900, P3D);
  smooth(8);
}

void setup() {

  // Format vidéo HD
  frameRate(30);
  //frameRate(60);

  // Prepare local coordinate system grid & gizmo
  this.workspace = new WorkSpace(5*75);

  this.bot = new Bot();

  this.camera = new PeasyCam(this, 50, 0, 0, 275.0f);
  this.camera.setActive(true);
  this.camera.setMinimumDistance(0.0f);
  this.camera.setMaximumDistance(3000.0f);
  this.camera.rotateX(-PI/2);
  //this.camera.rotateY(-PI/4);
  //this.camera.rotateZ(+PI/8);
  this.camera.rotateY(PI - PI/3);
  this.camera.rotateX(+PI/8);

  this.camera.setSuppressRollRotationMode();

  background(0x32);
}

boolean xy;
int cx=0, cy=0;
float x, y, z;
void draw() {

  background(0x32);

  //// Default screen projection
  //float fov = PI/3.0;
  //float cameraZ = (height/2.0) / tan(fov/2.0);
  //perspective(
  //  fov, 
  //  float(width)/float(height), 
  //  cameraZ/100.0, cameraZ*20.0);

  //// 3D camera (Real world : X+ right / Z+ top / Y+ Front)
  //camera(
  //  0.0f, 0.0f, (height/2.0f) / tan(PI*30.0f / 180.0f), 
  //  0.0f, 0.0f, 0.0f, 
  //  0, 1, 0
  //  );

  lights();
  //ortho();

  // Draw local coordinates system grid & gizmo
  //this.workspace.update();
  
// TODO
// this.camera.lookAt(double x, double y, double z, long animationTimeInMillis);

  if (!xy) {
    y = sin(cy*TWO_PI/480) * this.bot.width * 0.4f;
    z = sin(cy*TWO_PI/60) * this.bot.height * 0.4f;
    cy++;
    if (cy == 480) {
      cy = 0;
      xy = true;
    }
  } else {
    x = sin(cx*TWO_PI/2400) * this.bot.length * 0.45f;
    cx++;
    if (cx == 120) {
      cx = 0;
      xy = false;
    }
  }
  this.bot.move(x, y, z);

  this.bot.update();

  // MP4 video
  rec();
}
