//
//  UtilMacro.swift
//  Arita
//
//  Created by DcBunny on 16/1/6.
//  Copyright © 2016年 DcBunny. All rights reserved.
//

import Foundation

/**
*
* 颜色常量
*
*/

/* 背景色 */
let COLOR_BACKGROUND = UIColor(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1.0)

/* 塔塔报主色 */
let COLOR_TATA = UIColor(red: 255 / 255.0, green: 82 / 255.0, blue: 43 / 255.0, alpha: 1.0)

/* 创意主色 */
let COLOR_CY = UIColor(red: 240 / 255.0, green: 182 / 255.0, blue: 31 / 255.0, alpha: 1.0)

/* 设计主色 */
let COLOR_SJ = UIColor(red: 152 / 255.0, green: 199 / 255.0, blue: 63 / 255.0, alpha: 1.0)

/* 生活主色 */
let COLOR_SH = UIColor(red: 233 / 255.0, green: 37 / 255.0, blue: 39 / 255.0, alpha: 1.0)

/* 文章列表页面菜单栏文字未选中状态颜色 */
let COLOR_ARTICLE_MENU_TEXT_UNSELECTED_COLOR = UIColor(red: 172 / 255.0, green: 172 / 255.0, blue: 172 / 255.0, alpha: 1)

/* 良品主色 */
let COLOR_GOODS = UIColor(red: 32 / 255.0, green: 177 / 255.0, blue: 232 / 255.0, alpha: 1.0)

/* 良品首页菜单栏文字未选中状态颜色 */
let COLOR_GOODS_MENU_TEXT_UNSELECTED_COLOR = UIColor(red: 43 / 255.0, green: 166 / 255.0, blue: 216 / 255.0, alpha: 1.0)

/* 良品分类标签字体颜色 */
let COLOR_GOODS_CATEGORY_TEXT = UIColor(red: 85 / 255.0, green: 85 / 255.0, blue: 85 / 255.0, alpha: 1.0)

/* 良品名称字体颜色 */
let COLOR_GOODS_TITLE = UIColor(red: 34 / 255.0, green: 34 / 255.0, blue: 34 / 255.0, alpha: 1.0)

/* 良品推荐分割线颜色 */
let COLOR_GOODS_SEPARATE = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0)

/* 塔塔报、文章、良品推荐列表中内容的字体颜色 */
let COLOR_INFO = UIColor(red: 119 / 255.0, green: 119 / 255.0, blue: 119 / 255.0, alpha: 1.0)

/* 良品子标签字体颜色 */
let COLOR_QW = UIColor(red: 233 / 255.0, green: 97 / 255.0, blue: 147 / 255.0, alpha: 1.0)
let COLOR_DZ = UIColor(red: 28 / 255.0, green: 185 / 255.0, blue: 224 / 255.0, alpha: 1.0)
let COLOR_PS = UIColor(red: 142 / 255.0, green: 179 / 255.0, blue: 21 / 255.0, alpha: 1.0)
let COLOR_MS = UIColor(red: 243 / 255.0, green: 123 / 255.0, blue: 49 / 255.0, alpha: 1.0)
let COLOR_CF = UIColor(red: 147 / 255.0, green: 107 / 255.0, blue: 190 / 255.0, alpha: 1.0)
let COLOR_MY = UIColor(red: 255 / 255.0, green: 191 / 255.0, blue: 0 / 255.0, alpha: 1.0)
let COLOR_RC = UIColor(red: 236 / 255.0, green: 213 / 255.0, blue: 93 / 255.0, alpha: 1.0)
let COLOR_JJ = UIColor(red: 239 / 255.0, green: 75 / 255.0, blue: 20 / 255.0, alpha: 1.0)
let COLOR_WJ = UIColor(red: 232 / 255.0, green: 50 / 255.0, blue: 45 / 255.0, alpha: 1.0)
let COLOR_WZ = UIColor(red: 240 / 255.0, green: 139 / 255.0, blue: 97 / 255.0, alpha: 1.0)
let COLOR_MZ = UIColor(red: 126 / 255.0, green: 159 / 255.0, blue: 202 / 255.0, alpha: 1.0)
let COLOR_XB = UIColor(red: 184 / 255.0, green: 212 / 255.0, blue: 52 / 255.0, alpha: 1.0)

/**
*
* 字体／字号常量
*
*/

/* 标题字号 */
let FONT_TITLE = UIFont.systemFontOfSize(16)

/* 文章列表页面菜单栏文字字号 */
let FONT_ARTICLE_MENU_TEXT = UIFont.systemFontOfSize(14)

/* 首页文章标题字号 */
let TITLE_FONT_SIZE = CGFloat(12.0)

/* 塔塔报列表／文章列表单元格高度 */
let CELL_HEIGHT = 120 + (SCREEN_WIDTH - 20) * 2 / 3

/* 良品推荐列表单元格高度 */
let GOOD_CELL_HEIGHT = 85 + (SCREEN_WIDTH - 20)

/* 文章列表中每次加载的文章数量 */
let LOAD_ARTICLE_NUM = 10