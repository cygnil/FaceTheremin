Originally Published: February 2, 2011 19:25

### Dependencies
This project has the following software dependencies:
* The OpenKinect library
* The Kinect Processing libraries
* The OpenCV Processing library
* The Minim Processing library (for sound)

### Specifications
**Language:** Processing
**Operating System:** Windows, OS X
**Peripherials:** Microsoft Kinect

### Time Estimates
**Novice:** an afternoon
**Advanced:** 2 hours
**Expert:** 1 hour

# Intro
First of all, here's a quick history lesson for you youngsters who are saying "what the heck's a theremin?": if you've ever watched any sci-fi from the 50s to the 80s, you've probably heard it. It's makes that wailing, otherworldly noise that's great for space operas or spooky shows with low budgets. Steampunk enthusiasts will probably prefer to call it by its more elegant name, the aetherphone.

What the device actually *is* is a pair of metal antennae that sense changes in the magnetic field around them and can thus detect the position of a player's hands without requiring touch. It's a very simple two-axis device: change the pitch of a simple sine wave by moving the hand side to side, and change the volume by moving up and down. You can read about the history and technique on the [Wikipedia article](http://en.wikipedia.org/wiki/Theremin).

## So. A *face* theremin, huh?
This project spawned out of an art hackathon at the Hacker Dojo where I needed to come up with something pretty quickly. The Kinect hacking scene was just starting, and I'd always wanted to try some stuff with OpenCV, and a theremin is kind of an elementary "hello world"-style application for learning other technologies, so I decided: why not? Might as well build a face-tracking theremin.

The face theremin uses OpenCV's built-in (very basic) face detection function to pinpoint faces on the Kinect's camera, and then uses the X position to determine the pitch that it should output. Because the Kinect can sense environments in 3D, that gives us one more whole variable we can play with, too! Because volume is a fairly elementary thing that may be best adjusted manually, anyhow, I decided to throw in a bit of a curveball: vibrato.

The code as it stands right now is largely complete, but could use some tweaking (and hackathons being the chaotic events that they are, I can't guarantee this version is in working condition, either). The X axis should determine pitch, lower on the left and higher on the right. The Y axis should determine vibrato amplitude, or just how much the vibrato varies from the base tone. The Z access should determine vibrato frequency, or how quickly it fades in and out relative to the base tone. Not that that's a lot of "should"s in those last three sentences.

The fun, of course, comes in with the face tracking part. In order to play this properly, you need to make sure that the Kinect sees your face in the proper part of the screen. Needless to say, there's a lot of jumping and weaving involved in this, which is always fun for others to watch.

However, this can also track multiple faces! By default it's set to track up to 3 faces, but this is easily changed in the code. You could have an entire theremin orchestra if you had enough friends and a powerful enough machine. Just make sure you don't crash into one another with those sudden pitch slides.

I doubt I'll spend much more time with this code since I've learned all I wanted to from this application, so I'm releasing it into the wild in case anybody else finds it useful. Modify to your heart's content!