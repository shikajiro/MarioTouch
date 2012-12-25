
#include "pitches.h"

//デジタル出力用ピン番号の定義:the digital output pins
#define xLow  14
#define xHigh 15
#define yLow  16
#define yHigh 17

//スピーカーのピンを９ピンにする
int speakerPin = 9;

int count = 0;

void setup(){
  //シリアル通信開始:start serial communication
  Serial.begin(9600);


  //スピーカーのピンを出力モードに  
  pinMode(speakerPin, OUTPUT);

}

void loop(){
  //X座標用端子をデジタル出力に設定し、それぞれをLOWとHIGHで出力しておく
  //set the both x-coordinate pins as digital output:one is Low the other is HIGH  
  pinMode(xLow,OUTPUT);
  pinMode(xHigh,OUTPUT);
  digitalWrite(xLow,LOW);
  digitalWrite(xHigh,HIGH);

  //Y座標用端子をLOWにしておく:the both y-coordinate pins are set to be LOW
  digitalWrite(yLow,LOW);
  digitalWrite(yHigh,LOW);

  //Y座標用端子をデジタル入力に設定:change the y-coordinate pins as digital input
  pinMode(yLow,INPUT);
  pinMode(yHigh,INPUT);
  delay(10);

  //アナログ入力２番ピン（yLowピン）で読み込み
  //read analog pin2(yLow pin) to get an x-coordinate value
  int x = analogRead(2);
  
  //Y座標用端子をデジタル出力に設定し、それぞれをLOWとHIGHで出力しておく
  //set the both y-coordinate pins as digital output:one is Low the other is HIGH 
  pinMode(yLow,OUTPUT);
  pinMode(yHigh,OUTPUT);
  digitalWrite(yLow,LOW);
  digitalWrite(yHigh,HIGH);

  //X座標用端子をLOWにしておく:the both x-coordinate pins are set to be LOW
  digitalWrite(xLow,LOW);
  digitalWrite(xHigh,LOW);

  //X座標用端子をデジタル入力に設定:change the x-coordinate pins as digital input
  pinMode(xLow,INPUT);
  pinMode(xHigh,INPUT);
  delay(10);

  //アナログ入力０番ピン（xLowピン）で読み込み
  //read analog pin0(xLow pin) to get an y-coordinate value
  int y = analogRead(0);

  if(100 < x && 100 < y){
  	Serial.print(x);
  	Serial.print(":");
  	Serial.println(y);
  	count++;
  	if(10 < count){
  		oneup();
  		count = 0;
  	}else{
  		coin();
  	}
}


}
// シミ
void coin(){
	// 音の長さ
	int soundTime;

	// 音の高さを決める時間
	int delayTime;

	// マリオのコイン
	// シ
	delayTime = (1000000 / NOTE_B6 ) / 2;
	soundTime = (100000) / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);

	// ミ～（高）
	delayTime = (1000000 / NOTE_E7 ) / 2;
	soundTime =   250000 / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);
}

// ミ・ソ・ミ・ド・レ・ソ
void oneup(){

	// 音の長さ
	int soundTime;

	// 音の高さを決める時間
	int delayTime;

	float temp = 0.5f;

	// ミ
	delayTime = (1000000 / NOTE_E6 ) / 2;
	soundTime = (250000* temp) / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);

	// ソ
	delayTime = (1000000 / NOTE_G6 ) / 2;
	soundTime =   250000* temp / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);

	// ミ
	delayTime = (1000000 / NOTE_E7 ) / 2;
	soundTime = (250000* temp) / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);

	// ド
	delayTime = (1000000 / NOTE_C7 ) / 2;
	soundTime = (250000* temp) / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);

	// れ
	delayTime = (1000000 / NOTE_D7 ) / 2;
	soundTime = (250000* temp) / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);

	// ソ
	delayTime = (1000000 / NOTE_G7 ) / 2;
	soundTime =   250000* temp / (delayTime*2);

	playSound(soundTime, delayTime);

	delay(10);

}

void playSound(int soundTime, int delayTime){

	for(int i=0; i<soundTime; i++){

		digitalWrite(speakerPin, HIGH);
		delayMicroseconds(delayTime);

		digitalWrite(speakerPin, LOW);
		delayMicroseconds(delayTime);

	}
}