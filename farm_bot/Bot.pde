class Bot {

  private PVector location;
  private PVector target;
  private boolean busy;
  private float length;
  private float width;
  private float height;
  private float thickness;
  private float margin;
  private PShape bot, floor, plants;
  private Box leftH, rightH, leftV, electric, rightV, topH, holder, topV, engine, warning;

  Bot() {

    // Initial location
    this.location = new PVector(0.0f, 0.0f, 0.0f);
    this.target = new PVector(0.0f, 0.0f, 0.0f);
    this.busy = false;

    // default size
    this.length = 300.0f;
    this.width = 100.0f;
    this.height = 50.0f;
    this.thickness = 5.0f;
    this.margin = 20.0f;

    this.bot = createShape(GROUP);

    this.floor = createShape(PShape.GEOMETRY);

    PImage image = loadImage("floor.png");    
    this.floor.beginShape(QUADS);
    this.floor.texture(image);
    this.floor.textureMode(NORMAL);
    this.floor.noStroke();
    //this.floor.fill(0xFF654321);
    this.floor.fill(0xFF);
    this.floor.vertex(-(this.length + this.margin)/2.0f, +(this.width + this.margin)/2.0f, 0.01f, 0, 0);
    this.floor.vertex(-(this.length + this.margin)/2.0f, -(this.width + this.margin)/2.0f, 0.01f, 1, 0);
    this.floor.vertex(+(this.length + this.margin)/2.0f, -(this.width + this.margin)/2.0f, 0.01f, 1, 1);
    this.floor.vertex(+(this.length + this.margin)/2.0f, +(this.width + this.margin)/2.0f, 0.01f, 0, 1);
    this.floor.endShape();
    bot.addChild(this.floor);

    PMatrix3D transformation = new PMatrix3D();

    transformation.reset();
    transformation.translate(0.0f, -this.width/2.0f, this.thickness/2.0f);
    this.leftH = new Box(this.length, this.thickness * 0.75f, transformation, "rail");
    this.leftH.setFill(0xFFa0a0a0);

    transformation = this.leftH.getGlobal();
    transformation.translate(0.0f, 0.0f, this.height/2.0f);
    transformation.rotate(-PI/2.0f, 0.0f, 1.0f, 0.0f);
    this.leftV = new Box(this.height, this.thickness, transformation, null);

    transformation = this.leftH.getGlobal();
    transformation.translate(0.0f, +this.width, 0.0f);
    this.rightH = new Box(this.length, this.thickness * 0.75f, transformation, "rail");
    this.rightH.setFill(0xFFa0a0a0);

    transformation = this.rightH.getGlobal();
    transformation.translate(0.0f, 0.0f, this.height/2.0f);
    transformation.rotate(-PI/2.0f, 0.0f, 1.0f, 0.0f);
    this.rightV = new Box(this.height, this.thickness, transformation, null);

    transformation = this.rightV.getGlobal();
    transformation.translate(-10.0f, this.thickness * 2.25f / 2.0f, 0.0f);
    this.electric = new Box(this.height/6, this.thickness * 1.25f, transformation, null);
    this.electric.setFill(0xFFFFFFFF);

    transformation.translate(0.0f, 0.0f, -this.thickness * 1.25f/2.0f);
    this.warning = new Box(this.thickness * 0.20f, this.thickness * 0.5f, transformation, null);
    this.warning.setFill(0xFF8fbc8f);

    transformation.reset();
    transformation.translate(0.0f, 0.0f, this.height + this.thickness);
    transformation.rotate(-PI/2.0f, 0.0f, 0.0f, 1.0f);
    this.topH = new Box(this.width + this.thickness, this.thickness, transformation, "rail");

    transformation = this.topH.getGlobal();
    transformation.rotate(-PI/2.0f, 0.0f, 1.0f, 0.0f);
    this.topV = new Box(this.height, this.thickness/2.0f, transformation, "topv");
    this.topV.setFill(0xFFa0a0a0);

    this.holder = new Box(this.thickness * 1.20f, this.thickness * 1.20f, transformation, null);
    this.holder.setFill(0xFFFFFFFF);

    transformation.translate(-this.height/2.0f, 0.0f, 0.0f);
    this.engine = new Box(this.thickness * 0.75f, this.thickness, transformation, null);
    this.engine.setFill(0xFF035096);

    PImage salad = loadImage("salad.png");    
    this.plants = createShape();
    this.plants.beginShape(QUADS);
    this.plants.noStroke();
    this.plants.texture(salad);
    this.plants.textureMode(NORMAL);
    for (float c = -this.width/2 + this.width/7.0f; c < this.width/2.0f - this.width/7.0f; c += this.width/7.0f) {
      for (float r = -this.length/2 + this.length/21.0f; r < this.length/2.0f; r += this.length/21.0f) {
        this.plants.fill((int) random(128.0f, 255.0f));
        this.plants.emissive((int) random(0.0f, 255.0f));
        this.plants.vertex(r-5, c-5, 3.0f, 0, 0);
        this.plants.vertex(r-5, c+5, 3.0f, 0, 1);
        this.plants.vertex(r+5, c+5, 3.0f, 1, 1);
        this.plants.vertex(r+5, c-5, 3.0f, 1, 0);
      }
    }
    this.plants.endShape(OPEN);
    bot.addChild(this.plants);
  }

  public void update() {

    PMatrix3D move = new PMatrix3D();

    // Scene
    shape(this.bot);
    this.leftH.update();
    this.rightH.update();

    // X offset
    move.translate(this.location.x, 0, 0);
    this.leftV.update(move);
    this.electric.update(move);
    this.warning.update(move);
    this.rightV.update(move);
    this.topH.update(move);

    // Y Offset
    move.translate(0.0f, this.location.y, 0.0f);
    this.holder.update(move);

    // Z offset
    move.translate(0.0f, 0.0f, this.location.z);
    this.topV.update(move);
    this.engine.update(move);
  }

  public void move(float x, float y, float z) {

    if ( x!= this.location.x) {
      this.warning.setFill(0xFFFF3F7F);
      this.floor.setTint(true);
      this.floor.setTint(0xFFFF3F7F);
      this.plants.setTint(true);
      this.plants.setTint(0xFFFF3F7F);
    } else {
      this.warning.setFill(0xFF3FFF7F);
      this.floor.setTint(false);
      this.plants.setTint(false);
    }

    this.location.set(x, y, z);
  }
}
