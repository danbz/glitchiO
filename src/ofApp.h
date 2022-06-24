#pragma once

#include "ofxiOS.h"
#include "ofxiOSCoreMotion.h"


class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

    
    int vStepRange;
    bool touching;
    
    float blackAmount,blackAmountJitterSpeed, numPassesJitterSpeed, hStripeHeightJitterSpeed, hStepRangeJitterspeed, sparkColorJitterSpeed ;
    bool blackAmountJitter, numPassesJitter, hStripeHeightJitter, hStepRangeJitter, sparkColor, sparkColorJitter, frameRateJitter;
    int numPasses, sparkColorPercent, hStripeHeightRange, hStepRange;
    
    float blackJitterTimer, passesJitterTimer, hStripeHeightTimer, hStepRangeTimer, sparkColorTimer;

    ofxiOSCoreMotion coreMotion;

};


