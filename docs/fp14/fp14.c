// 固定背景 宇宙? 星を乱数でちりばめる
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include "img.h"
#define PI 3.14159265
//  プロトタイプ宣言: 戻り値の型 関数名(引数の型);----------------------------------
//  by author1: osibori
int getrandom(int, int);
//  by author2: yousei
int andBools(int *bools,  int n);
int orBools(int *bools,  int n);
//  by author3: rui: none
//  main------------------------------------------------------------------------
int main(void){
    //  first process-----------------------------------------------------------
    //  global
    struct color c1 = { 30, 255, 0};
    struct color c2 = { 255, 0, 0 };
    struct color black = {0, 0, 0};
    struct color white = {255, 255, 255};
    struct color twitter = {85, 172, 238};
    struct color googlep = {221, 75,  57};
    // -------------------------------
    //  by author1: osiuri: None
    // -------------------------------
    //  by author2: yousei
    int rect_LX = (int)(300/2);//  center
    int rect_LY = (int)(200/2);
    int hL      = 100;
    int hR      = 3;
    int rect_B[10];//  center
    int rect_X[10];
    int rect_Y[10];
    int rect_VX[10];
    int rect_VY[10];
    // -------------------------------
    //  by author3: ruirui: none
    // -------------------------------
    //  main process------------------------------------------------------------
    for(int frame = 0; frame < 40; ++frame){
        img_clear();
        // -------------------------------
        //  by author1: osiuri
        img_fillcircle(black, 150, 100, 300);
        for(int i = 0; i < 1000; ++i){
            img_putpixel(white, getrandom(0,300), getrandom(0,200));
        }
        // -------------------------------
        //  by author2: yousei
        //  初期化
        hL = hL-1;
        for(int i= 0; i<10; ++i){
            rect_B[i] = (int)(0);
            rect_X[i] = rect_LX-hL;
            rect_Y[i] = rect_LY-hL;
            rect_VX[i] = 0;
            rect_VY[i] = 0;
            hR = 3;
        }
        //  繰り返し
        while(1){
            hR = hR+getrandom(-1,2);
            for(int i=0;i<10;++i){
                if(rect_B[i]==0){
                    //  update
                    rect_X[i] = rect_X[i]+rect_VX[i];
                    rect_Y[i] = rect_X[i]+rect_VY[i];
                    rect_VX[i] = rect_VX[i]+getrandom(-3,6);
                    rect_VY[i] = rect_VY[i]+getrandom(-3,6);
                    //  check
                    if(rect_X[i]<rect_LX-hL||rect_LX+hL<rect_X[i]){
                        rect_B[i] = 1;
                    }//  if
                    if(rect_Y[i]<rect_LY-hL||rect_LY+hL<rect_Y[i]){
                        rect_B[i] = 1;
                    }//  if
                    //  render
                    img_fillline(googlep, rect_X[i]-hR, rect_Y[i]-hR, rect_X[i]-hR, rect_Y[i]+hR, 1);
                    img_fillline(googlep, rect_X[i]-hR, rect_Y[i]-hR, rect_X[i]+hR, rect_Y[i]-hR, 1);
                    img_fillline(googlep, rect_X[i]-hR, rect_Y[i]+hR, rect_X[i]+hR, rect_Y[i]+hR, 1);
                    img_fillline(googlep, rect_X[i]+hR, rect_Y[i]-hR, rect_X[i]+hR, rect_Y[i]+hR, 1);
                }//  if
            }//  for
            //  終了判定
            if(andBools(rect_B, 10)!=0){
                break;
            }
        }
        //  終了
        // -------------------------------
        //  by author3: ruiruirui
        if(frame/10== 0) {
            img_fillcircle(twitter, 1.5*(frame*frame), 150+2*frame, 10-0.1*frame*frame);
            img_fillcircle(c1, 300-1.5*(frame*frame), 50+2*frame, 10-0.1*frame*frame);
        }
        if(frame/10== 1) {
            img_fillcircle(twitter, 150+1.5*(frame*frame), 170-2*frame, 0.1*frame*frame);
            img_fillcircle(c1, 150-1.5*(frame*frame), 70-2*frame, 0.1*frame*frame);
        }
        if(frame/10== 2) {
            img_fillcircle(twitter, 300-1.5*(frame*frame), 150-2*frame, 10+2*frame);
            img_fillcircle(c1, 1.5*(frame*frame), 50-2*frame, 10+2*frame);
        }
        if(frame/10== 3) {
            img_fillcircle(twitter, 150-1.5*(frame*frame), 130+2*frame, 30-2*frame);
            img_fillcircle(c1, 150+1.5*(frame*frame), 30+2*frame, 30-2*frame);
        }
        // -------------------------------
        img_write();
    }//  for
}//  int
//  def function  --------------------------------------------------------------
// -------------------------------
//  by author1: omoiyari
int getrandom(int min, int max){
    return min + (int)(rand()*(max-min+1.0)/(1.0+RAND_MAX));
}
// -------------------------------
//  by author2: yousei
int andBools(int *bools,  int n){
    int rslt =  1;
    for(int i=0;i<n;++i){
        rslt = rslt*bools[i];
    }//  for
    return rslt;
}//  int
int orBools(int *bools,  int n){
    int rslt =  1;
    for(int i=0;i<n;++i){
        rslt = rslt*(1-bools[i]);
    }//  for
    return (1-rslt);
}//  int
// -------------------------------
//  by author3: ruiruiruirui: None
