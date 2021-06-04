// video export library
import com.hamoid.*;

// VideoExport object
VideoExport mp4;

// video name
final String videoFileName = getClass().getName() + ".mp4" ;
boolean recording = false;

void rec() {
  // Save video 
  if (frameCount == 1) {
    mp4 = new VideoExport(this, videoFileName);
    mp4.setDebugging(false);
    mp4.setFrameRate(30);  
    mp4.startMovie();
  }
  if (recording)
    mp4.saveFrame();
}

void exit() {
  println("Exiting MP4 recorder...");
  if (mp4 != null)
    mp4.endMovie();
  super.exit();
}

void keyPressed() {
  if (key == 'r')
    this.recording = !this.recording;
  println("recording:", this.recording);
}
