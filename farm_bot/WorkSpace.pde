/**
 * WorkSpace Class 
 * @version  1.0.0
 * @author   Yves BLAKE (2021/Jan/30)
 * Handle z=0 tracking grid plane and world coordinates system gizmo shapes
 */
class WorkSpace {

  private final int size;
  private final int tile;

  // Coordinates system
  private PShape gizmo;
  private PShape grid;

  /**
   * Returns new WorkSpace object.
   * Prepares a Z=0 tracking grid plane
   * Prepares a world coordinates system gizmo 
   * @param  size  Overall grid size (meters) 
   */
  WorkSpace(int size) {

    this.size = size;
    this.tile = round(size/75.0f);

    // Grid
    this.grid = createShape();
    this.grid.beginShape(QUADS);
    this.grid.noFill();
    //this.grid.stroke(0x77836C3D);
    this.grid.stroke(0x77777777);
    this.grid.strokeWeight(0.50f);
    for (float x = -this.size/2.0f + this.tile/2.0f; x < this.size/2.0f; x += this.tile) {
      for (float y = -this.size/2.0f + this.tile/2.0f; y < this.size/2.0f; y += this.tile) {
        this.grid.vertex(x-this.tile/2.0f, y-this.tile/2.0f, -0.02f);
        this.grid.vertex(x+this.tile/2.0f, y-this.tile/2.0f, -0.02f);
        this.grid.vertex(x+this.tile/2.0f, y+this.tile/2.0f, -0.02f);
        this.grid.vertex(x-this.tile/2.0f, y+this.tile/2.0f, -0.02f);
      }
    }
    this.grid.endShape();

    // Gizmo
    this.gizmo = createShape(GROUP);
    
    // Unit vectors
    PShape unit = createShape();
    unit.beginShape(LINES);
    unit.noFill();
    unit.strokeWeight(1.5f);

    // Red X
    unit.stroke(0xFFFF3F7F);
    unit.vertex(0.0f, 0.0f, -0.01f);
    unit.vertex(+this.tile, 0.0f, -0.01f);

    // Green Y
    unit.stroke(0xFF3FFF7F);
    unit.vertex(0.0f, 0.0f, -0.01f);
    unit.vertex(0.0f, +this.tile, -0.01f);

    // Blue Z
    unit.stroke(0xFF3F7FFF);
    unit.vertex(0.0f, 0.0f, 0.0f);
    unit.vertex(0.0f, 0.0f, +this.tile);

    unit.endShape();
    this.gizmo.addChild(unit);

    // Axis vectors
    PShape axis = createShape();
    axis.beginShape(LINES);
    axis.noFill();
    axis.strokeWeight(0.75f);

    // Red X
    axis.stroke(0x80FF3F7F);
    axis.vertex(-this.size/2.0f, 0.0f, -0.01f);
    axis.vertex(+this.size/2.0f, 0.0f, -0.01f);

    // Green Y
    axis.stroke(0x803FFF7F);
    axis.vertex(0.0f, -this.size/2.0f, -0.01f);
    axis.vertex(0.0f, +this.size/2.0f, -0.01f);

    //// Blue Z
    //axis.stroke(0x803F7FFF);
    //axis.vertex(0.0f, 0.0f, -this.size/2.0f);
    //axis.vertex(0.0f, 0.0f, +this.size/2.0f);

    axis.endShape();
    this.gizmo.addChild(axis);

    // Shapes initial visibility
    this.grid.setVisible(true);
    this.gizmo.setVisible(true);
  }

  /**
   * Toggle Grid & Gizmo visibility.
   */
  void toggle() {
    this.grid.setVisible(!this.grid.isVisible());
    this.gizmo.setVisible(!this.gizmo.isVisible());
  }

  /**
   * Draw Grid & Gizmo.
   */
  void update() {
    shape(this.grid);
    shape(this.gizmo);
  }
}
