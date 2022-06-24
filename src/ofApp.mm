#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){	
    vStepRange = 200;
    ofSetBackgroundColor( 0 );
    ofSetFrameRate(24);
    touching = false;

    blackAmount =  3;
  blackAmountJitter =  true;
  blackAmountJitterSpeed = 100 ; //jitter change delay in ms
    numPasses  = 3;
   numPassesJitter =  true;
numPassesJitterSpeed = 100; //passes change delay in ms
    
    hStripeHeightRange =  50;
    hStripeHeightJitter =  true;
    hStripeHeightJitterSpeed = 100; //height change delay in ms
    
    hStepRange= 10 ;
    hStepRangeJitter = true;
    hStepRangeJitterspeed =  100; //hStep change delay in ms

    sparkColorPercent =  1;
    sparkColor = true;
   sparkColorJitter = false;

    sparkColorJitterSpeed =  100 ; //colour spakr percent change delay in ms

    frameRateJitter =  true ;
    // setup timers
    blackJitterTimer = ofGetSystemTimeMillis();
    passesJitterTimer = ofGetSystemTimeMillis();
    hStripeHeightTimer = ofGetSystemTimeMillis();
    hStepRangeTimer = ofGetSystemTimeMillis();
    sparkColorTimer = ofGetSystemTimeMillis();
    
    coreMotion.setupMagnetometer();
    coreMotion.setupGyroscope();
    coreMotion.setupAccelerometer();
    coreMotion.setupAttitude(CMAttitudeReferenceFrameXMagneticNorthZVertical);

}

//--------------------------------------------------------------
void ofApp::update(){
    
    coreMotion.update();

    
    if (frameRateJitter){
        ofSetFrameRate(ofRandom(5,30)); // randomise the framerate each frame
    } else {
        ofSetFrameRate(24);
    }
    
    if (blackAmountJitter){
        if (blackJitterTimer + blackAmountJitterSpeed < ofGetSystemTimeMillis()){
            blackAmount = ofRandom(1,10);
            blackJitterTimer = ofGetSystemTimeMillis();
            cout << "black loop says hi!, speed = " << blackAmountJitterSpeed << endl;
        }
    }
    
    if (numPassesJitter){
        if (passesJitterTimer + numPassesJitterSpeed < ofGetSystemTimeMillis()){
            numPasses = ofRandom(1,20);
            passesJitterTimer = ofGetSystemTimeMillis();
            cout << "passes loop says hi!, speed = " << numPassesJitterSpeed << endl;
        }
    }
    
    if ( hStripeHeightJitter ){
        if (hStripeHeightTimer + hStripeHeightJitterSpeed < ofGetSystemTimeMillis()){
            hStripeHeightRange = ofRandom(1,200);
            hStripeHeightTimer = ofGetSystemTimeMillis();
            cout << "passes  loop says hi!, speed = " << hStripeHeightJitterSpeed << endl;
        }
    }
    
    if ( hStepRangeJitter ){
        if (hStepRangeTimer + hStepRangeJitterspeed < ofGetSystemTimeMillis()){
            hStepRange = ofRandom(1,100);
            hStepRangeTimer = ofGetSystemTimeMillis();
            cout << "hstep  loop says hi!, speed = " << hStepRangeJitterspeed << endl;
        }
    }
    
    if ( sparkColor && sparkColorJitter ){
        if (sparkColorTimer + sparkColorJitterSpeed < ofGetSystemTimeMillis()){
            sparkColorPercent = ofRandom(1,100);
            sparkColorTimer = ofGetSystemTimeMillis();
            cout << "spakr color loop says hi!, speed = " << sparkColorJitterSpeed << endl;
        }
    }
    
    // accelerometer
    
    // attitude- roll,pitch,yaw
//    ofDrawBitmapStringHighlight("Attitude: (roll,pitch,yaw)", 20, 75);
//    ofSetColor(0);
//    ofDrawBitmapString(ofToString(coreMotion.getRoll(),3), 20, 100);
//    ofDrawBitmapString(ofToString(coreMotion.getPitch(),3), 120, 100);
//    ofDrawBitmapString(ofToString(coreMotion.getYaw(),3), 220, 100);
    
    if (touching == false){
//        hStripeHeightRange = ofMap( ofClamp( coreMotion.getRoll(), -0.5, 0.5 ) ,-0.5,  0.5, 1, 200);
//        hStepRange =       ofMap( ofClamp( coreMotion.getPitch(), -0.5, 0.5) , -0.5,  0.5, 1, 200);
        
        
        sparkColorPercent = ofMap( ofClamp( coreMotion.getRoll(), -0.5, 0.5 ), -0.5,  0.5, 1, 100);
       // hStepRange =       ofMap( ofClamp( coreMotion.getPitch(), -0.5, 0.5) , -0.5,  0.5, 1, 200);
//        cout << "roll: " << ofToString(  ofClamp(coreMotion.getRoll(), -0.5, 0.5)  ) << endl;
//        cout << "pitch: " << ofToString( coreMotion.getPitch() ) << endl;

    }
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    bool b_itsBlack = true;
    int hStripeHeight = 10;
   
    
    for (int i = 0; i< numPasses; i++){

        for (int y = 0; y < ofGetHeight(); y += ofRandom(1, vStepRange)){
            if (ofRandom(blackAmount)>1) {
                b_itsBlack = true;
            } else {
                b_itsBlack = false;
            }
            hStripeHeight = (ofRandom(hStripeHeightRange));
            
            for (int x = 0; x < ofGetWidth(); x += ofRandom(1, hStepRange)){
                if (!b_itsBlack){
                    ofSetColor(ofRandom(255), ofRandom(200));
                } else {
                    ofSetColor(0, ofRandom( 200));
                }
                ofPushStyle();
                if (sparkColor && (ofRandom(100) > sparkColorPercent )) {
                    ofSetColor(ofRandom(255), ofRandom(255), ofRandom(255), ofRandom(200));
                }
                ofDrawRectangle( x, y, ofRandom(1, hStepRange),  hStripeHeightRange );
                ofPopStyle();
            }
        }
    }
    // attitude- roll,pitch,yaw
//    ofDrawBitmapStringHighlight("Attitude: (roll,pitch,yaw)", 20, 75);
//    ofSetColor(0);
//    ofDrawBitmapString(ofToString(coreMotion.getRoll(),3), 20, 100);
//    ofDrawBitmapString(ofToString(coreMotion.getPitch(),3), 120, 100);
//    ofDrawBitmapString(ofToString(coreMotion.getYaw(),3), 220, 100);
//
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    touching = true;
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    hStripeHeightRange = ofMap(touch.x ,0,  ofGetWidth(), 1, 200);
    hStepRange = ofMap(touch.y ,0,  ofGetHeight(), 0.5, 200);
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    frameRateJitter = !frameRateJitter;
    touching = false;
    //coreMotion.resetAttitude();

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    sparkColor = !sparkColor;

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
   // cout << "device orientation change: " << ofToString( newOrientation ) << endl;
}
