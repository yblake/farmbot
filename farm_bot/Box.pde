class Box {

  private float x1, y1;
  private float x2, y2;
  private float thickness;
  private int fillColor;
  private PMatrix3D global;
  private String textureName;
  private PShape box;

  Box(float x1, float y1, float x2, float y2, float thickness, PMatrix3D global, String textureName) {

    // Default
    this.fillColor = 0xFFcccccc;

    // Setup
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.thickness = thickness;
    this.textureName = textureName;

    this.global = global.get();

    this.box = buildBox(this.x1, this.y1, this.x2, this.y2, this.thickness, this.fillColor, this.textureName);
    this.box.resetMatrix();
    this.box.applyMatrix(this.global);
  }

  Box(float x1, float x2, float thickness, PMatrix3D global, String textureName) {
    this(x1, 0.0f, x2, 0.0f, thickness, global, textureName);
  }

  Box(float length, float thickness, PMatrix3D global, String textureName) {
    this(-length/2.0f, 0.0f, +length/2.0f, 0.0f, thickness, global, textureName);
  }

  private PShape buildBox(float x1, float y1, float x2, float y2, float thickness, int fillColor, String textureName) {

    PVector v = new PVector(y1 - y2, x2 - x1).normalize().mult(thickness/2.0f);

    PShape box = createShape(GROUP);

    PShape face;

    // Left (1,2,3,4)
    face = createShape(PShape.GEOMETRY);
    face.beginShape(QUADS);
    face.noStroke();
    face.noTexture();
    face.fill(fillColor);
    face.vertex(x1 - v.x, y1 - v.y, - thickness/2.0f);
    face.vertex(x1 - v.x, y1 - v.y, + thickness/2.0f);
    face.vertex(x1 + v.x, y1 + v.y, + thickness/2.0f);
    face.vertex(x1 + v.x, y1 + v.y, - thickness/2.0f);
    face.endShape(OPEN);
    box.addChild(face);

    // Back (5,6,2,1)
    face = createShape(PShape.GEOMETRY);
    face.beginShape(QUADS);
    face.noStroke();
    if (textureName == null) {
      face.noTexture();
      face.fill(fillColor);
      face.vertex(x2 - v.x, y2 - v.y, - thickness/2.0f);
      face.vertex(x2 - v.x, y2 - v.y, + thickness/2.0f);
      face.vertex(x1 - v.x, y1 - v.y, + thickness/2.0f);
      face.vertex(x1 - v.x, y1 - v.y, - thickness/2.0f);
    } else {
      PImage texture = loadImage(textureName + "_back.jpg");   
      face.texture(texture);
      face.textureMode(NORMAL);
      face.fill(0xFF);
      face.vertex(x2 - v.x, y2 - v.y, - thickness/2.0f, 0, 1);
      face.vertex(x2 - v.x, y2 - v.y, + thickness/2.0f, 0, 0);
      face.vertex(x1 - v.x, y1 - v.y, + thickness/2.0f, 1, 0);
      face.vertex(x1 - v.x, y1 - v.y, - thickness/2.0f, 1, 1);
    }
    face.endShape(OPEN);
    box.addChild(face);

    // Top (3,2,6,7)
    face = createShape(PShape.GEOMETRY);
    face.beginShape(QUADS);
    face.noStroke();
    if (textureName == null) {
      face.noTexture();
      face.fill(fillColor);
      face.noTexture();
      face.fill(fillColor);
      face.vertex(x1 + v.x, y1 + v.y, + thickness/2.0f);
      face.vertex(x1 - v.x, y1 - v.y, + thickness/2.0f);
      face.vertex(x2 - v.x, y2 - v.y, + thickness/2.0f);
      face.vertex(x2 + v.x, y2 + v.y, + thickness/2.0f);
    } else {
      PImage texture = loadImage(textureName + "_top.jpg");   
      face.texture(texture);
      face.textureMode(NORMAL);
      face.fill(0xFF);
      face.vertex(x1 + v.x, y1 + v.y, + thickness/2.0f, 0, 1);
      face.vertex(x1 - v.x, y1 - v.y, + thickness/2.0f, 0, 0);
      face.vertex(x2 - v.x, y2 - v.y, + thickness/2.0f, 1, 0);
      face.vertex(x2 + v.x, y2 + v.y, + thickness/2.0f, 1, 1);
    }


    face.endShape(OPEN);
    box.addChild(face);

    // Front (4,3,7,8)
    face = createShape(PShape.GEOMETRY);
    face.beginShape(QUADS);
    face.noStroke();
    if (textureName == null) {
      face.noTexture();
      face.fill(fillColor);
      face.vertex(x1 + v.x, y1 + v.y, - thickness/2.0f);
      face.vertex(x1 + v.x, y1 + v.y, + thickness/2.0f);
      face.vertex(x2 + v.x, y2 + v.y, + thickness/2.0f);
      face.vertex(x2 + v.x, y2 + v.y, - thickness/2.0f);
    } else {
      PImage texture = loadImage(textureName + "_front.jpg");   
      face.texture(texture);
      face.textureMode(NORMAL);
      face.fill(0xFF);
      face.vertex(x1 + v.x, y1 + v.y, - thickness/2.0f, 0, 1);
      face.vertex(x1 + v.x, y1 + v.y, + thickness/2.0f, 0, 0);
      face.vertex(x2 + v.x, y2 + v.y, + thickness/2.0f, 1, 0);
      face.vertex(x2 + v.x, y2 + v.y, - thickness/2.0f, 1, 1);
    }
    face.endShape(OPEN);
    box.addChild(face);

    // Bottom (1,4,8,5)
    face = createShape(PShape.GEOMETRY);
    face.beginShape(QUADS);
    face.noStroke();
    if (textureName == null) {
      face.noTexture();
      face.fill(fillColor);
      face.vertex(x1 - v.x, y1 - v.y, - thickness/2.0f);
      face.vertex(x1 + v.x, y1 + v.y, - thickness/2.0f);
      face.vertex(x2 + v.x, y2 + v.y, - thickness/2.0f);
      face.vertex(x2 - v.x, y2 - v.y, - thickness/2.0f);
    } else {
      PImage texture = loadImage(textureName + "_bottom.jpg");   
      face.texture(texture);
      face.textureMode(NORMAL);
      face.fill(0xFF);
      face.vertex(x1 - v.x, y1 - v.y, - thickness/2.0f, 0, 1);
      face.vertex(x1 + v.x, y1 + v.y, - thickness/2.0f, 0, 0);
      face.vertex(x2 + v.x, y2 + v.y, - thickness/2.0f, 1, 0);
      face.vertex(x2 - v.x, y2 - v.y, - thickness/2.0f, 1, 1);
    }
    face.endShape(OPEN);
    box.addChild(face);

    // Right (5,6,7,8)
    face = createShape(PShape.GEOMETRY);
    face.beginShape(QUADS);
    face.noStroke();
    face.noTexture();
    face.fill(fillColor);
    face.vertex(x2 - v.x, y2 - v.y, - thickness/2.0f);
    face.vertex(x2 - v.x, y2 - v.y, + thickness/2.0f);
    face.vertex(x2 + v.x, y2 + v.y, + thickness/2.0f);
    face.vertex(x2 + v.x, y2 + v.y, - thickness/2.0f);
    face.endShape(OPEN);
    box.addChild(face);

    return box;
  }

  public void setFill(int fillColor) {
    this.box.setFill(fillColor);
  }

  public void update(PMatrix3D local) {
    this.box.resetMatrix();
    this.box.applyMatrix(this.global);
    if (local != null) {
      this.box.applyMatrix(local);
    }
    shape(this.box);
  }

  public void update() {
    this.update(null);
  }

  public PMatrix3D getGlobal() {
    return global.get();
  }
}
