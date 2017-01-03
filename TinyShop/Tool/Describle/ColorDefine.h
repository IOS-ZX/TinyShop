//
//  ColorDefine.h
//  Dingding
//
//  Created by 高 on 14-3-6.
//  Copyright (c) 2014年 高. All rights reserved.
//

#ifndef MovieTickets_ColorDefine_h
#define MovieTickets_ColorDefine_h


#define UICOLOR_FROM_RGB_OxFF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UICOLOR_FROM_RGB(r,g,b)             [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

#define UICOLOR_FROM_RGB_ALPHA(r,g,b,al)             [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:al]
//textField背景边线
#define FIELD_LINE_COLOR    UICOLOR_FROM_RGB(193, 193, 193)

#define UIVIEW_GRAY_BACK_COLOR   UICOLOR_FROM_RGB(223, 224, 225)

#define UILABLE_YELLOW_COLOR    UICOLOR_FROM_RGB_OxFF(0xffcd33)

//颜色相关
#define CYCLE_COLOR  UICOLOR_FROM_RGB(1,1,1)
#define MAIN_COLOR    UICOLOR_FROM_RGB(241, 54, 43)
#define BLUE_COLOR    UICOLOR_FROM_RGB(32, 185, 244)
#define LIGHTRED_COLOR    UICOLOR_FROM_RGB(250, 190, 190)

#define NORMALTEXTCOLOR  [UIColor colorWithRed:(113/255.0) green:(113/255.0) blue:(113/255.0) alpha:1.0]

#define BLACKTEXTCOLOR  [UIColor colorWithRed:(50/255.0) green:(50/255.0) blue:(50/255.0) alpha:1.0]

#define LIGHTTEXTCOLOR  [UIColor colorWithRed:(146/255.0) green:(146/255.0) blue:(146/255.0) alpha:1.0]

#define BACKGROUNDCOLOR  [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define BORDERCOLOR [UIColor colorWithRed:(185/255.0) green:(185/255.0) blue:(185/255.0) alpha:1.0]

#define USERWHITECOLOR [UIColor whiteColor]
#define USERCLEARCOLOR [UIColor clearColor]

#define NORMALTEXTCOLOR  [UIColor colorWithRed:(113/255.0) green:(113/255.0) blue:(113/255.0) alpha:1.0]
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define FONT(size) [UIFont systemFontOfSize:(size/375.0*SCREEN_WIDTH)]
//Movie---Cinema
//定位页面
#define MOVIE_LOCATION_VIEWFORHEADER_LABLE_BAC_COLOUR       UICOLOR_FROM_RGB(244, 244, 244)
#define MOVIE_LOCATION_VIEWFORHEADER_LABLE_COLOUR           UICOLOR_FROM_RGB(90, 90, 90)
#define MOVIE_LOCATION_LABLE_COLOUR                         UICOLOR_FROM_RGB(58, 58, 58)
#define MOVIE_LOCATION_CELL_LINE_COLOUR                     UICOLOR_FROM_RGB(199, 199, 199)
#define MOVIE_LocaTion_CityName_Color                       UICOLOR_FROM_RGB(58, 58, 58)

//上映页面
#define MOVIE_CELL_LINE_COLOUR      UICOLOR_FROM_RGB(236, 236, 236)
#define MOVIE_CELL_ACTORCOLOR       [UIColor colorWithRed:(128/255.0) green:(128/255.0) blue:(128/255.0) alpha:1.0]
#define MOVIE_CELL_TYPECOLOR        [UIColor colorWithRed:(128/255.0) green:(128/255.0) blue:(128/255.0) alpha:1.0]
#define MOVIE_CELL_RELEASDATECOLOR  [UIColor colorWithRed:(138/255.0) green:(138/255.0) blue:(138/255.0) alpha:1.0]
#define MOVIE_CELL_SCROECOLOR       [UIColor colorWithRed:(255/255.0) green:(114/255.0) blue:(0/255.0) alpha:1.0]

#define MOVIE_MOVIE_ICAROUSE_ONSALE_NAME_COLOUR     UICOLOR_FROM_RGB(58, 58, 58)
#define MOVIE_MOVIE_ICAROUSE_ONSALE_CINEMA_COLOUR   UICOLOR_FROM_RGB(138, 138, 138)
#define MOVIE_MOVIE_ICAROUSE_SOONSALE_CINEMA_COLOUR UICOLOR_FROM_RGB(90, 90, 90)

//影片详情页面
#define MOVIE_CMT_CELL_LINECOLOUR        UICOLOR_FROM_RGB(225, 225, 227)
#define LableColour                      [UIColor blackColor]
#define MOVIE_DETAIL_PriceColour         UICOLOR_FROM_RGB(208, 84, 35)
#define MOVIE_DETAIL_InfoColour          UICOLOR_FROM_RGB(131, 131, 131)
#define MOVIE_DETAIL_DesColour           UICOLOR_FROM_RGB(90, 90, 90)
#define MOVIE_DETAIL_ScoreNumColour      UICOLOR_FROM_RGB(208, 84, 35)

//影院列表
#define MOVIE_CINEMA_SeparaorColour   UICOLOR_FROM_RGB(236, 236, 236)
#define MOVIE_CCLOCA_LOCATION_LABLE_COLOUR        UICOLOR_FROM_RGB(148, 151, 153)
#define MOVIE_NO_CINEMA_COLOUR        UICOLOR_FROM_RGB(79, 79, 79)
#define MOVIE_CINEMA_TITLE_COLOUR     UICOLOR_FROM_RGB(79, 79, 79)
#define MOVIE_ADDRESS_COLOUR          UICOLOR_FROM_RGB(90, 90, 90)
#define MOVIE_DISTANCE_COLOUR         UICOLOR_FROM_RGB(179, 127, 68)
//影片排期
#define MOVIE_CINEMA_NAME_COLOUR        UICOLOR_FROM_RGB(58, 58, 58)
#define MOVIE_CINEMA_SCORE_COLOUR       UICOLOR_FROM_RGB(255, 114, 0)
#define MOVIE_CINEMA_ADDRESS_COLOUR     UICOLOR_FROM_RGB(90, 90, 90)
//#define MOVIE_MOVIE_NAME_COLOUR         UICOLOR_FROM_RGB(179, 179, 179)
#define MOVIE_MOVIE_SCORE_COLOUR        UICOLOR_FROM_RGB(255, 114, 0)
#define MOVIE_MOVIE_DETAIL_BTN_COLOUR     UICOLOR_FROM_RGB(128, 141, 169)
//排期页面cell
#define MOVIE_BEGIN_TIME_COLOUR         UICOLOR_FROM_RGB(213, 108, 35)
#define MOVIE_END_TIME_COLOUR           UICOLOR_FROM_RGB(166, 166, 166)
#define MOVIE_LANGUAGE_COLOUR           UICOLOR_FROM_RGB(118, 118, 118)
#define MOVIE_ROOM_COLOUR               UICOLOR_FROM_RGB(118, 118, 118)
#define MOVIE_LOWPRICE_COLOUR           UICOLOR_FROM_RGB(213, 108, 35)
#define MOVIE_HIGHPRICE_COLOUR          UICOLOR_FROM_RGB(173, 173, 173)
#define MOVIE_BUYLABLE_COLOUR           UICOLOR_FROM_RGB(187, 195, 207)


//TickColor

#define TICK_SEAT_COLOR1 UICOLOR_FROM_RGB(252.0f,244.0f,235.0f)
#define TICK_SEAT_COLOR2 UICOLOR_FROM_RGB(58.0f,58.0f,58.0f)
#define TICK_SEAT_COLOR3 UICOLOR_FROM_RGB(240.0f,235.0f,224.0f)
#define TICK_SEAT_COLOR4 UICOLOR_FROM_RGB(236.0f,203.0f,170.00f)
#define TICK_SEAT_COLOR5 UICOLOR_FROM_RGB(90.0f,90.0f,90.0f)
#define TICK_SEAT_COLOR6 TICK_SEAT_COLOR2

#define TICK_ORDER_COLOR1 TICK_SEAT_COLOR6
#define TICK_ORDER_COLOR2 UICOLOR_FROM_RGB(98.0,98.0f,98.0f)
#define TICK_ORDER_COLOR3 UICOLOR_FROM_RGB(214.0f,91.0f,41.0f)
#define TICK_ORDER_COLOR4 UICOLOR_FROM_RGB(62.0f,122.0f,231.0f)

#define TICK_PAY_COLOR1 UICOLOR_FROM_RGB(219.0f,97.0f,96.0f)
#define TICK_PAY_COLOR2 TICK_SEAT_COLOR2

#define TICK_PAYCELL_COLOR1 UICOLOR_FROM_RGB(138.0f,138.0f,138.0f)
#define TICK_SEATROW_COLOR1 TICK_SEAT_COLOR5
#define TICK_SEATVIEW_COLOR1 UICOLOR_FROM_RGB(217.0f,220.0f,223.0f)

#endif
