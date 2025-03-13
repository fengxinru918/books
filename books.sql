-- ----------------------------
-- Chat2DB export data , export time: 2025-02-27 20:45:01
-- ----------------------------
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for table admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `phone` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png',
  `gender` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '男',
  `adminName` varchar(255) DEFAULT 'admin',
  PRIMARY KEY (`phone`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` (`phone`,`password`,`avatar`,`gender`,`adminName`)  VALUES ('17627815587','123','https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png','女','admin');
-- ----------------------------
-- Table structure for table book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `bookId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `author` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `amount` int DEFAULT NULL,
  `position` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `totalAmount` int DEFAULT NULL,
  `borrowedTimes` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `bookImage` varchar(255) DEFAULT NULL,
  `bookDescription` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('jF4ZXVe5laHsJ44mSH4ZA','2','2','22','01#01A#1-682222','22','0','1','http://localhost:8989/uploads/1739096610087-ty4.jpg','22');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('h1G_z48dn1JQDjBhl0N7T','1','1','1','01#01A#1-68111','1','0','1','http://localhost:8989/uploads/1739097101944-ty1.jpg','1');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('Yn04p_JPXQBr1L3V_Xhbu','2','2','2','01#01A#1-682','2','0','1','http://localhost:8989/uploads/1739100576547-ty1.jpg','2');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('2','诸王的欧洲','莱昂哈德·霍洛夫斯基','99','01#01A#1-2','100','1','0','https://img3m8.ddimg.cn/85/14/29612668-1_w_1694071079.jpg','以讽刺与诙谐的文字勾勒17—18世纪欧洲的宫廷生活与权力博弈，用个人命运与宗族关系串联历史事件，剖析王朝社会的运行逻辑。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('3','西洋史：欧洲文明二十讲','陈衡哲','100','01#01A#1-3','100','0','0','https://img3m2.ddimg.cn/2/6/29612882-1_w_1695029235.jpg','原北大教授陈衡哲史学代表作，一本书读懂欧洲文明3000年。以1928年商务版为底本全新修订，还原19幅地图、27个图表、18幅插图。添加10幅历史名画、380余条译名注释、新旧译名对照表、大事年表。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('4','沙陀往事','樊文礼','102','01#01A#1-4','100','4','0','https://img3m6.ddimg.cn/51/8/29591646-1_w_1688444212.jpg','一部叱咤风云的沙陀兴衰史。从晋汴争霸到沙陀三王朝，军事征伐不断，再现唐末五代的军政现状:“天子，兵强马壮者为之。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('5','南明史','顾诚','98','01#01A#1-5','100','5','0','https://img3m7.ddimg.cn/64/26/29450287-1_w_7.jpg','《南明史》25周年精装纪念版，布艺烫印封面，带手绘藏书票，全彩影印顾诚未刊手稿《谈治史》。中国国家图书奖，北京市哲学社会科学优秀成果一等奖。明史大家顾诚代表作，读客熊猫君出品。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('6','杀戮季节','杰弗里.B.罗宾逊','100','01#01A#1-6','100','0','0','https://img3m6.ddimg.cn/3/31/29601696-1_w_1689574685.jpg','《金融时报》《外交事务》年度最佳图书，揭秘20世纪最血腥的一段历史，还原印尼大屠杀事件全貌。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('7','新民说·宋神宗与王安石','吴钩','100','01#01A#1-7','100','0','0','https://img3m6.ddimg.cn/31/4/29618356-1_w_1695635054.jpg','看千年前大宋追梦CP如何引爆北宋改革！讲述宋神宗与王安石的跌宕人生 还原熙丰变法波澜壮阔的历史全貌 再现新旧党间激烈的冲突与争斗 彻底读懂这场改革的逻辑与得失！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('8','知行合一王阳明','度阴山','100','01#01A#1-8','100','0','0','https://img3m2.ddimg.cn/95/13/29378642-1_w_1.jpg','心学爱好者经典入门读本，连续7年高居历史畅销榜，获樊登读书等知名媒体推荐！讲述王阳明的辉煌传奇，剖析知行合一的无边威力！度阴山经典力作，入选小米科技创始人雷军书单！读客熊猫君出品。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('9','丝绸之路','彼得·弗兰科潘','99','01#01A#1-9','100','1','0','https://img3m0.ddimg.cn/32/5/24017630-1_w_26.jpg','第十二届文津奖推荐图书！央视10分钟重磅推荐！《人民日报》4度推荐！新浪年度十大好书！牛津大学教授揭示“一带一路”倡议逻辑！第十二届文津图书奖！豆瓣2016年度十大历史好书！读客熊猫君出品。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('10','三星堆之惑','许宏','104','01#01A#1-10','100','8','0','https://img3m8.ddimg.cn/36/16/29422638-1_w_5.jpg','从中原到蜀中，资深考古人许宏的一次“跨域围观”。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('11','三国争霸','渤海小吏','99','01#01A#1-11','100','1','0','https://img3m8.ddimg.cn/68/30/29483258-1_w_5.jpg','14场大战，376个问题，串联起东汉末年与三国的历史，破案式写法，抽丝剥茧寻找三国真相。130多幅地图从地理的角度搞清楚历史的真相。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('12','英法千年争斗史','斯蒂芬·克拉克','100','01#01A#1-12','100','0','0','https://img3m6.ddimg.cn/26/8/29269376-1_u_9.jpg','一部“不太正经”的英法关系史。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('13','南渡北归','岳南','100','01#01A#1-13','100','0','0','https://img3m2.ddimg.cn/44/10/23770142-5_u_4.jpg','纪念西南联大成立八十周年！记述抗战年代学人的艰苦卓绝，再现国难当头大师的风骨典范。岳南两百万言巨著写尽中国上世纪学术大师历程！诺贝尔奖获得者莫言、杨振宁领衔，柳传志、俞敏洪、茅于轼、张鸣等联袂推荐。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('14','大宋侃史官','李飞','99','01#01A#1-14','100','2','0','https://img3m7.ddimg.cn/40/16/29278597-1_w_6.jpg','有趣、有料、有梗， 这是一本初读过瘾，再读醒脑，读完开窍， 可以让你读出大智慧的宋朝历史。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('15','人海之间','杨斌','100','01#01A#1-15','100','0','0','https://img3m9.ddimg.cn/54/10/29624319-1_w_1695004764.jpg','数以万计的中国人曾经到访，但古代中国为何最终失去了印度洋？ 追寻失落在印度洋上的古代中国 美国历史学会古登堡奖获得者 杨斌 重磅新作 北京大学教授荣新江、李伯重 诚挚推荐。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('16','王气黯然：宋元明陕西史','秦晖','100','01#01A#1-16','100','0','0','https://img3m6.ddimg.cn/17/14/29119976-1_w_8.jpg','秦晖著 辽宋夏金元各政权间的关系史和战争史，更是一部各王朝的政治史。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('17','曾国藩的正面与侧面','张宏杰','100','01#01A#1-17','100','0','0','https://img3m4.ddimg.cn/17/11/28983554-1_w_15.jpg','历史学者张宏杰百万畅销经典系列重装升级！全面、立体、深入地解析一代名臣曾国藩的成功之道，在今日官场、职场仍有借鉴意义！以人写史，以史鉴人，再现一个纷繁复杂的晚清时局！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('18','疑案里的中国史','艾公子','99','01#01A#1-18','100','2','0','https://img3m1.ddimg.cn/27/32/29316501-1_w_7.jpg','历史界福尔摩斯，带你探寻中国历史的真相。创全网5亿次阅读量的历史自媒体“爱历史”新作，40个形形色色的历史疑案，40场酣畅淋漓的真相推理。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('19','大秦风云','历史不是僵尸','100','01#01A#1-19','100','0','0','https://img3m4.ddimg.cn/52/8/29364244-1_w_17.jpg','喜马拉雅历史榜NO.1的长期霸榜者！一本容易上头的历史书。千古一帝的生前身后，到底发生了什么事？以一人治天下，必将因一人亡天下？轻松地抓住历史的主要脉络，愉悦地体验历史故事。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('20','大明风云300年','南宫烈','100','01#01A#1-20','100','0','0','https://img3m0.ddimg.cn/15/9/29408460-1_w_10.jpg','讲述原汁原味的明朝历史的诸多细节，深度剖析大明王朝兴衰背后的历史密码，还原一个真实的大明王朝。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('21','中国人史纲','柏杨','99','01#01A#1-21','100','1','0','https://img3m6.ddimg.cn/61/23/28549186-1_w_19.jpg','一部中国人共同的家族史。人性史观、平民视角，不为帝王唱赞歌，只为苍生说人话；世纪纪年，方便理清时间线；中西对照，国际视野下读懂中国史。刘瑜、雷颐、白岩松、倪匡、钱理群推荐。果麦出品。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('22','全球通史','斯塔夫里阿诺斯','100','01#01A#1-22','100','0','0','https://img3m8.ddimg.cn/43/20/9231298-1_w_38.jpg','中国畅销200万册，修订版新增数百幅珍贵的图片和脉络清晰的地图。你将看到一个从来就存在，却被大多数人无视的真实世界。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('23','埃及四千年','乔安·弗莱彻','100','01#01A#1-23','100','0','0','https://img3m9.ddimg.cn/12/30/26917419-3_u_1693377858.jpg','上市7天即告售罄！当当4.23书香节读者*爱的人文社科类榜首图书！BBC古埃及历史纪录片原著主宰世界历史进程的宏大史诗《出版人周刊》《科克斯书评》2016年度图书《华盛顿邮报》等30家知名媒体联名推荐。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('24','第三帝国的兴亡','威廉·夏伊勒','100','01#01A#1-24','100','0','0','https://img3m7.ddimg.cn/81/3/28526337-1_w_14.jpg','还原比小说更狂野的历史真相！200张珍贵历史照片，8张二战拉页地图，历史场景全景式真实展现。附录大事年表、纳粹德国政府架构、主要人物小传。8张地图和人物小传为当当精装版专有。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('25','大英博物馆世界简史','尼尔·麦格雷戈','100','01#01A#1-25','100','0','0','https://img3m5.ddimg.cn/93/28/25178565-1_w_7.jpg','大英博物馆馆长亲自撰写，大英博物馆、BBC历时4年联手打造！同名展览在国家博物馆、上海博物馆展出，人均排队4小时！超大开本，全彩印刷，典藏精装。随书附赠导览图1份。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('26','现代中国的形成','李怀印','100','01#01A#1-26','100','0','0','https://img3m6.ddimg.cn/13/8/29361136-1_w_1691383500.jpg','一部视野宏大、新见迭出的中国近现代史著作。 今天的中国究竟从何而来？本书聚焦地缘政治、财政构造和政治认同三个因素，全面论述十七至二十世纪现代中国的形成过程，在世界历史的视野下探寻现代中国形成的独特路径。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('27','黄河变迁史','岑仲勉','100','01#01A#1-27','100','1','0','https://img3m6.ddimg.cn/33/15/29382936-2_u_5.jpg','华章大历史30：著名史学家岑仲勉先生代表作，被誉为“系统研究黄河问题的一部巨著”。李约瑟、河野通博等备加称誉的大师经典。中华民族治河史，也是一部治国史！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('28','青年变革者','许知远','100','01#01A#1-28','100','0','0','https://img3m2.ddimg.cn/33/27/27862692-1_w_12.jpg','十三邀、吐槽大会、单向街，许知远多栖尝试不忘作家本心；5年积淀，回访历史现场，状摹梁启超的希望与挫败，复活时代细节与情绪；许倬云、李欧梵、葛兆光、马勇联袂推荐。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('29','犹太人三千年简史','雷蒙德·P.谢德林','29','01#01A#1-29','100','0','0','https://img3m8.ddimg.cn/81/26/28972728-1_w_3.jpg','一部透解犹太历史、畅销海外二十余年的经典之作，带你穿越犹太人三千年的生活与历史，深度了解犹太民族的苦难与繁荣。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('30','乡土中国','费孝通','30','01#01A#1-30','100','0','0','https://img3m9.ddimg.cn/41/30/23678069-1_w_8.jpg','费孝通著作 高中“读整本书”推荐阅读 （名著阅读课程化丛书） 学界共认的中国乡土社会传统文化和社会结构理论研究的代表作。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('31','始于极限','上野千鹤子','31','01#01A#1-31','100','0','0','https://img3m6.ddimg.cn/38/16/29458676-1_w_16.jpg','豆瓣年度图书，知名女性学研究者×叛逆人气作家：一场始于矛盾与冲突、通往理解与改变的对话，围绕成长、母女关系、男人、工作与独立等12大主题畅谈女性的纠葛与困惑：如何在厌女社会自在地生活？');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('32','陆上行舟','刘骁骞','32','01#01A#1-32','100','0','0','https://img3m2.ddimg.cn/75/21/29159832-1_w_11.jpg','凭借一线报道被称作美国骚乱中 “一个熟悉的中国人”打入巴西贩毒集团内部，探营哥伦比亚反政府游击队，在丛林中险遭夜袭驻外十年，著名记者刘骁骞首次曝光采访幕后，用一段段生死旅途汇成深度调查实战手册。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('33','自由在高处','熊培云','33','01#01A#1-33','100','0','0','https://img3m0.ddimg.cn/94/2/29423290-1_w_15.jpg','文津奖得主熊培云致敬自由之作，十周年纪念版重磅呈现！新增八万字，十年沉淀，献给忧郁赤诚的灵魂。要么成为自己，要么一无所成！一部让年轻人成为自己的启蒙书，超越逆境、积极生活，在成长中寻找意义与自我。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('34','小镇喧嚣','吴毅','34','01#01A#1-34','100','0','0','https://img3m0.ddimg.cn/11/13/25220360-1_w_1695368980.jpg','一部比小说还要精彩的学术作品（以迎检、开发、收税、征地、维权等鲜活故事，讲述基层政权、村级组织和农民的博弈共生）。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('35','看不见的女性','卡罗琳·克里亚多','35','01#01A#1-35','100','0','0','https://img3m1.ddimg.cn/88/18/29433481-1_w_18.jpg','“掌握数据的波伏瓦”荃方位揭露遍布日常的隐形歧视，中国社会心理学会年度推荐，得到年度图书！珍妮特·温特森力荐：这本书没有咆哮，只有事实和数字。告诉我父权制是想象出来的之前，请你先读读这本书。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('36','县乡中国','杨华','36','01#01A#1-36','100','0','0','https://img3m3.ddimg.cn/76/28/29403373-1_w_27.jpg','通过《县委大院》沉浸式解读《县乡中国》，了解县官如何治县？房宁、贺雪峰、陈文胜、颜昌武、吕德文、欧阳静联袂推荐，一本剖析县乡政治生态的白描书，深描中国政治的实际运行。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('37','中国社会各阶层分析','梁晓声','37','01#01A#1-37','100','0','0','https://img3m1.ddimg.cn/43/3/29240881-1_w_30.jpg','茅盾文学奖作品《人世间》作者梁晓声加印50余次的经典代表作，内容完整精装增订版；识社会，明规则，彻底读懂中国！助你于社会中保持清醒，在人世间进退自如！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('38','教育的情调','马克斯·范梅南','38','01#01A#1-38','100','0','0','https://img3m9.ddimg.cn/7/25/28510819-1_w_4.jpg','入选中国教育新闻网2019年度“影响教师的100本书”，入选中国教育报“受教师喜爱的100本书”。作者范梅南和李树英向我们展示了一个关心孩子和爱孩子的教育者应有的样子：关注孩子的独特之处。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('39','文字的奥秘','杨一铎','39','01#01A#1-39','100','0','0','https://img3m6.ddimg.cn/18/8/28517166-1_w_3.jpg','选取了80个描述自然景物、动植物、人体、人的生活、人文景观以及文化知识等的基本汉字，以有趣的笔调叙述了它们产生、发展的演变历史，使读者能在轻松的阅读中对我们日常使用的汉字有一个全新、深刻的认识。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('40','幻象','丹尼尔·布尔斯廷','40','01#01A#1-40','100','0','0','https://img3m1.ddimg.cn/59/18/29595911-1_w_1690277655.jpg','流行文化研究开山之作，豆瓣原版9.7分，启发《娱乐至死》《景观社会》《消费社会》。普利策奖得主全面剖析流行文化和大众传媒，让你不被愚弄的清醒指南，在流量时代，打破幻象，认清真相。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('41','学习的本质','安德烈·焦尔当','41','01#01A#1-41','100','0','0','https://img3m5.ddimg.cn/48/32/23742525-1_w_1.jpg','人究竟是如何学习的？怎样才能有效促进学习？联合国教科文组织特别顾问安德烈·焦尔当带你探索学习复杂性的奥秘。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('42','大国大城','陆铭','42','01#01A#1-42','100','0','0','https://img3m6.ddimg.cn/66/15/28992216-1_w_7.jpg','第十二届文津图书奖获奖图书，入围2016年中国好书，罗辑思维节目推荐。基于本土实证，以经济视角谏言社会问题，著名经济学家的反成见、聚共识之作。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('43','好的教育','鲍鹏山','43','01#01A#1-43','100','0','0','https://img3m2.ddimg.cn/63/26/29351682-1_w_13.jpg','樊登大力推荐！教师用书参考，家庭教育认知升级。好的教育可以唤醒孩子的生命力，提升其价值判断力和审美鉴赏力，使其成为一个有道德认知和社会责任感的人。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('44','四十而惑','艾达','44','01#01A#1-44','100','0','0','https://img3m2.ddimg.cn/67/15/29556022-2_u_1688460972.jpg','未读·思想家|亚马逊2020年非虚构类图书；《纽约时报》编辑之选。用幽默的叙述呈现一代女性共有的中年危机，揭示危机背后的政治、经济、文化因素。我们的选择只是故事的其中一面，时代背景是另一面。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('45','权力精英','C.赖特·米尔斯','45','01#01A#1-45','100','0','0','https://img3m3.ddimg.cn/0/8/27947403-3_u_10.jpg','20世纪重要的100本社会学著作！赖特·米尔斯犀利地揭示出，精英掌握了平民百姓无法想象的权力与财富，启发读者思考身处的社会！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('46','惊呆了！原来这就是社会学','田中正人','46','01#01A#1-46','100','0','0','https://img3m8.ddimg.cn/54/9/29228418-1_u_6.jpg','《惊呆了！哲学这么好》系列作品：一本人人都能读的社会学入门指南！清华大学副教授严飞、华中师范大学教授李钧鹏力荐！超萌漫画解析，干货满满！！带你走出混沌的日常，理解社会与人生。赠社会学家可爱书签贴纸。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('47','要命还是要灵魂','安妮·法迪曼','47','01#01A#1-47','100','0','0','https://img3m8.ddimg.cn/27/24/29500938-1_w_7.jpg','斯坦福、耶鲁、伦敦、约翰斯霍普金斯等50多所大学推荐阅读书目。东方苗族巫术与现代医学的角力，一部独特的在美苗族民族志。当文化的藩篱成为冲突的起点，命与灵魂的二选一之外，是否有新的可能？');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('48','决战朝鲜','李峰','48','01#01A#1-48','100','0','0','https://img3m7.ddimg.cn/18/4/25120377-1_w_17.jpg','致敬伟大的抗美援朝精神！中国人民是惹不得的！畅销30万册，戴旭、萨苏、方军、乔良、王湘穗推荐！全景式再现朝鲜战争，揭开朝战台前幕后隐秘历史，人大附中、北大附中推荐图书！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('49','这才是战争：将略','王正兴','49','01#01A#1-49','100','0','0','https://img3m1.ddimg.cn/51/4/29557491-2_u_3.jpg','新华社瞭望智库特约军事观察员、历史大V“这才是战争”，从军队部署、协同、指挥、行动、后勤、地缘、政治、经济等多角度出发，复盘中国古代经典战争！搭配地图专家李不白绘制的26幅全彩印刷历史地形图，兵要地理。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('50','第二次世界大战回忆录','温斯顿·丘吉尔','50','01#01A#1-50','100','0','0','https://img3m5.ddimg.cn/78/28/25219635-1_w_1693381672.jpg','政治家、文学家、演讲家丘吉尔全景式历史巨著，解密揭秘二战鲜为人知的政治、军事内幕，文笔优美，揭露你所不知的二战内幕。1953年诺贝尔奖获奖作品，附赠经典丘吉尔海报！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('51','上甘岭','聂济峰','51','01#01A#1-51','100','0','0','https://img3m8.ddimg.cn/23/20/25574198-1_w_6.jpg','央视“回声嘹亮”致敬《我的祖国》，深情讲述《上甘岭》背后的故事！这里记录着历史，这里记录着英雄。——上甘岭战役全景录。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('52','中国人民解放军简史','中国人民解放军国防大','52','01#01A#1-52','100','0','0','https://img3m7.ddimg.cn/87/21/25086687-4_u_9.jpg','一本就够——“军迷”入门军史大揭秘:主旋律书籍新热点，建军90周年必看书目,国防大学组织编著，将军专家团合力编写。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('53','决胜：解放战争何以胜利','罗平汉','53','01#01A#1-53','100','0','0','https://img3m6.ddimg.cn/58/19/29464636-1_w_9.jpg','一本有助于理解“以史为镜、以史明志、知史爱党、知史爱国”精神的党史读本。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('54','战上海','刘统','54','01#01A#1-54','100','0','0','https://img3m8.ddimg.cn/47/10/26435918-1_w_18.jpg','五个一工程特别奖 2018年度中国好书；“四史”学习热卖读物；党史军史专家刘统全新原创力作；新老版本随机发货；重现档案里的历史，还原1949—1950年“大上海解放史”；惊心动魄的历史真实，“战上海”。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('55','大汗之怒','周思成','55','01#01A#1-55','100','0','0','https://img3m7.ddimg.cn/67/33/27850747-1_w_5.jpg','元朝征伐日本小史。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('56','抗战家书','中国人民抗日战争纪念','56','01#01A#1-56','100','0','0','https://img3m3.ddimg.cn/28/28/29285713-1_w_2.jpg','我们先辈的抗战记忆（纪念世界反法西斯战争胜利70周年）。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('57','西游记','吴承恩','54','01#01A#1-57','100','3','0','https://img3m0.ddimg.cn/63/36/23992020-1_w_15.jpg','四大名著之一，讲述了唐僧师徒四人西天取经的故事。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('58','红楼梦','曹雪芹','58','01#01A#1-58','100','0','0','https://img3m1.ddimg.cn/9/22/102771-1_w_1691995673.jpg','四大名著之一，描绘了贾、王、史、薛四大家族的兴衰，以及宝黛钗的爱情悲剧。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('59','三国演义','罗贯中','59','01#01A#1-59','100','0','0','https://img3m7.ddimg.cn/60/33/23992017-1_w_13.jpg','四大名著之一，描写了从东汉末年到西晋初年的历史风云。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('60','水浒传','施耐庵','60','01#01A#1-60','100','0','0','https://img3m8.ddimg.cn/61/34/23992018-1_w_11.jpg','四大名著之一，讲述了宋江领导的梁山好汉反抗官府的故事。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('61','现代性','汪民安','61','01#01A#1-61','100','0','0','https://img3m7.ddimg.cn/27/32/28554597-1_w_3.jpg','清华大学教授写给大众认识“现代性”的入门小书。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('62','中国现代思想史论','李泽厚','62','01#01A#1-62','100','0','0','https://img3m5.ddimg.cn/30/1/29390655-1_w_1.jpg','李泽厚经典的中国思想史“三论”之一，历数五四以来的中国知识分子，如何在“救亡与启蒙”的双重变奏中，探寻中国未来的道路。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('63','故国人民有所思','陈徒手','63','01#01A#1-63','100','0','0','https://img3m3.ddimg.cn/1/22/23247973-1_w_4.jpg','1949年后知识分子思想改造侧影。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('64','心学的诞生','郦波','64','01#01A#1-64','100','0','0','https://img3m7.ddimg.cn/45/30/11466097677-1_u_1690271705.jpg','王阳明心学知行合一，王阳明在黔悟道讲学经历。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('65','哲学简史','伯特兰·罗素','65','01#01A#1-65','100','0','0','https://img3m2.ddimg.cn/69/16/29171112-1_w_7.jpg','听诺奖得主罗素聊哲学大师们的智慧精髓。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('66','我的哲学提纲','李泽厚','66','01#01A#1-66','100','0','0','https://img3m9.ddimg.cn/17/27/28552409-1_w_4.jpg','哲学和美学大师李泽厚代表作。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('67','哲学原来这么有趣','王禹栋','67','01#01A#1-67','100','0','0','https://img3m6.ddimg.cn/30/13/29500446-1_w_6.jpg','乔布斯、马斯克、牛顿等人都懂的哲学思维。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('68','哲学的故事','威尔·杜兰特','64','01#01A#1-68','100','6','0','https://img3m0.ddimg.cn/86/11/28963130-1_w_4.jpg','杜威、季羡林、周国平推崇的哲学大师代表作。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('69','惊呆了！哲学这么好','田中正人','69','01#01A#1-69','100','0','0','https://img3m3.ddimg.cn/41/17/25230983-1_w_3.jpg','超萌的哲学入门书，看漫画秒懂深奥的哲学。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('70','测试图书','测试','70','01#01A#1-70','100','0','0','http://localhost:9000/VMek6MgBBk1YlTdI9fjnp.png','测试，以便后续调试。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('71','黄帝内经全集','肖建喜','71','01#01A#1-71','100','0','0','https://img3m1.ddimg.cn/59/21/28508891-1_b_3.jpg','抗击肺炎，增强抵抗力，可以跟着《黄帝内经》学养生！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('72','抗炎生活','池谷敏郎','72','01#01A#1-72','100','0','0','https://img3m9.ddimg.cn/71/3/29386439-1_w_22.jpg','抑郁症、糖尿病、哮喘、心脏病、癌症、阿尔茨海默病……都与慢性炎症有关。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('73','真原医','杨定一','73','01#01A#1-73','100','0','0','https://img3m5.ddimg.cn/13/29/29235505-1_u_1688105068.jpg','2022年首都科普好书榜TOP1，新华网、演员张静初、主持人朱丹联袂推荐！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('74','脑雾修复','麦克·道','74','01#01A#1-74','100','0','0','https://img3m2.ddimg.cn/20/3/29434502-1_w_12.jpg','熟悉的事情转头就忘？感觉抑郁，无法入睡？变得焦躁，无法专心？');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('75','饮食滋味','徐文兵','75','01#01A#1-75','100','0','0','https://img3m9.ddimg.cn/4/23/25221739-1_w_10.jpg','在吃饭这件事情上，更应该相信人的本能，以人为本。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('76','求医不如求己','中里巴人','76','01#01A#1-76','100','0','0','https://img3m5.ddimg.cn/33/9/24168705-1_w_17.jpg','全新多媒体健康书，有图有视频，中里巴人老师亲自出镜示范经络穴位养生方法。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('77','女性养生三步走','罗大伦','77','01#01A#1-77','100','0','0','https://img3m4.ddimg.cn/31/9/26436694-1_w_18.jpg','女性90%的病都是憋出来的，罗博士专为女性打造的养生经。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('78','图解舌诊','罗大伦','78','01#01A#1-78','100','0','0','https://img3m7.ddimg.cn/45/22/25271577-1_w_10.jpg','一本书教你随时发现疾病征兆，改善体质。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('79','轻断食','麦克尔·莫斯利','79','01#01A#1-79','100','0','0','https://img3m4.ddimg.cn/31/3/27878134-1_w_9.jpg','轻断食横扫世界各大榜单，畅销美国、英国、日本、法国、意大利……');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('80','黄帝内经四季养生法','徐文兵','80','01#01A#1-80','100','0','0','https://img3m0.ddimg.cn/18/26/27921780-1_w_2.jpg','在衣食住行中汲取传统中医文化精髓，尽得自然养生之法。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('81','非药而愈','徐嘉','81','01#01A#1-81','100','0','0','https://img3m9.ddimg.cn/23/6/25581029-5_u_6.jpg','美国责任医师协会临床营养学专家、约翰霍普金斯大学医学院生理学博士心血力作！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('82','神农本草经','图解经典','82','01#01A#1-82','100','0','0','https://img3m3.ddimg.cn/42/35/25126143-1_u_6.jpg','畅销11年，全新修订升级版，全系列销量突破百万册！');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('83','人生没什么不可放下','宋默','83','01#01A#1-83','100','0','0','https://img3m3.ddimg.cn/64/12/23394853-1_w_37.jpg','弘一法师的人生智慧。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('84','被讨厌的勇气','岸見一郎','84','01#01A#1-84','100','0','0','https://img3m2.ddimg.cn/33/26/28518072-3_u_6.jpg','自我启发之父”阿德勒的哲学课。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('85','允许一切发生','李梦霁','85','01#01A#1-85','100','0','0','https://img3m1.ddimg.cn/67/4/29560081-4_u_7.jpg','《一生欠安》作者全新力作。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('86','认知觉醒','周岭','86','01#01A#1-86','100','0','0','https://img3m4.ddimg.cn/73/20/29119834-1_u_13.jpg','通过元认知改变大脑的顽固思维，深度学习认知规律。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('87','人间值得','中村恒子','87','01#01A#1-87','100','0','0','https://img3m6.ddimg.cn/39/17/27931206-1_w_582.jpg','宝藏奶奶的人生36条感悟。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('88','遇见未知的自己','张德芬','88','01#01A#1-88','100','0','0','https://img3m4.ddimg.cn/87/11/28486644-4_u_13.jpg','张德芬畅销800万册的都市个人成长修行代表作。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('89','秘密','朗达·拜恩','89','01#01A#1-89','100','0','0','https://img3m7.ddimg.cn/55/10/25257727-1_u_3.jpg','经典身心灵励志读物，为人生带来喜悦转变的能量之书。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('90','这世界很好，但你也不差','万特特','90','01#01A#1-90','100','0','0','https://img3m6.ddimg.cn/90/34/29272806-1_w_48.jpg','用“这世界很好但我也不差”的自信VS “生而为人我很抱歉”的软弱。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('91','人生哪能多如意','李叔同','91','01#01A#1-91','100','0','0','https://img3m7.ddimg.cn/38/9/29419967-1_u_8.jpg','人生多艰，不如意事常八九，如何坦然面对生活中的得与失。');
INSERT INTO `book` (`bookId`,`bookName`,`author`,`amount`,`position`,`totalAmount`,`borrowedTimes`,`status`,`bookImage`,`bookDescription`)  VALUES ('92','我越来越喜欢自己了','燕七','92','01#01A#1-92','100','0','0','https://img3m9.ddimg.cn/9/35/29553489-1_w_4.jpg','一个人的乐观和热情，才是疲惫生活的解药。');
-- ----------------------------
-- Table structure for table borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `readerId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `borrowDate` datetime NOT NULL,
  `returnDate` datetime DEFAULT NULL,
  `realDate` datetime DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`readerId`,`bookId`,`borrowDate`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` (`readerId`,`bookId`,`borrowDate`,`returnDate`,`realDate`,`status`)  VALUES ('w4rX_K9scoscT1IV4uvzo','57','2025-02-23 22:33:00','2025-03-23 22:33:00','9999-12-31 00:00:00','已续借');
INSERT INTO `borrow` (`readerId`,`bookId`,`borrowDate`,`returnDate`,`realDate`,`status`)  VALUES ('w4rX_K9scoscT1IV4uvzo','68','2025-02-23 22:32:48','2025-03-23 22:32:48','9999-12-31 00:00:00','未还');
INSERT INTO `borrow` (`readerId`,`bookId`,`borrowDate`,`returnDate`,`realDate`,`status`)  VALUES ('w4rX_K9scoscT1IV4uvzo','5','2025-02-23 22:32:51','2025-03-23 22:32:51','2025-02-23 22:32:56','已还');
INSERT INTO `borrow` (`readerId`,`bookId`,`borrowDate`,`returnDate`,`realDate`,`status`)  VALUES ('mZMalP5bd-ejEl2lcTVfz','5','2025-02-23 22:40:25','2025-03-23 22:40:25','9999-12-31 00:00:00','已续借');
-- ----------------------------
-- Table structure for table comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `commentId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `readerId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `date` datetime DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `praise` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`commentId`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
-- ----------------------------
-- Table structure for table reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader` (
  `readerId` varchar(50) NOT NULL,
  `readerName` varchar(10) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `borrowTimes` bigint DEFAULT NULL,
  `ovdTimes` bigint DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png',
  `gender` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`readerId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader` (`readerId`,`readerName`,`password`,`phone`,`borrowTimes`,`ovdTimes`,`email`,`avatar`,`gender`)  VALUES ('mZMalP5bd-ejEl2lcTVfz','fxr','675a3867bd36ed867d480551c1000dc4','17634536858','3','0','17634536858@qq.com','','');
-- ----------------------------
-- Table structure for table report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `commentId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reporterId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reportdate` datetime NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`reportdate`,`reporterId`,`commentId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of report
-- ----------------------------
-- ----------------------------
-- Table structure for table reserve
-- ----------------------------
DROP TABLE IF EXISTS `reserve`;
CREATE TABLE `reserve` (
  `readerId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`readerId`,`bookId`,`date`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of reserve
-- ----------------------------
INSERT INTO `reserve` (`readerId`,`bookId`,`date`,`status`)  VALUES ('mZMalP5bd-ejEl2lcTVfz','18','2025-02-23 22:40:10','已预约');
INSERT INTO `reserve` (`readerId`,`bookId`,`date`,`status`)  VALUES ('mZMalP5bd-ejEl2lcTVfz','5','2025-02-23 22:40:07','已借阅');
SET FOREIGN_KEY_CHECKS=1;
-- ----------------------------
-- View structure for view borrowinfo
-- ----------------------------
DROP VIEW IF EXISTS `borrowinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `borrowinfo` AS select `borrow`.`readerId` AS `readerId`,`book`.`bookId` AS `bookId`,`reader`.`readerName` AS `readerName`,`book`.`bookName` AS `bookName`,`borrow`.`borrowDate` AS `borrowDate`,`borrow`.`returnDate` AS `returnDate`,`borrow`.`realDate` AS `realDate` from ((`borrow` left join `reader` on((`borrow`.`readerId` = `reader`.`readerId`))) left join `book` on((`borrow`.`bookId` = `book`.`bookId`)));


-- ----------------------------
-- View structure for view reportinfo
-- ----------------------------
DROP VIEW IF EXISTS `reportinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `reportinfo` AS select `a`.`status` AS `status`,`a`.`commentId` AS `commentId`,`a`.`reporterId` AS `reporterId`,`a`.`reportdate` AS `reportdate`,`b`.`readerId` AS `readerId`,`reader`.`readerName` AS `readerName`,`b`.`bookId` AS `bookId`,`book`.`bookName` AS `bookName`,`b`.`date` AS `date`,`b`.`content` AS `content` from (((`report` `a` left join `comment` `b` on((`a`.`commentId` = `b`.`commentId`))) left join `reader` on((`b`.`readerId` = `reader`.`readerId`))) left join `book` on((`b`.`bookId` = `book`.`bookId`)));


