/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `guild_shops`
--

DROP TABLE IF EXISTS `guild_shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_shops` (
  `guildid` smallint(5) unsigned NOT NULL,
  `itemid` smallint(5) unsigned NOT NULL,
  `min_price` int(10) unsigned NOT NULL DEFAULT '0',
  `max_price` int(10) unsigned NOT NULL DEFAULT '0',
  `max_quantity` smallint(5) unsigned NOT NULL DEFAULT '0',
  `daily_increase` smallint(5) unsigned NOT NULL DEFAULT '0',
  `initial_quantity` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`itemid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_shops`
--
-- ORDER BY:  `guildid`,`itemid`
--
-- Old commment:
-- To cope with the current 30 item limit, I have added in every single item entry according to Blue Gartyr Wiki
-- I then chose the 30 most important items I could think of for each vendor, and commented out the rest for now.
-- I did my best to put all the daily restocks on 1 vendor, and the non-restocks on the other.
-- This should leave ~60 items for each guild, for now. I think this will be enough to make most happy.
-- When the cap is lifted, all you will have to do is remove the comments and make the (S) vendors the same ID and it will display 100% of the item lists

-- The above 30 item limit no longer exists..

-- Chaupire (Northern San d'Oria) Woodworking Guild (S)
INSERT INTO `guild_shops` VALUES (5132,3,295500,295500,20,0,3);
INSERT INTO `guild_shops` VALUES (5132,22,282,691,20,0,20);
INSERT INTO `guild_shops` VALUES (5132,23,829,2035,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,24,70200,408096,20,0,3);
INSERT INTO `guild_shops` VALUES (5132,26,31500,31500,20,0,6);
INSERT INTO `guild_shops` VALUES (5132,92,738,2322,20,0,10);
INSERT INTO `guild_shops` VALUES (5132,97,5508,13512,20,0,12);
INSERT INTO `guild_shops` VALUES (5132,102,291,713,25,0,25);
INSERT INTO `guild_shops` VALUES (5132,688,15,28,255,0,100);            -- arrowwood_log
INSERT INTO `guild_shops` VALUES (5132,689,27,59,255,0,100);            -- lauan_log
INSERT INTO `guild_shops` VALUES (5132,690,1378,10938,255,48,100);      -- elm_log
INSERT INTO `guild_shops` VALUES (5132,691,45,276,255,0,100);           -- maple_log
INSERT INTO `guild_shops` VALUES (5132,693,640,3586,255,48,100);        -- walnut_log
INSERT INTO `guild_shops` VALUES (5132,694,2119,2811,165,33,65);        -- chestnut_log
INSERT INTO `guild_shops` VALUES (5132,695,120,132,255,48,100);         -- willow_log
INSERT INTO `guild_shops` VALUES (5132,696,330,699,255,48,100);         -- yew_log
INSERT INTO `guild_shops` VALUES (5132,697,528,930,255,48,100);         -- holly_log
INSERT INTO `guild_shops` VALUES (5132,698,72,122,255,48,100);          -- ash_log
INSERT INTO `guild_shops` VALUES (5132,699,4740,24016,165,33,65);       -- oak_log
INSERT INTO `guild_shops` VALUES (5132,700,9075,19844,165,33,65);       -- mahogany_log
INSERT INTO `guild_shops` VALUES (5132,701,6615,37044,165,33,65);       -- rosewood_log
INSERT INTO `guild_shops` VALUES (5132,702,9600,23040,165,33,65);       -- ebony_log
INSERT INTO `guild_shops` VALUES (5132,704,96,230,375,100,150);         -- bamboo_stick
INSERT INTO `guild_shops` VALUES (5132,705,3,18,255,48,100);            -- arrowwood_lbr.
INSERT INTO `guild_shops` VALUES (5132,706,27,151,255,48,100);          -- lauan_lumber
INSERT INTO `guild_shops` VALUES (5132,707,1723,4136,255,48,100);       -- elm_lumber
INSERT INTO `guild_shops` VALUES (5132,708,45,276,255,48,100);          -- maple_lumber
INSERT INTO `guild_shops` VALUES (5132,710,2119,6104,165,33,65);        -- chestnut_lumber
INSERT INTO `guild_shops` VALUES (5132,711,1015,3982,100,0,100);        -- walnut_lumber
INSERT INTO `guild_shops` VALUES (5132,712,120,256,255,48,100);         -- willow_lumber
INSERT INTO `guild_shops` VALUES (5132,713,330,836,255,48,100);         -- yew_lumber
INSERT INTO `guild_shops` VALUES (5132,714,607,2559,255,48,100);        -- holly_lumber
INSERT INTO `guild_shops` VALUES (5132,715,72,403,255,48,100);          -- ash_lumber
INSERT INTO `guild_shops` VALUES (5132,716,4740,23257,165,33,65);       -- oak_lumber
INSERT INTO `guild_shops` VALUES (5132,719,23552,25216,165,0,65);       -- ebony_lumber
INSERT INTO `guild_shops` VALUES (5132,12289,88,232,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,12290,847,1173,20,0,10);
INSERT INTO `guild_shops` VALUES (5132,12984,176,280,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,12985,1625,1625,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,12986,6885,17625,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,12987,38707,38707,20,0,3);
INSERT INTO `guild_shops` VALUES (5132,16832,194,201,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,16833,809,4294,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,16834,6448,25376,20,0,10);
INSERT INTO `guild_shops` VALUES (5132,16835,27165,34750,20,0,3);
INSERT INTO `guild_shops` VALUES (5132,16845,31314,34445,20,0,3);
INSERT INTO `guild_shops` VALUES (5132,17024,48,141,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,17025,1165,5707,20,0,10);
INSERT INTO `guild_shops` VALUES (5132,17027,7525,21003,20,0,5);
INSERT INTO `guild_shops` VALUES (5132,17030,14766,41876,20,0,3);
INSERT INTO `guild_shops` VALUES (5132,17049,34,102,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,17050,247,703,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,17051,1049,3038,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,17052,3827,19420,20,0,10);
INSERT INTO `guild_shops` VALUES (5132,17088,46,126,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,17089,424,977,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,17090,3371,7103,20,0,15);
INSERT INTO `guild_shops` VALUES (5132,17095,281,1260,20,0,15);         -- ash_pole
INSERT INTO `guild_shops` VALUES (5132,17096,3400,23349,20,0,15);       -- holly_pole
INSERT INTO `guild_shops` VALUES (5132,17097,22617,35932,20,0,15);      -- elm_pole
INSERT INTO `guild_shops` VALUES (5132,17098,29390,72633,20,0,3);       -- oak_pole
INSERT INTO `guild_shops` VALUES (5132,17152,41,202,20,0,15);           -- shortbow
INSERT INTO `guild_shops` VALUES (5132,17153,1039,1055,20,0,15);        -- self_bow
INSERT INTO `guild_shops` VALUES (5132,17154,15602,38649,20,0,10);      -- wrapped_bow
INSERT INTO `guild_shops` VALUES (5132,17155,5625,16875,20,0,5);        -- composite_bow
INSERT INTO `guild_shops` VALUES (5132,17156,82971,82971,20,0,3);       -- kaman
INSERT INTO `guild_shops` VALUES (5132,17160,870,969,20,0,15);          -- longbow
INSERT INTO `guild_shops` VALUES (5132,17162,14614,42969,20,0,10);      -- great_bow
INSERT INTO `guild_shops` VALUES (5132,17163,28944,82080,20,0,5);       -- battle_bow
INSERT INTO `guild_shops` VALUES (5132,17164,57405,166219,20,0,3);      -- war_bow
INSERT INTO `guild_shops` VALUES (5132,17216,187,354,20,0,15);          -- light_crossbow
INSERT INTO `guild_shops` VALUES (5132,17218,10311,67100,20,0,10);      -- zamburak
INSERT INTO `guild_shops` VALUES (5132,17280,1172,5250,20,0,15);        -- boomerang
INSERT INTO `guild_shops` VALUES (5132,17318,6,13,8910,48,3564);        -- wooden_arrow
INSERT INTO `guild_shops` VALUES (5132,17320,10,14,5940,0,2376);        -- iron_arrow
INSERT INTO `guild_shops` VALUES (5132,17321,28,34,2970,0,1188);        -- silver_arrow
INSERT INTO `guild_shops` VALUES (5132,17345,69,163,20,0,15);           -- flute
INSERT INTO `guild_shops` VALUES (5132,17347,1028,5060,20,0,15);        -- piccolo
INSERT INTO `guild_shops` VALUES (5132,17348,11256,32592,20,0,10);      -- traversiere
INSERT INTO `guild_shops` VALUES (5132,17353,37,94,20,0,15);            -- maple_harp
INSERT INTO `guild_shops` VALUES (5132,17354,4300,12200,20,0,10);       -- harp
INSERT INTO `guild_shops` VALUES (5132,17355,13400,38800,20,0,5);       -- rose_harp
INSERT INTO `guild_shops` VALUES (5132,17424,7717,20685,20,0,3);        -- spiked_club

-- Shih Tayuun (Bonecraft Guild) Windurst Woods (S)
INSERT INTO `guild_shops` VALUES (514,864,72,288,255,48,100);
INSERT INTO `guild_shops` VALUES (514,880,70,349,255,48,100);
INSERT INTO `guild_shops` VALUES (514,881,3469,11306,55,0,22);
INSERT INTO `guild_shops` VALUES (514,882,150,760,255,48,100);
INSERT INTO `guild_shops` VALUES (514,884,3741,12177,165,0,65);
INSERT INTO `guild_shops` VALUES (514,885,21840,74256,30,0,12);
INSERT INTO `guild_shops` VALUES (514,888,90,90,255,48,100);
INSERT INTO `guild_shops` VALUES (514,889,380,510,80,0,32);
INSERT INTO `guild_shops` VALUES (514,893,1766,4669,80,0,32);
INSERT INTO `guild_shops` VALUES (514,894,968,2952,165,0,65);
INSERT INTO `guild_shops` VALUES (514,895,3060,15560,55,0,22);
INSERT INTO `guild_shops` VALUES (514,896,2044,12166,80,0,32);
INSERT INTO `guild_shops` VALUES (514,897,1588,6683,80,0,32);
INSERT INTO `guild_shops` VALUES (514,898,163,163,375,0,150);
INSERT INTO `guild_shops` VALUES (514,2130,75,75,255,48,100);
INSERT INTO `guild_shops` VALUES (514,12414,11377,37771,20,0,5);
INSERT INTO `guild_shops` VALUES (514,12454,3912,17525,20,0,20);
INSERT INTO `guild_shops` VALUES (514,12455,5728,32079,20,5,10);
INSERT INTO `guild_shops` VALUES (514,12505,336,389,20,0,20);
INSERT INTO `guild_shops` VALUES (514,12506,4500,16350,20,0,15);
INSERT INTO `guild_shops` VALUES (514,12507,12825,83448,20,0,10);
INSERT INTO `guild_shops` VALUES (514,12582,11507,30011,20,0,20);
INSERT INTO `guild_shops` VALUES (514,12583,12246,49455,20,0,15);
INSERT INTO `guild_shops` VALUES (514,12710,2448,14231,20,0,20);
INSERT INTO `guild_shops` VALUES (514,12711,4653,25312,20,0,15);
INSERT INTO `guild_shops` VALUES (514,12834,6588,11106,20,0,20);
INSERT INTO `guild_shops` VALUES (514,12835,16956,54265,20,0,15);
INSERT INTO `guild_shops` VALUES (514,12837,170016,225456,20,0,5);
INSERT INTO `guild_shops` VALUES (514,12966,7722,14493,20,0,20);
INSERT INTO `guild_shops` VALUES (514,12967,18447,27659,20,0,15);
INSERT INTO `guild_shops` VALUES (514,13076,2938,4464,20,0,15);      -- fang_necklace
INSERT INTO `guild_shops` VALUES (514,13090,7188,8869,20,0,10);      -- beetle_gorget
INSERT INTO `guild_shops` VALUES (514,13091,29568,106260,20,0,5);    -- carapace_gorget
INSERT INTO `guild_shops` VALUES (514,13313,565,807,20,0,20);        -- shell_earring
INSERT INTO `guild_shops` VALUES (514,13321,1359,7900,20,0,15);      -- bone_earring
INSERT INTO `guild_shops` VALUES (514,13323,15408,15408,20,0,10);    -- beetle_earring
INSERT INTO `guild_shops` VALUES (514,13324,38565,38565,20,0,5);     -- tortoise_earring
INSERT INTO `guild_shops` VALUES (514,13441,1359,1395,20,0,15);      -- bone_ring
INSERT INTO `guild_shops` VALUES (514,13442,565,807,20,0,20);        -- shell_ring
INSERT INTO `guild_shops` VALUES (514,13457,2650,2721,20,0,10);      -- beetle_ring
INSERT INTO `guild_shops` VALUES (514,13458,14175,61992,20,0,3);     -- scorpion_ring
INSERT INTO `guild_shops` VALUES (514,13459,7200,8832,20,0,5);       -- horn_ring
INSERT INTO `guild_shops` VALUES (514,13461,11565,43599,20,0,5);     -- carapace_ring
INSERT INTO `guild_shops` VALUES (514,13711,29925,146832,20,0,5);    -- carapace_mask
INSERT INTO `guild_shops` VALUES (514,13712,43312,96442,20,0,5);     -- carapace_harness
INSERT INTO `guild_shops` VALUES (514,13713,23625,57960,20,0,5);     -- carapace_mittens
INSERT INTO `guild_shops` VALUES (514,13715,37338,131712,20,0,5);    -- cpc._leggings
INSERT INTO `guild_shops` VALUES (514,13744,208550,208550,20,0,3);   -- justaucorps
INSERT INTO `guild_shops` VALUES (514,13981,67439,72204,20,0,5);     -- turtle_bangles
INSERT INTO `guild_shops` VALUES (514,16405,213,519,20,0,20);        -- cat_baghnakhs
INSERT INTO `guild_shops` VALUES (514,16406,14428,35251,20,0,10);    -- baghnakhs
INSERT INTO `guild_shops` VALUES (514,16407,1521,2859,20,0,15);      -- brass_baghnakhs
INSERT INTO `guild_shops` VALUES (514,16642,9050,19053,20,0,15);     -- bone_axe
INSERT INTO `guild_shops` VALUES (514,16649,4887,22154,20,0,15);     -- bone_pick
INSERT INTO `guild_shops` VALUES (514,17026,4032,10590,20,0,15);     -- bone_cudgel
INSERT INTO `guild_shops` VALUES (514,17062,16493,19859,20,0,15);    -- bone_rod
INSERT INTO `guild_shops` VALUES (514,17257,19859,39568,20,0,7);     -- bandits_gun
INSERT INTO `guild_shops` VALUES (514,17299,2419,2419,198,0,99);     -- astragalos
INSERT INTO `guild_shops` VALUES (514,17319,3,21,8910,1782,3564);    -- bone_arrow
INSERT INTO `guild_shops` VALUES (514,17352,21645,47330,20,0,10);    -- horn
INSERT INTO `guild_shops` VALUES (514,17610,22500,53100,20,0,15);    -- bone_knife
INSERT INTO `guild_shops` VALUES (514,17612,34440,39606,20,0,10);    -- beetle_knife

-- Kuzah Hpirohpon (Windurst Woods) Clothcraft Guild (S)
INSERT INTO `guild_shops` VALUES (5152,816,592,3865,255,48,100);     -- silk_thread
INSERT INTO `guild_shops` VALUES (5152,817,45,240,255,48,100);       -- grass_thread
INSERT INTO `guild_shops` VALUES (5152,818,144,768,255,48,100);      -- cotton_thread
INSERT INTO `guild_shops` VALUES (5152,819,750,4200,255,48,100);     -- linen_thread
INSERT INTO `guild_shops` VALUES (5152,820,2700,12528,165,33,65);    -- wool_thread
INSERT INTO `guild_shops` VALUES (5152,822,585,4760,255,48,100);     -- silver_thread
INSERT INTO `guild_shops` VALUES (5152,823,13338,109440,165,33,65);  -- gold_thread
INSERT INTO `guild_shops` VALUES (5152,824,240,1344,80,16,32);       -- grass_cloth
INSERT INTO `guild_shops` VALUES (5152,825,480,2944,80,16,32);       -- cotton_cloth
INSERT INTO `guild_shops` VALUES (5152,826,12840,12840,80,16,32);    -- linen_cloth
INSERT INTO `guild_shops` VALUES (5152,827,9180,48384,55,0,22);      -- wool_cloth
INSERT INTO `guild_shops` VALUES (5152,828,21851,31710,32,0,12);     -- velvet_cloth
INSERT INTO `guild_shops` VALUES (5152,832,675,4500,255,48,100);     -- sheep_wool
INSERT INTO `guild_shops` VALUES (5152,833,15,18,375,75,150);        -- moko_grass
INSERT INTO `guild_shops` VALUES (5152,834,79,200,255,48,100);       -- saruta_cotton
INSERT INTO `guild_shops` VALUES (5152,835,187,1000,375,75,100);     -- flax_flower
INSERT INTO `guild_shops` VALUES (5152,838,9438,34557,55,0,22);      -- spider_web
INSERT INTO `guild_shops` VALUES (5152,839,137,870,255,48,100);      -- crawler_cocoon
INSERT INTO `guild_shops` VALUES (5152,841,26,192,375,0,150);        -- yagudo_feather
INSERT INTO `guild_shops` VALUES (5152,2128,75,86,375,75,150);       -- spindle
INSERT INTO `guild_shops` VALUES (5152,2145,75,180,165,0,65);        -- zephyr_thread
INSERT INTO `guild_shops` VALUES (5152,12464,2710,7898,20,0,20);     -- headgear
INSERT INTO `guild_shops` VALUES (5152,12465,35315,38882,20,0,15);   -- cotton_headgear
INSERT INTO `guild_shops` VALUES (5152,12466,23200,39400,20,0,10);   -- red_cap
INSERT INTO `guild_shops` VALUES (5152,12499,14160,78080,20,0,5);    -- flax_headband
INSERT INTO `guild_shops` VALUES (5152,12593,66992,66992,20,0,10);   -- cotton_doublet
INSERT INTO `guild_shops` VALUES (5152,12600,424,1171,20,0,20);      -- robe
INSERT INTO `guild_shops` VALUES (5152,12601,14684,14684,20,0,15);   -- linen_robe
INSERT INTO `guild_shops` VALUES (5152,12720,2787,7393,20,0,15);     -- gloves
INSERT INTO `guild_shops` VALUES (5152,12736,1290,3196,20,0,15);     -- mitts
INSERT INTO `guild_shops` VALUES (5152,12739,37862,172339,20,0,5);
INSERT INTO `guild_shops` VALUES (5152,12851,135936,228096,20,0,10);
INSERT INTO `guild_shops` VALUES (5152,12856,372,936,20,0,20);
INSERT INTO `guild_shops` VALUES (5152,12976,1339,6486,20,0,15);
INSERT INTO `guild_shops` VALUES (5152,12979,171776,171776,20,0,10);
INSERT INTO `guild_shops` VALUES (5152,13577,15190,42134,20,0,10);
INSERT INTO `guild_shops` VALUES (5152,13583,318,1683,20,0,20);
INSERT INTO `guild_shops` VALUES (5152,13584,10321,40322,20,0,15);
INSERT INTO `guild_shops` VALUES (5152,13750,87178,87178,20,0,10);

-- Tilala (Clothcraft Guild) Selbina (S)
INSERT INTO `guild_shops` VALUES (516,816,592,3865,255,48,100);
INSERT INTO `guild_shops` VALUES (516,817,45,240,255,48,100);
INSERT INTO `guild_shops` VALUES (516,818,144,768,255,48,100);
INSERT INTO `guild_shops` VALUES (516,819,750,4200,255,48,100);
INSERT INTO `guild_shops` VALUES (516,820,2700,12528,165,33,65);
INSERT INTO `guild_shops` VALUES (516,822,585,4760,255,48,100);
INSERT INTO `guild_shops` VALUES (516,823,18240,62350,165,33,65);
INSERT INTO `guild_shops` VALUES (516,824,240,1344,80,16,32);
INSERT INTO `guild_shops` VALUES (516,825,480,2944,80,16,32);
INSERT INTO `guild_shops` VALUES (516,827,9180,48384,55,0,22);
INSERT INTO `guild_shops` VALUES (516,832,675,4500,255,48,100);
INSERT INTO `guild_shops` VALUES (516,833,15,18,375,75,150);
INSERT INTO `guild_shops` VALUES (516,835,187,1000,375,75,100);
INSERT INTO `guild_shops` VALUES (516,838,9438,34557,55,0,22);
INSERT INTO `guild_shops` VALUES (516,841,26,192,375,0,150);

-- Babubu (Port Windurst) Fishing Guild
INSERT INTO `guild_shops` VALUES (517,624,24,136,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4288,5572,13888,165,0,65);
INSERT INTO `guild_shops` VALUES (517,4290,1008,1289,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4291,582,634,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4304,13930,32200,30,0,12);
INSERT INTO `guild_shops` VALUES (517,4307,10746,24624,30,0,12);
INSERT INTO `guild_shops` VALUES (517,4354,120,624,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4360,64,98,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4361,1216,1289,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4379,240,348,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4383,1244,2949,165,0,65);
INSERT INTO `guild_shops` VALUES (517,4384,5250,6720,165,0,65);
INSERT INTO `guild_shops` VALUES (517,4385,308,520,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4399,1503,6264,165,0,65);
INSERT INTO `guild_shops` VALUES (517,4401,91,191,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4402,3546,8064,165,0,65);
INSERT INTO `guild_shops` VALUES (517,4403,108,160,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4426,195,272,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4427,1350,2952,165,0,65);
INSERT INTO `guild_shops` VALUES (517,4428,60,352,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4429,979,5068,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4443,28,134,255,48,100);
INSERT INTO `guild_shops` VALUES (517,4451,5160,19520,30,0,12);
INSERT INTO `guild_shops` VALUES (517,4461,4050,18792,30,0,12);
INSERT INTO `guild_shops` VALUES (517,4462,1350,4824,30,0,12);
INSERT INTO `guild_shops` VALUES (517,4464,172,1122,255,0,100);
INSERT INTO `guild_shops` VALUES (517,4469,580,2400,55,0,22);
INSERT INTO `guild_shops` VALUES (517,4470,4112,4186,55,0,22);
INSERT INTO `guild_shops` VALUES (517,4471,2100,13328,55,0,22);
INSERT INTO `guild_shops` VALUES (517,4472,30,65,255,48,100);        -- crayfish
INSERT INTO `guild_shops` VALUES (517,4473,2310,2833,55,0,22);       -- crescent_fish
INSERT INTO `guild_shops` VALUES (517,4477,7400,7880,30,0,12);       -- gavial_fish
INSERT INTO `guild_shops` VALUES (517,4479,1368,8280,55,0,22);       -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (517,4480,995,2400,55,0,22);        -- gugru_tuna
INSERT INTO `guild_shops` VALUES (517,4481,320,601,255,0,100);       -- ogre_eel
INSERT INTO `guild_shops` VALUES (517,4482,300,656,255,0,100);       -- nosteau_herring
INSERT INTO `guild_shops` VALUES (517,4483,195,1248,255,0,100);      -- tiger_cod
INSERT INTO `guild_shops` VALUES (517,4484,1350,3582,55,0,22);       -- shall_shell
INSERT INTO `guild_shops` VALUES (517,4485,2576,5572,30,0,12);       -- noble_lady
INSERT INTO `guild_shops` VALUES (517,4500,63,208,255,0,100);        -- greedie
INSERT INTO `guild_shops` VALUES (517,4514,60,128,255,0,100);        -- quus
INSERT INTO `guild_shops` VALUES (517,4515,158,274,255,0,100);       -- copper_frog
INSERT INTO `guild_shops` VALUES (517,4579,3062,8680,55,0,22);       -- elshimo_newt
INSERT INTO `guild_shops` VALUES (517,4580,1940,1940,55,0,22);       -- coral_butterfly
INSERT INTO `guild_shops` VALUES (517,16992,52,294,255,48,100);      -- slice_of_bluetail
INSERT INTO `guild_shops` VALUES (517,16993,52,294,255,48,100);      -- peeled_crayfish
INSERT INTO `guild_shops` VALUES (517,16994,52,294,255,48,100);      -- slice_of_carp
INSERT INTO `guild_shops` VALUES (517,16996,52,240,255,48,100);      -- sardine_ball
INSERT INTO `guild_shops` VALUES (517,16997,52,240,255,48,100);      -- crayfish_ball
INSERT INTO `guild_shops` VALUES (517,16998,38,214,255,48,100);      -- insect_ball
INSERT INTO `guild_shops` VALUES (517,16999,52,240,255,48,100);      -- trout_ball
INSERT INTO `guild_shops` VALUES (517,17000,52,240,255,48,100);      -- meatball
INSERT INTO `guild_shops` VALUES (517,17380,25740,25740,30,5,5);
INSERT INTO `guild_shops` VALUES (517,17382,9657,9657,30,5,10);      -- s.h._fishing_rod
INSERT INTO `guild_shops` VALUES (517,17383,1980,1980,30,10,20);     -- clothespole
INSERT INTO `guild_shops` VALUES (517,17387,4077,4077,30,5,15);      -- tarutaru_f._rod
INSERT INTO `guild_shops` VALUES (517,17388,934,934,30,10,20);       -- fastwater_f._rod
INSERT INTO `guild_shops` VALUES (517,17389,332,332,30,10,20);       -- bamboo_fish._rod
INSERT INTO `guild_shops` VALUES (517,17390,145,145,30,10,20);       -- yew_fishing_rod
INSERT INTO `guild_shops` VALUES (517,17391,44,44,30,10,20);         -- willow_fish._rod
INSERT INTO `guild_shops` VALUES (517,17392,213,283,255,48,100);     -- sliced_sardine
INSERT INTO `guild_shops` VALUES (517,17393,213,283,255,48,100);     -- sliced_cod
INSERT INTO `guild_shops` VALUES (517,17394,220,300,255,48,100);     -- peeled_lobster
INSERT INTO `guild_shops` VALUES (517,17395,8,9,255,48,100);         -- lugworm
INSERT INTO `guild_shops` VALUES (517,17396,3,8,255,48,100);         -- little_worm
INSERT INTO `guild_shops` VALUES (517,17399,2394,2394,20,6,12);      -- sabiki_rig
INSERT INTO `guild_shops` VALUES (517,17404,540,540,20,6,12);        -- worm_lure
INSERT INTO `guild_shops` VALUES (517,17405,540,540,20,6,12);        -- fly_lure
INSERT INTO `guild_shops` VALUES (517,17407,303,303,20,6,12);        -- minnow

-- Graegham (Selbina) Fishing Guild (S)
INSERT INTO `guild_shops` VALUES (518,624,58,172,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4354,257,488,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4360,32,140,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4379,134,214,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4383,2016,5989,165,0,65);
INSERT INTO `guild_shops` VALUES (518,4384,5250,13790,165,33,65);
INSERT INTO `guild_shops` VALUES (518,4385,261,489,255,48,100);
INSERT INTO `guild_shops` VALUES (518,4399,2520,7560,165,33,65);
INSERT INTO `guild_shops` VALUES (518,4402,3546,8064,165,0,65);
INSERT INTO `guild_shops` VALUES (518,4403,30,390,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4426,195,272,255,48,100);
INSERT INTO `guild_shops` VALUES (518,4428,136,452,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4443,64,154,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4451,3400,16000,30,6,12);
INSERT INTO `guild_shops` VALUES (518,4461,6048,20792,30,6,12);
INSERT INTO `guild_shops` VALUES (518,4469,770,2856,55,0,22);
INSERT INTO `guild_shops` VALUES (518,4470,1790,3056,55,0,22);
INSERT INTO `guild_shops` VALUES (518,4472,79,238,255,48,100);
INSERT INTO `guild_shops` VALUES (518,4477,3000,5220,30,0,12);
INSERT INTO `guild_shops` VALUES (518,4479,1368,8280,55,11,22);
INSERT INTO `guild_shops` VALUES (518,4480,675,1984,55,0,22);
INSERT INTO `guild_shops` VALUES (518,4481,320,601,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4482,716,1056,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4483,520,1848,255,48,100);
INSERT INTO `guild_shops` VALUES (518,4484,1350,3582,55,0,22);
INSERT INTO `guild_shops` VALUES (518,4485,2170,13440,30,6,12);
INSERT INTO `guild_shops` VALUES (518,4500,24,76,255,48,100);
INSERT INTO `guild_shops` VALUES (518,4514,60,329,255,0,100);
INSERT INTO `guild_shops` VALUES (518,4515,132,248,255,0,100);
INSERT INTO `guild_shops` VALUES (518,17382,9657,9657,30,5,10);
INSERT INTO `guild_shops` VALUES (518,17383,1980,1980,30,10,20);     -- clothespole
INSERT INTO `guild_shops` VALUES (518,17387,4077,4077,30,5,15);      -- tarutaru_f._rod
INSERT INTO `guild_shops` VALUES (518,17388,934,934,30,10,20);       -- fastwater_f._rod
INSERT INTO `guild_shops` VALUES (518,17399,2394,2394,20,6,12);      -- sabiki_rig

-- Mendoline    (Selbina) Fishing Guild (S)
INSERT INTO `guild_shops` VALUES (5182,624,58,172,255,0,100);        -- pamtam_kelp
INSERT INTO `guild_shops` VALUES (5182,4354,257,488,255,0,100);      -- shining_trout
INSERT INTO `guild_shops` VALUES (5182,4360,32,140,255,0,100);       -- bastore_sardine
INSERT INTO `guild_shops` VALUES (5182,4379,134,214,255,0,100);      -- cheval_salmon
INSERT INTO `guild_shops` VALUES (5182,4383,2016,5989,165,0,65);     -- gold_lobster
INSERT INTO `guild_shops` VALUES (5182,4384,5250,13790,165,33,65);   -- black_sole
INSERT INTO `guild_shops` VALUES (5182,4385,261,489,255,48,100);     -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (5182,4399,2520,7560,165,33,65);    -- bluetail
INSERT INTO `guild_shops` VALUES (5182,4402,3546,8064,165,0,65);     -- red_terrapin
INSERT INTO `guild_shops` VALUES (5182,4403,30,390,255,0,100);       -- yellow_globe
INSERT INTO `guild_shops` VALUES (5182,4426,195,272,255,48,100);     -- tricolored_carp
INSERT INTO `guild_shops` VALUES (5182,4428,136,452,255,0,100);      -- dark_bass
INSERT INTO `guild_shops` VALUES (5182,4443,64,154,255,0,100);       -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (5182,4451,3400,16000,30,6,12);     -- silver_shark
INSERT INTO `guild_shops` VALUES (5182,4461,6048,20792,30,6,12);     -- bastore_bream
INSERT INTO `guild_shops` VALUES (5182,4469,770,2856,55,0,22);       -- giant_catfish
INSERT INTO `guild_shops` VALUES (5182,4470,1790,3056,55,0,22);      -- icefish
INSERT INTO `guild_shops` VALUES (5182,4472,79,238,255,48,100);      -- crayfish
INSERT INTO `guild_shops` VALUES (5182,4477,3000,5220,30,0,12);      -- gavial_fish
INSERT INTO `guild_shops` VALUES (5182,4479,1368,8280,55,11,22);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (5182,4480,675,1984,55,0,22);       -- gugru_tuna
INSERT INTO `guild_shops` VALUES (5182,4481,320,601,255,0,100);      -- ogre_eel
INSERT INTO `guild_shops` VALUES (5182,4482,716,1056,255,0,100);     -- nosteau_herring
INSERT INTO `guild_shops` VALUES (5182,4483,520,1848,255,48,100);    -- tiger_cod
INSERT INTO `guild_shops` VALUES (5182,4484,1350,3582,55,0,22);      -- shall_shell
INSERT INTO `guild_shops` VALUES (5182,4485,2170,13440,30,6,12);     -- noble_lady
INSERT INTO `guild_shops` VALUES (5182,4500,24,76,255,48,100);       -- greedie
INSERT INTO `guild_shops` VALUES (5182,4514,60,329,255,0,100);       -- quus
INSERT INTO `guild_shops` VALUES (5182,4515,132,248,255,0,100);      -- copper_frog
INSERT INTO `guild_shops` VALUES (5182,17382,9657,9657,30,5,10);     -- s.h._fishing_rod
INSERT INTO `guild_shops` VALUES (5182,17383,1980,1980,30,10,20);
INSERT INTO `guild_shops` VALUES (5182,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (5182,17388,934,934,30,10,20);
INSERT INTO `guild_shops` VALUES (5182,17399,2394,2394,20,6,12);

-- Mep Nhapopoluko (Bibiki Bay) Fishing Guild
INSERT INTO `guild_shops` VALUES (519,624,24,39,255,48,100);
INSERT INTO `guild_shops` VALUES (519,4314,300,300,255,48,100);
INSERT INTO `guild_shops` VALUES (519,4317,120,237,255,48,100);
INSERT INTO `guild_shops` VALUES (519,4318,3375,3375,80,16,32);
INSERT INTO `guild_shops` VALUES (519,4385,115,546,255,48,100);
INSERT INTO `guild_shops` VALUES (519,4399,1350,5487,165,33,65);
INSERT INTO `guild_shops` VALUES (519,4443,15,32,255,48,100);
INSERT INTO `guild_shops` VALUES (519,4484,1350,1800,55,11,22);
INSERT INTO `guild_shops` VALUES (519,4485,2172,13882,30,6,12);
INSERT INTO `guild_shops` VALUES (519,17382,7081,8369,30,5,10);
INSERT INTO `guild_shops` VALUES (519,17388,766,906,30,10,20);

-- Rajmonda (Ship bound for Selbina) Fishing Guild
INSERT INTO `guild_shops` VALUES (520,624,47,158,255,48,100);
INSERT INTO `guild_shops` VALUES (520,4360,41,153,255,0,100);
INSERT INTO `guild_shops` VALUES (520,4361,1216,1289,255,0,100);
INSERT INTO `guild_shops` VALUES (520,4383,4251,5529,165,0,65);
INSERT INTO `guild_shops` VALUES (520,4384,5250,13930,165,0,65);
INSERT INTO `guild_shops` VALUES (520,4385,235,737,255,48,100);
INSERT INTO `guild_shops` VALUES (520,4399,1350,5487,165,33,65);
INSERT INTO `guild_shops` VALUES (520,4403,155,398,255,0,100);
INSERT INTO `guild_shops` VALUES (520,4443,63,157,255,0,100);
INSERT INTO `guild_shops` VALUES (520,4451,3400,18080,30,6,12);
INSERT INTO `guild_shops` VALUES (520,4461,4050,9828,30,0,12);
INSERT INTO `guild_shops` VALUES (520,4479,1368,8280,55,0,22);
INSERT INTO `guild_shops` VALUES (520,4480,375,2000,55,0,22);
INSERT INTO `guild_shops` VALUES (520,4481,320,601,255,0,100);
INSERT INTO `guild_shops` VALUES (520,4482,736,752,255,0,100);
INSERT INTO `guild_shops` VALUES (520,4483,509,1812,255,48,100);
INSERT INTO `guild_shops` VALUES (520,4484,3312,8784,55,0,22);
INSERT INTO `guild_shops` VALUES (520,4485,2100,12544,30,0,12);
INSERT INTO `guild_shops` VALUES (520,4500,24,126,255,0,100);
INSERT INTO `guild_shops` VALUES (520,4514,60,259,255,0,100);
INSERT INTO `guild_shops` VALUES (520,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (520,17395,8,9,255,48,100);
INSERT INTO `guild_shops` VALUES (520,17399,2394,2394,20,6,12);
INSERT INTO `guild_shops` VALUES (520,17400,691,691,20,6,12);
INSERT INTO `guild_shops` VALUES (520,17407,303,303,20,6,12);

-- Lokhong (Ship bound for Mhaura) Fishing Guild
INSERT INTO `guild_shops` VALUES (521,624,47,158,255,48,100);
INSERT INTO `guild_shops` VALUES (521,4360,41,153,255,0,100);
INSERT INTO `guild_shops` VALUES (521,4361,1216,1289,255,0,100);
INSERT INTO `guild_shops` VALUES (521,4383,4251,5529,165,0,65);
INSERT INTO `guild_shops` VALUES (521,4384,5250,13930,165,0,65);
INSERT INTO `guild_shops` VALUES (521,4385,235,737,255,48,100);
INSERT INTO `guild_shops` VALUES (521,4399,1350,5487,165,33,65);
INSERT INTO `guild_shops` VALUES (521,4403,155,398,255,0,100);
INSERT INTO `guild_shops` VALUES (521,4443,63,157,255,0,100);
INSERT INTO `guild_shops` VALUES (521,4451,3400,18080,30,6,12);
INSERT INTO `guild_shops` VALUES (521,4461,4050,9828,30,0,12);
INSERT INTO `guild_shops` VALUES (521,4479,1368,8280,55,0,22);
INSERT INTO `guild_shops` VALUES (521,4480,375,2000,55,0,22);
INSERT INTO `guild_shops` VALUES (521,4481,320,601,255,0,100);
INSERT INTO `guild_shops` VALUES (521,4482,736,752,255,0,100);
INSERT INTO `guild_shops` VALUES (521,4483,509,1812,255,48,100);
INSERT INTO `guild_shops` VALUES (521,4484,3312,8784,55,0,22);
INSERT INTO `guild_shops` VALUES (521,4485,2100,12544,30,0,12);
INSERT INTO `guild_shops` VALUES (521,4500,24,126,255,0,100);
INSERT INTO `guild_shops` VALUES (521,4514,60,259,255,0,100);
INSERT INTO `guild_shops` VALUES (521,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (521,17395,8,9,255,48,100);
INSERT INTO `guild_shops` VALUES (521,17399,2394,2394,20,6,12);
INSERT INTO `guild_shops` VALUES (521,17400,691,691,20,6,12);
INSERT INTO `guild_shops` VALUES (521,17407,303,303,20,6,12);

-- Cehn Teyohngo (Open sea route to Al Zahbi) Fishing Guild
INSERT INTO `guild_shops` VALUES (522,624,47,158,255,0,100);
INSERT INTO `guild_shops` VALUES (522,4360,41,153,255,0,100);
INSERT INTO `guild_shops` VALUES (522,4399,5487,8712,165,0,65);
INSERT INTO `guild_shops` VALUES (522,4403,155,398,255,48,100);
INSERT INTO `guild_shops` VALUES (522,4461,4050,26784,30,0,12);
INSERT INTO `guild_shops` VALUES (522,4480,564,2440,55,11,22);
INSERT INTO `guild_shops` VALUES (522,4484,3412,8928,55,0,22);
INSERT INTO `guild_shops` VALUES (522,4485,2100,12544,30,0,12);
INSERT INTO `guild_shops` VALUES (522,4500,24,126,255,0,100);
INSERT INTO `guild_shops` VALUES (522,4514,114,393,255,48,100);
INSERT INTO `guild_shops` VALUES (522,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (522,17395,8,9,255,48,100);
INSERT INTO `guild_shops` VALUES (522,17399,2394,2394,20,6,12);
INSERT INTO `guild_shops` VALUES (522,17400,691,691,20,6,12);
INSERT INTO `guild_shops` VALUES (522,17407,270,270,20,6,12);

-- Pashi Maccaleh (Open sea route to Mhaura) Fishing Guild
INSERT INTO `guild_shops` VALUES (523,624,47,158,255,0,100);
INSERT INTO `guild_shops` VALUES (523,4360,41,153,255,0,100);
INSERT INTO `guild_shops` VALUES (523,4399,5487,8712,165,0,65);
INSERT INTO `guild_shops` VALUES (523,4403,155,398,255,48,100);
INSERT INTO `guild_shops` VALUES (523,4461,4050,26784,30,0,12);
INSERT INTO `guild_shops` VALUES (523,4480,564,2440,55,11,22);
INSERT INTO `guild_shops` VALUES (523,4484,3412,8928,55,0,22);
INSERT INTO `guild_shops` VALUES (523,4485,2100,12544,30,0,12);
INSERT INTO `guild_shops` VALUES (523,4500,24,126,255,0,100);
INSERT INTO `guild_shops` VALUES (523,4514,114,393,255,48,100);
INSERT INTO `guild_shops` VALUES (523,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (523,17395,8,9,255,48,100);
INSERT INTO `guild_shops` VALUES (523,17399,2394,2394,20,6,12);
INSERT INTO `guild_shops` VALUES (523,17400,691,691,20,6,12);
INSERT INTO `guild_shops` VALUES (523,17407,270,270,20,6,12);

-- Jidwahn (Silver Sea route to Nashmau) Fishing Guild
INSERT INTO `guild_shops` VALUES (524,2177,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (524,2180,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (524,2182,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (524,2183,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (524,4399,8856,8928,165,0,65);
INSERT INTO `guild_shops` VALUES (524,4403,155,398,255,0,100);
INSERT INTO `guild_shops` VALUES (524,4480,2280,2480,55,0,22);
INSERT INTO `guild_shops` VALUES (524,4485,2100,12544,30,0,12);
INSERT INTO `guild_shops` VALUES (524,5140,69888,75504,15,0,6);
INSERT INTO `guild_shops` VALUES (524,5448,8296,8432,15,0,6);
INSERT INTO `guild_shops` VALUES (524,5449,92,136,255,48,100);
INSERT INTO `guild_shops` VALUES (524,5452,5472,5904,55,11,22);
INSERT INTO `guild_shops` VALUES (524,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (524,17395,8,9,255,48,100);
INSERT INTO `guild_shops` VALUES (524,17399,2394,2394,20,6,12);
INSERT INTO `guild_shops` VALUES (524,17400,691,691,20,6,12);
INSERT INTO `guild_shops` VALUES (524,17407,270,270,20,6,12);

-- Yahliq (Silver Sea route to Al Zahbi) Fishing Guild
INSERT INTO `guild_shops` VALUES (525,2177,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (525,2180,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (525,2182,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (525,2183,36,224,8910,1782,3564);
INSERT INTO `guild_shops` VALUES (525,4399,8856,8928,165,0,65);
INSERT INTO `guild_shops` VALUES (525,4403,155,398,255,0,100);
INSERT INTO `guild_shops` VALUES (525,4480,2280,2480,55,0,22);
INSERT INTO `guild_shops` VALUES (525,4485,2100,12544,30,0,12);
INSERT INTO `guild_shops` VALUES (525,5140,69888,75504,15,0,6);
INSERT INTO `guild_shops` VALUES (525,5448,8296,8432,15,0,6);
INSERT INTO `guild_shops` VALUES (525,5449,92,136,255,48,100);
INSERT INTO `guild_shops` VALUES (525,5452,5472,5904,55,11,22);
INSERT INTO `guild_shops` VALUES (525,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (525,17395,8,9,255,48,100);
INSERT INTO `guild_shops` VALUES (525,17399,2394,2394,20,6,12);
INSERT INTO `guild_shops` VALUES (525,17400,691,691,20,6,12);
INSERT INTO `guild_shops` VALUES (525,17407,270,270,20,6,12);

-- Maymunah (Bastok Mines) Alchemist Guild (S)
INSERT INTO `guild_shops` VALUES (5262,621,21,40,255,0,100);         -- crying_mustard
INSERT INTO `guild_shops` VALUES (5262,622,36,155,255,48,100);       -- dried_marjoram
INSERT INTO `guild_shops` VALUES (5262,636,97,369,255,48,100);       -- chamomile
INSERT INTO `guild_shops` VALUES (5262,637,1640,4880,165,0,65);      -- slime_oil
INSERT INTO `guild_shops` VALUES (5262,638,138,851,255,48,100);      -- sage
INSERT INTO `guild_shops` VALUES (5262,912,192,360,255,0,100);       -- beehive_chip
INSERT INTO `guild_shops` VALUES (5262,914,1125,6300,165,33,65);     -- mercury
INSERT INTO `guild_shops` VALUES (5262,920,1084,5899,165,0,65);      -- malboro_vine
INSERT INTO `guild_shops` VALUES (5262,922,300,300,255,0,100);       -- bat_wing
INSERT INTO `guild_shops` VALUES (5262,925,1312,3952,55,0,22);       -- giant_stinger
INSERT INTO `guild_shops` VALUES (5262,928,1014,2307,165,0,65);      -- bomb_ash
INSERT INTO `guild_shops` VALUES (5262,929,1875,6900,80,0,32);       -- black_ink
INSERT INTO `guild_shops` VALUES (5262,931,19520,19520,15,3,6);      -- cermet_chunk
INSERT INTO `guild_shops` VALUES (5262,932,1020,1080,165,0,65);      -- carbon_fiber
INSERT INTO `guild_shops` VALUES (5262,933,664,3168,165,33,65);      -- glass_fiber
INSERT INTO `guild_shops` VALUES (5262,943,534,1177,255,0,100);      -- poison_dust
INSERT INTO `guild_shops` VALUES (5262,947,3360,21862,55,0,22);      -- firesand
INSERT INTO `guild_shops` VALUES (5262,951,90,350,255,48,100);       -- wijnruit
INSERT INTO `guild_shops` VALUES (5262,1108,573,3213,255,48,100);    -- sulfur
INSERT INTO `guild_shops` VALUES (5262,1109,930,4563,255,0,100);     -- artificial_lens
INSERT INTO `guild_shops` VALUES (5262,2131,75,242,255,48,100);      -- triturator
-- TODO: All items purchasable from Curio Moogle commented out pending research on price changes
-- INSERT INTO `guild_shops` VALUES (5262,4112,682,728,80,16,32);       -- potion
-- INSERT INTO `guild_shops` VALUES (5262,4116,3375,7560,55,0,22);      -- hi-potion
-- INSERT INTO `guild_shops` VALUES (5262,4128,3624,17201,30,0,12);     -- ether
-- INSERT INTO `guild_shops` VALUES (5262,4148,1200,1377,80,0,32);      -- antidote
-- INSERT INTO `guild_shops` VALUES (5262,4150,1945,9549,80,0,32);      -- eye_drops
-- INSERT INTO `guild_shops` VALUES (5262,4151,880,2944,80,0,32);       -- echo_drops
-- INSERT INTO `guild_shops` VALUES (5262,4154,5250,13300,55,0,22);     -- holy_water
INSERT INTO `guild_shops` VALUES (5262,4162,5250,13300,80,0,32);     -- silencing_potion
-- INSERT INTO `guild_shops` VALUES (5262,4164,1050,6832,165,0,65);     -- prism_powder
-- INSERT INTO `guild_shops` VALUES (5262,4165,900,5712,165,0,65);
-- INSERT INTO `guild_shops` VALUES (5262,4166,750,2080,165,0,65);
INSERT INTO `guild_shops` VALUES (5262,4171,750,2080,255,0,100);
INSERT INTO `guild_shops` VALUES (5262,4443,750,2080,255,48,100);
INSERT INTO `guild_shops` VALUES (5262,4509,9,58,375,0,150);
INSERT INTO `guild_shops` VALUES (5262,16387,10902,33886,20,0,10);
INSERT INTO `guild_shops` VALUES (5262,16403,102009,102009,20,0,3);
INSERT INTO `guild_shops` VALUES (5262,16454,1904,1904,20,0,15);
INSERT INTO `guild_shops` VALUES (5262,16471,519,3024,20,0,10);
INSERT INTO `guild_shops` VALUES (5262,16478,19148,19148,20,0,5);
INSERT INTO `guild_shops` VALUES (5262,16495,9906,9906,20,0,10);
INSERT INTO `guild_shops` VALUES (5262,16581,33368,167872,20,0,3);
INSERT INTO `guild_shops` VALUES (5262,17340,392,392,8910,0,3564);
INSERT INTO `guild_shops` VALUES (5262,17341,392,392,2970,0,1188);
INSERT INTO `guild_shops` VALUES (5262,18228,114,114,2970,594,1188);
INSERT INTO `guild_shops` VALUES (5262,18232,114,114,2970,594,1188);
INSERT INTO `guild_shops` VALUES (5262,18236,21,21,2970,594,1188);

-- Visala (Goldsmith Guild) Bastok Markets (S)
INSERT INTO `guild_shops` VALUES (5272,644,1500,9200,165,33,65);     -- mythril_ore
INSERT INTO `guild_shops` VALUES (5272,653,19900,36400,55,0,22);     -- mythril_ingot
INSERT INTO `guild_shops` VALUES (5272,661,1171,1171,255,0,100);     -- brass_sheet
INSERT INTO `guild_shops` VALUES (5272,663,20240,45600,80,16,32);    -- mythril_sheet
INSERT INTO `guild_shops` VALUES (5272,673,210,1108,255,48,100);     -- brass_scales
INSERT INTO `guild_shops` VALUES (5272,681,10500,30800,30,6,12);     -- mythril_chain
INSERT INTO `guild_shops` VALUES (5272,736,315,1260,255,48,100);     -- silver_ore
INSERT INTO `guild_shops` VALUES (5272,738,1000,6000,30,0,12);       -- platinum_ore
INSERT INTO `guild_shops` VALUES (5272,744,4095,9996,80,0,32);       -- silver_ingot
INSERT INTO `guild_shops` VALUES (5272,760,29172,74880,55,0,22);     -- silver_chain
INSERT INTO `guild_shops` VALUES (5272,769,1288,7000,165,33,65);     -- red_rock
INSERT INTO `guild_shops` VALUES (5272,770,1288,7000,165,33,65);     -- blue_rock
INSERT INTO `guild_shops` VALUES (5272,771,1288,7000,165,33,65);     -- yellow_rock
INSERT INTO `guild_shops` VALUES (5272,772,1288,7000,165,33,65);     -- green_rock
INSERT INTO `guild_shops` VALUES (5272,773,1288,7000,165,33,65);     -- translucent_rock
INSERT INTO `guild_shops` VALUES (5272,774,1288,7000,165,33,65);     -- purple_rock
INSERT INTO `guild_shops` VALUES (5272,775,1288,7000,165,33,65);     -- black_rock
INSERT INTO `guild_shops` VALUES (5272,776,1288,7000,165,0,65);      -- white_rock
INSERT INTO `guild_shops` VALUES (5272,784,23400,124800,15,0,3);     -- jadeite
INSERT INTO `guild_shops` VALUES (5272,785,106400,116736,15,0,3);    -- emerald
INSERT INTO `guild_shops` VALUES (5272,786,45600,116736,15,0,3);     -- ruby
INSERT INTO `guild_shops` VALUES (5272,787,106400,116736,15,0,3);    -- diamond
INSERT INTO `guild_shops` VALUES (5272,788,12000,56160,15,0,6);      -- peridot
INSERT INTO `guild_shops` VALUES (5272,789,106400,116736,15,0,3);    -- topaz
INSERT INTO `guild_shops` VALUES (5272,790,3600,9000,15,0,6);        -- garnet
INSERT INTO `guild_shops` VALUES (5272,791,23400,136032,15,1,3);     -- aquamarine
INSERT INTO `guild_shops` VALUES (5272,795,1396,2794,80,16,32);      -- lapis_lazuli
INSERT INTO `guild_shops` VALUES (5272,796,1396,2794,80,3,32);       -- light_opal
INSERT INTO `guild_shops` VALUES (5272,797,44304,49608,15,3,6);      -- painite
INSERT INTO `guild_shops` VALUES (5272,799,1396,2794,80,16,32);      -- onyx
INSERT INTO `guild_shops` VALUES (5272,800,1396,2794,80,3,32);       -- amethyst
INSERT INTO `guild_shops` VALUES (5272,801,23400,70200,15,0,3);      -- chrysoberyl
INSERT INTO `guild_shops` VALUES (5272,802,23400,70200,15,0,3);      -- moonstone
INSERT INTO `guild_shops` VALUES (5272,803,23400,70200,15,0,3);      -- sunstone
INSERT INTO `guild_shops` VALUES (5272,804,106400,116736,15,0,3);    -- spinel
INSERT INTO `guild_shops` VALUES (5272,805,23400,70200,15,2,3);      -- zircon
INSERT INTO `guild_shops` VALUES (5272,806,1396,2794,80,16,32);      -- tourmaline
INSERT INTO `guild_shops` VALUES (5272,807,1396,2794,80,3,32);       -- sardonyx
INSERT INTO `guild_shops` VALUES (5272,808,9000,24000,15,3,6);       -- goshenite
INSERT INTO `guild_shops` VALUES (5272,809,1396,2794,80,3,32);       -- clear_topaz
INSERT INTO `guild_shops` VALUES (5272,810,23400,70200,15,0,3);      -- fluorite
INSERT INTO `guild_shops` VALUES (5272,811,9000,27000,15,0,6);       -- ametrine
INSERT INTO `guild_shops` VALUES (5272,812,106400,116736,15,0,3);    -- deathstone
INSERT INTO `guild_shops` VALUES (5272,813,106400,116736,15,3,3);    -- angelstone
INSERT INTO `guild_shops` VALUES (5272,814,1396,2794,80,3,32);       -- amber_stone
INSERT INTO `guild_shops` VALUES (5272,815,9000,27000,15,3,6);       -- sphene
INSERT INTO `guild_shops` VALUES (5272,1588,20400,20400,120,3,60);   -- slab_of_tufa
INSERT INTO `guild_shops` VALUES (5272,12425,17100,43776,20,0,15);   -- silver_mask
INSERT INTO `guild_shops` VALUES (5272,12433,18176,30208,20,0,15);   -- brass_mask
INSERT INTO `guild_shops` VALUES (5272,12449,1503,4300,20,0,15);     -- brass_cap
INSERT INTO `guild_shops` VALUES (5272,12472,153,214,20,0,20);       -- circlet
INSERT INTO `guild_shops` VALUES (5272,12495,4398,4398,20,0,10);     -- silver_hairpin
INSERT INTO `guild_shops` VALUES (5272,12496,117,234,20,0,20);       -- copper_hairpin
INSERT INTO `guild_shops` VALUES (5272,12497,970,1190,20,0,15);      -- brass_hairpin
INSERT INTO `guild_shops` VALUES (5272,12561,14000,24000,20,0,20);   -- brass_scale_mail
INSERT INTO `guild_shops` VALUES (5272,12689,11000,22000,20,0,20);   -- brass_finger_gauntlets
INSERT INTO `guild_shops` VALUES (5272,12705,1023,2620,20,0,15);     -- brass_mittens
INSERT INTO `guild_shops` VALUES (5272,12833,3840,7360,20,0,15);     -- brass_subligar
INSERT INTO `guild_shops` VALUES (5272,12945,11440,11440,20,0,15);   -- brass_greaves
INSERT INTO `guild_shops` VALUES (5272,12961,2380,3720,20,0,15);     -- brass_leggings
INSERT INTO `guild_shops` VALUES (5272,13196,52284,52284,20,0,10);   -- silver_belt
INSERT INTO `guild_shops` VALUES (5272,13317,12800,12800,20,5,10);   -- pearl_earring
INSERT INTO `guild_shops` VALUES (5272,13327,5850,5850,20,0,15);     -- silver_earring
INSERT INTO `guild_shops` VALUES (5272,13330,1238,1238,20,5,10);     -- tml._earring
INSERT INTO `guild_shops` VALUES (5272,13331,1522,1522,20,0,10);     -- sardonyx_earring
INSERT INTO `guild_shops` VALUES (5272,13332,1186,1238,20,0,20);     -- clear_earring
INSERT INTO `guild_shops` VALUES (5272,13333,1186,1238,20,0,20);     -- amethyst_earring
INSERT INTO `guild_shops` VALUES (5272,13334,1186,1238,20,0,20);     -- lapis_laz._earring
INSERT INTO `guild_shops` VALUES (5272,13340,12880,12880,20,0,10);   -- ametrine_earring
INSERT INTO `guild_shops` VALUES (5272,13342,12250,12250,20,0,10);   -- sphene_earring
INSERT INTO `guild_shops` VALUES (5272,13344,1987,5000,20,0,10);     -- sun_earring
INSERT INTO `guild_shops` VALUES (5272,13454,72,179,20,0,20);        -- copper_ring
INSERT INTO `guild_shops` VALUES (5272,13468,1875,2400,20,0,15);     -- tourmaline_ring
INSERT INTO `guild_shops` VALUES (5272,13470,1875,2400,20,0,15);     -- clear_ring
INSERT INTO `guild_shops` VALUES (5272,13471,1875,2400,20,0,15);     -- amethyst_ring
INSERT INTO `guild_shops` VALUES (5272,13472,1875,2400,20,0,15);     -- lapis_lazuli_ring
INSERT INTO `guild_shops` VALUES (5272,13473,1875,2400,20,0,15);     -- amber_ring
INSERT INTO `guild_shops` VALUES (5272,13474,1875,2400,20,0,15);     -- onyx_ring
INSERT INTO `guild_shops` VALUES (5272,13979,20088,20088,20,3,10);   -- silver_bangles
INSERT INTO `guild_shops` VALUES (5272,16391,2700,13989,20,0,10);    -- brass_knuckles
INSERT INTO `guild_shops` VALUES (5272,16407,2399,13554,20,5,10);    -- brass_baghnakhs
INSERT INTO `guild_shops` VALUES (5272,16449,3422,15656,20,5,10);    -- brass_dagger
INSERT INTO `guild_shops` VALUES (5272,16551,3631,15487,20,0,10);    -- sapara
INSERT INTO `guild_shops` VALUES (5272,16641,2870,13845,20,0,10);    -- brass_axe
INSERT INTO `guild_shops` VALUES (5272,16769,2245,13221,20,0,10);    -- brass_zaghnal
INSERT INTO `guild_shops` VALUES (5272,17043,1735,1839,20,0,10);     -- brass_hammer

-- Yabby Tanmikey (Goldsmith Guild) Mhaura (S)
INSERT INTO `guild_shops` VALUES (528,640,9,20,255,48,100);
INSERT INTO `guild_shops` VALUES (528,736,315,945,255,48,100);
INSERT INTO `guild_shops` VALUES (528,769,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,770,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,771,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,772,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,773,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,774,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,775,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,776,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (528,2143,320,320,255,48,100);
INSERT INTO `guild_shops` VALUES (528,2144,75,75,255,48,100);

-- Kueh Igunahmori (Leathercraft Guild) Southern San d'Oria (S)
INSERT INTO `guild_shops` VALUES (529,505,62,349,255,48,100);
INSERT INTO `guild_shops` VALUES (529,506,9600,11333,165,0,65);
INSERT INTO `guild_shops` VALUES (529,695,120,184,255,48,100);
INSERT INTO `guild_shops` VALUES (529,832,1000,2800,80,20,40);
INSERT INTO `guild_shops` VALUES (529,848,2912,4636,80,0,32);
INSERT INTO `guild_shops` VALUES (529,850,390,390,80,0,32);
INSERT INTO `guild_shops` VALUES (529,851,2718,7139,80,0,32);
INSERT INTO `guild_shops` VALUES (529,852,630,640,255,0,100);
INSERT INTO `guild_shops` VALUES (529,853,2400,6000,165,36,65);
INSERT INTO `guild_shops` VALUES (529,854,2650,3304,165,33,65);
INSERT INTO `guild_shops` VALUES (529,855,9077,10874,30,0,12);
INSERT INTO `guild_shops` VALUES (529,856,45,130,255,48,100);
INSERT INTO `guild_shops` VALUES (529,857,1290,1990,255,0,100);
INSERT INTO `guild_shops` VALUES (529,858,483,1161,165,33,65);
INSERT INTO `guild_shops` VALUES (529,859,937,2650,80,33,32);
INSERT INTO `guild_shops` VALUES (529,861,1312,3124,55,11,22);
INSERT INTO `guild_shops` VALUES (529,863,4000,8000,55,11,22);
INSERT INTO `guild_shops` VALUES (529,917,481,963,255,0,100);
INSERT INTO `guild_shops` VALUES (529,1116,5000,8600,30,6,12);
INSERT INTO `guild_shops` VALUES (529,1117,8385,15000,30,0,12);
INSERT INTO `guild_shops` VALUES (529,2129,75,75,255,48,100);
INSERT INTO `guild_shops` VALUES (529,4509,9,23,375,75,150);
INSERT INTO `guild_shops` VALUES (529,12294,13500,14000,10,0,10);
INSERT INTO `guild_shops` VALUES (529,12440,330,880,20,0,20);
INSERT INTO `guild_shops` VALUES (529,12441,3318,8407,20,0,15);
INSERT INTO `guild_shops` VALUES (529,12442,8000,9000,20,0,10);
INSERT INTO `guild_shops` VALUES (529,12443,8500,9300,20,0,20);
INSERT INTO `guild_shops` VALUES (529,12444,9200,10000,20,0,5);
INSERT INTO `guild_shops` VALUES (529,12568,987,1323,20,0,20);
INSERT INTO `guild_shops` VALUES (529,12569,5145,16189,20,0,15);     -- lizard_jerkin
INSERT INTO `guild_shops` VALUES (529,12570,44232,44916,20,0,10);    -- studded_vest
INSERT INTO `guild_shops` VALUES (529,12571,32340,84946,20,0,5);     -- cuir_bouilli
INSERT INTO `guild_shops` VALUES (529,12572,44460,116781,20,0,5);    -- raptor_jerkin
INSERT INTO `guild_shops` VALUES (529,12696,318,1612,20,0,20);       -- leather_gloves
INSERT INTO `guild_shops` VALUES (529,12697,2700,7092,20,0,15);      -- lizard_gloves
INSERT INTO `guild_shops` VALUES (529,12698,11610,53625,20,0,10);    -- studded_gloves
INSERT INTO `guild_shops` VALUES (529,12699,17052,44789,20,0,5);     -- cuir_gloves
INSERT INTO `guild_shops` VALUES (529,12700,29700,150480,20,0,5);    -- raptor_gloves
INSERT INTO `guild_shops` VALUES (529,12825,5819,10714,20,0,15);     -- lizard_trousers
INSERT INTO `guild_shops` VALUES (529,12826,32002,36232,20,0,10);    -- studded_trousers
INSERT INTO `guild_shops` VALUES (529,12827,25200,66192,20,0,5);     -- cuir_trousers
INSERT INTO `guild_shops` VALUES (529,12828,42900,112684,20,0,5);    -- raptor_trousers
INSERT INTO `guild_shops` VALUES (529,12952,504,1639,20,0,20);       -- leather_highboots
INSERT INTO `guild_shops` VALUES (529,12953,2578,16777,20,0,15);     -- lizard_ledelsens
INSERT INTO `guild_shops` VALUES (529,12955,15624,41039,20,0,5);     -- cuir_highboots
INSERT INTO `guild_shops` VALUES (529,12956,58027,72811,20,0,5);     -- raptor_ledelsens
INSERT INTO `guild_shops` VALUES (529,12992,453,1815,20,0,20);       -- solea
INSERT INTO `guild_shops` VALUES (529,12993,3366,8841,20,0,15);      -- sandals
INSERT INTO `guild_shops` VALUES (529,12994,11481,28273,20,0,10);    -- shoes
INSERT INTO `guild_shops` VALUES (529,12995,48960,76296,20,0,5);     -- moccasins
INSERT INTO `guild_shops` VALUES (529,13081,211,1003,20,0,20);       -- leather_gorget
INSERT INTO `guild_shops` VALUES (529,13089,6384,15662,20,0,15);     -- wolf_gorget
INSERT INTO `guild_shops` VALUES (529,13192,837,1224,20,10,20);      -- leather_belt
INSERT INTO `guild_shops` VALUES (529,13193,4590,12420,20,0,15);     -- lizard_belt
INSERT INTO `guild_shops` VALUES (529,13194,16896,20803,20,0,5);     -- warriors_belt
INSERT INTO `guild_shops` VALUES (529,13195,2277,5980,20,0,10);      -- magic_belt
INSERT INTO `guild_shops` VALUES (529,13200,13860,35112,20,0,10);    -- waistbelt
INSERT INTO `guild_shops` VALUES (529,13203,2277,5980,20,0,10);      -- barbarians_belt
INSERT INTO `guild_shops` VALUES (529,13469,937,2087,20,0,20);       -- leather_ring
INSERT INTO `guild_shops` VALUES (529,13570,10800,25488,20,0,10);    -- ram_mantle
INSERT INTO `guild_shops` VALUES (529,13571,6426,31530,20,0,10);     -- wolf_mantle
INSERT INTO `guild_shops` VALUES (529,13588,2484,14440,20,0,10);     -- dhalmel_mantle
INSERT INTO `guild_shops` VALUES (529,13592,2065,9804,20,0,15);      -- lizard_mantle
INSERT INTO `guild_shops` VALUES (529,13593,24000,62080,20,0,5);     -- raptor_mantle
INSERT INTO `guild_shops` VALUES (529,13594,132,316,20,10,20);       -- rabbit_mantle
INSERT INTO `guild_shops` VALUES (529,13703,44100,108192,20,0,3);    -- brigandine
INSERT INTO `guild_shops` VALUES (529,16385,279,283,20,0,20);        -- cesti
INSERT INTO `guild_shops` VALUES (529,16386,945,5997,20,0,15);       -- lizard_cesti
INSERT INTO `guild_shops` VALUES (529,16388,11970,27700,20,0,5);     -- himantes

-- Kopopo (Windurst Waters) Cooking Guild (S)
INSERT INTO `guild_shops` VALUES (530,610,45,144,255,48,100);
INSERT INTO `guild_shops` VALUES (530,611,30,60,255,48,100);
INSERT INTO `guild_shops` VALUES (530,612,45,114,255,48,100);
INSERT INTO `guild_shops` VALUES (530,614,60,152,255,48,100);
INSERT INTO `guild_shops` VALUES (530,615,45,119,255,0,100);
INSERT INTO `guild_shops` VALUES (530,616,60,368,255,48,100);
INSERT INTO `guild_shops` VALUES (530,618,21,42,255,48,100);
INSERT INTO `guild_shops` VALUES (530,620,45,276,255,48,100);
INSERT INTO `guild_shops` VALUES (530,621,21,40,255,48,100);
INSERT INTO `guild_shops` VALUES (530,622,36,94,255,48,100);
INSERT INTO `guild_shops` VALUES (530,625,66,221,255,48,100);
INSERT INTO `guild_shops` VALUES (530,627,40,80,255,0,100);
INSERT INTO `guild_shops` VALUES (530,628,195,494,255,48,100);
INSERT INTO `guild_shops` VALUES (530,629,36,144,255,48,100);
INSERT INTO `guild_shops` VALUES (530,636,30,57,255,0,100);
INSERT INTO `guild_shops` VALUES (530,1111,450,2832,255,0,100);
INSERT INTO `guild_shops` VALUES (530,1554,431,754,255,48,100);
INSERT INTO `guild_shops` VALUES (530,1555,1061,1854,255,48,100);
INSERT INTO `guild_shops` VALUES (530,1590,536,992,255,48,100);
INSERT INTO `guild_shops` VALUES (530,1840,1500,2800,255,48,100);
INSERT INTO `guild_shops` VALUES (530,2110,457,530,255,48,100);
INSERT INTO `guild_shops` VALUES (530,2111,525,530,255,48,100);
INSERT INTO `guild_shops` VALUES (530,2112,530,540,255,48,100);
INSERT INTO `guild_shops` VALUES (530,4156,3872,3936,55,0,22);
INSERT INTO `guild_shops` VALUES (530,4356,154,992,165,0,65);
INSERT INTO `guild_shops` VALUES (530,4358,61,64,255,0,100);
INSERT INTO `guild_shops` VALUES (530,4359,180,475,255,0,100);
INSERT INTO `guild_shops` VALUES (530,4360,114,160,255,0,100);
INSERT INTO `guild_shops` VALUES (530,4362,117,120,255,0,100);
INSERT INTO `guild_shops` VALUES (530,4363,33,183,255,48,100);
INSERT INTO `guild_shops` VALUES (530,4364,102,427,255,0,100);       -- black_bread
INSERT INTO `guild_shops` VALUES (530,4365,192,600,255,0,100);       -- rolanberry
INSERT INTO `guild_shops` VALUES (530,4366,18,100,255,48,100);       -- la_theine_cbg.
INSERT INTO `guild_shops` VALUES (530,4367,36,124,255,48,100);       -- batagreens
INSERT INTO `guild_shops` VALUES (530,4370,163,590,255,0,100);       -- honey
INSERT INTO `guild_shops` VALUES (530,4371,252,743,55,11,22);        -- grilled_hare
INSERT INTO `guild_shops` VALUES (530,4372,83,230,255,48,100);       -- g._sheep_meat
INSERT INTO `guild_shops` VALUES (530,4376,90,288,255,48,100);       -- meat_jerky
INSERT INTO `guild_shops` VALUES (530,4378,45,268,255,48,100);       -- selbina_milk
INSERT INTO `guild_shops` VALUES (530,4380,437,1091,165,33,65);      -- smoked_salmon
INSERT INTO `guild_shops` VALUES (530,4381,1382,3600,165,33,65);     -- meat_mithkabob
INSERT INTO `guild_shops` VALUES (530,4382,58,64,165,0,65);          -- frost_turnip
INSERT INTO `guild_shops` VALUES (530,4383,3906,5760,165,0,65);      -- gold_lobster
INSERT INTO `guild_shops` VALUES (530,4387,709,1934,255,0,100);      -- wild_onion
INSERT INTO `guild_shops` VALUES (530,4389,43,153,255,0,100);        -- san_dor._carrot
INSERT INTO `guild_shops` VALUES (530,4390,51,198,255,48,100);       -- mithran_tomato
INSERT INTO `guild_shops` VALUES (530,4392,45,149,255,48,100);       -- saruta_orange
INSERT INTO `guild_shops` VALUES (530,4394,9,55,255,0,100);          -- ginger_cookie
INSERT INTO `guild_shops` VALUES (530,4398,2149,3256,165,33,65);     -- fish_mithkabob
INSERT INTO `guild_shops` VALUES (530,4399,2592,2700,165,33,65);     -- bluetail
INSERT INTO `guild_shops` VALUES (530,4406,734,1988,165,33,65);      -- baked_apple
INSERT INTO `guild_shops` VALUES (530,4408,105,250,165,33,65);       -- tortilla
INSERT INTO `guild_shops` VALUES (530,4409,132,211,165,33,65);       -- hard-boiled_egg
INSERT INTO `guild_shops` VALUES (530,4410,626,1962,165,33,65);      -- roast_mushroom
INSERT INTO `guild_shops` VALUES (530,4412,412,1118,165,33,65);      -- thundermelon
INSERT INTO `guild_shops` VALUES (530,4413,240,1420,165,33,65);      -- apple_pie
INSERT INTO `guild_shops` VALUES (530,4415,93,565,165,0,65);         -- roasted_corn
INSERT INTO `guild_shops` VALUES (530,4416,2716,6944,165,0,65);      -- pea_soup
INSERT INTO `guild_shops` VALUES (530,4417,2475,15972,165,0,65);     -- egg_soup
INSERT INTO `guild_shops` VALUES (530,4419,12390,14000,165,0,65);    -- mushroom_soup
INSERT INTO `guild_shops` VALUES (530,4420,13124,13230,165,0,65);    -- tomato_soup
INSERT INTO `guild_shops` VALUES (530,4422,150,328,55,11,22);        -- orange_juice
INSERT INTO `guild_shops` VALUES (530,4423,225,720,55,11,22);        -- apple_juice
INSERT INTO `guild_shops` VALUES (530,4424,825,4488,55,11,22);       -- melon_juice
INSERT INTO `guild_shops` VALUES (530,4425,240,1113,55,11,22);       -- tomato_juice
INSERT INTO `guild_shops` VALUES (530,4431,72,376,255,48,100);       -- san_dor._grape
INSERT INTO `guild_shops` VALUES (530,4432,87,192,255,0,100);        -- kazham_pineapl.
INSERT INTO `guild_shops` VALUES (530,4435,3520,3968,165,0,65);      -- cockatrice_meat
INSERT INTO `guild_shops` VALUES (530,4436,240,1113,165,0,65);       -- baked_popoto
INSERT INTO `guild_shops` VALUES (530,4437,240,1113,55,11,22);       -- roast_mutton
INSERT INTO `guild_shops` VALUES (530,4438,2750,7084,55,11,22);      -- dhalmel_steak
INSERT INTO `guild_shops` VALUES (530,4441,753,3720,55,11,22);       -- grape_juice
INSERT INTO `guild_shops` VALUES (530,4442,300,1504,55,11,22);       -- pineapple_juice
INSERT INTO `guild_shops` VALUES (530,4444,18,45,165,33,65);         -- rarab_tail
INSERT INTO `guild_shops` VALUES (530,4445,41,88,165,33,65);         -- yagudo_cherry
INSERT INTO `guild_shops` VALUES (530,4455,968,984,165,33,65);       -- pebble_soup
INSERT INTO `guild_shops` VALUES (530,4456,2452,10620,165,33,65);    -- boiled_crab
INSERT INTO `guild_shops` VALUES (530,4457,4800,13920,165,0,65);     -- eel_kabob
INSERT INTO `guild_shops` VALUES (530,4468,60,208,165,33,65);        -- pamamas
INSERT INTO `guild_shops` VALUES (530,4482,1408,1984,255,0,100);     -- nosteau_herring
INSERT INTO `guild_shops` VALUES (530,4490,955,2284,165,0,65);       -- pickled_herring
INSERT INTO `guild_shops` VALUES (530,4491,150,696,165,33,65);       -- watermelon
INSERT INTO `guild_shops` VALUES (530,4492,1182,2845,55,11,22);      -- puls
INSERT INTO `guild_shops` VALUES (530,4499,75,320,165,0,65);         -- iron_bread
INSERT INTO `guild_shops` VALUES (530,4537,967,2600,165,33,65);      -- roast_carp
INSERT INTO `guild_shops` VALUES (530,4538,1628,4232,165,33,65);     -- roast_pipira
INSERT INTO `guild_shops` VALUES (530,4556,10644,10644,55,11,22);    -- icecap_rolanberry
INSERT INTO `guild_shops` VALUES (530,4560,2861,2861,55,11,22);      -- vegetable_soup
INSERT INTO `guild_shops` VALUES (530,4563,6113,15360,15,0,6);       -- pamama_tart
INSERT INTO `guild_shops` VALUES (530,4570,47,245,255,48,100);       -- bird_egg
INSERT INTO `guild_shops` VALUES (530,4571,75,460,255,48,100);       -- beaugreens
INSERT INTO `guild_shops` VALUES (530,4572,1360,7260,55,11,22);      -- beaugr._saute

-- Doggomehr (Northern San d'Oria) Smithing Guild (S)
INSERT INTO `guild_shops` VALUES (531,640,9,36,255,48,100);
INSERT INTO `guild_shops` VALUES (531,641,30,66,255,48,100);
INSERT INTO `guild_shops` VALUES (531,643,675,981,165,33,65);
INSERT INTO `guild_shops` VALUES (531,649,115,349,165,33,65);
INSERT INTO `guild_shops` VALUES (531,651,2700,10800,165,33,65);
INSERT INTO `guild_shops` VALUES (531,652,25620,25620,80,16,32);
INSERT INTO `guild_shops` VALUES (531,660,69,294,165,33,65);
INSERT INTO `guild_shops` VALUES (531,662,4050,9898,165,33,65);
INSERT INTO `guild_shops` VALUES (531,666,14868,39984,165,0,65);
INSERT INTO `guild_shops` VALUES (531,672,81,254,165,0,65);
INSERT INTO `guild_shops` VALUES (531,676,13720,13720,80,0,32);
INSERT INTO `guild_shops` VALUES (531,680,11781,11781,80,0,32);
INSERT INTO `guild_shops` VALUES (531,1155,2400,2400,165,33,65);
INSERT INTO `guild_shops` VALUES (531,2143,320,320,255,48,100);
INSERT INTO `guild_shops` VALUES (531,2144,75,75,255,48,100);
INSERT INTO `guild_shops` VALUES (531,12424,7695,26676,20,0,15);
INSERT INTO `guild_shops` VALUES (531,12432,2711,2856,20,10,20);
INSERT INTO `guild_shops` VALUES (531,12688,1666,5664,20,7,15);
INSERT INTO `guild_shops` VALUES (531,12944,1519,5294,20,0,15);
INSERT INTO `guild_shops` VALUES (531,13783,81084,162345,20,0,10);
INSERT INTO `guild_shops` VALUES (531,13871,27216,47355,20,0,10);
INSERT INTO `guild_shops` VALUES (531,13873,61107,70963,20,3,5);
INSERT INTO `guild_shops` VALUES (531,14001,42476,88529,20,0,10);
INSERT INTO `guild_shops` VALUES (531,14003,79745,84198,20,0,5);
INSERT INTO `guild_shops` VALUES (531,14245,52785,166096,20,0,5);
INSERT INTO `guild_shops` VALUES (531,16412,56544,56544,20,0,10);
INSERT INTO `guild_shops` VALUES (531,16448,240,761,20,0,20);
INSERT INTO `guild_shops` VALUES (531,16532,36503,36503,20,0,10);
INSERT INTO `guild_shops` VALUES (531,16535,509,1056,20,0,20);
INSERT INTO `guild_shops` VALUES (531,16537,25800,32680,20,0,10);    -- mythril_sword
INSERT INTO `guild_shops` VALUES (531,16565,1395,8853,20,0,15);      -- spatha
INSERT INTO `guild_shops` VALUES (531,16589,10444,67958,20,0,10);    -- two-hand._sword
INSERT INTO `guild_shops` VALUES (531,16650,18270,36987,20,5,10);    -- war_pick
INSERT INTO `guild_shops` VALUES (531,16651,66555,168606,20,2,5);    -- mythril_pick
INSERT INTO `guild_shops` VALUES (531,16768,643,677,20,0,20);        -- bronze_zaghnal
INSERT INTO `guild_shops` VALUES (531,16770,16803,24703,20,0,15);    -- zaghnal
INSERT INTO `guild_shops` VALUES (531,17034,313,917,20,0,15);        -- bronze_mace

-- Kamilah (Mhaura) Smithing Guild (S)
INSERT INTO `guild_shops` VALUES (532,640,9,20,255,48,100);
INSERT INTO `guild_shops` VALUES (532,641,30,66,255,48,100);
INSERT INTO `guild_shops` VALUES (532,643,675,1224,165,33,65);
INSERT INTO `guild_shops` VALUES (532,652,3517,22890,80,16,32);
INSERT INTO `guild_shops` VALUES (532,660,61,423,165,33,65);
INSERT INTO `guild_shops` VALUES (532,672,72,209,165,0,65);
INSERT INTO `guild_shops` VALUES (532,680,12400,12411,80,0,32);
INSERT INTO `guild_shops` VALUES (532,12706,21945,21945,20,0,15);

-- Amulya (Metalworks) Smithing Guild (S)
INSERT INTO `guild_shops` VALUES (5332,640,9,44,255,48,100);         -- copper_ore
INSERT INTO `guild_shops` VALUES (5332,641,30,66,255,48,100);        -- tin_ore
INSERT INTO `guild_shops` VALUES (5332,643,675,1656,165,33,65);      -- iron_ore
INSERT INTO `guild_shops` VALUES (5332,644,2000,10000,165,33,65);    -- mythril_ore
INSERT INTO `guild_shops` VALUES (5332,649,103,349,165,33,65);       -- bronze_ingot
INSERT INTO `guild_shops` VALUES (5332,651,2700,4680,165,33,65);     -- iron_ingot
INSERT INTO `guild_shops` VALUES (5332,660,69,294,165,33,65);        -- bronze_sheet
INSERT INTO `guild_shops` VALUES (5332,662,4050,7020,165,33,65);     -- iron_sheet
INSERT INTO `guild_shops` VALUES (5332,664,66690,66690,30,0,12);     -- darksteel_sheet
INSERT INTO `guild_shops` VALUES (5332,672,81,106,165,0,65);         -- bronze_scales
INSERT INTO `guild_shops` VALUES (5332,674,4945,12411,165,0,65);     -- iron_scales
INSERT INTO `guild_shops` VALUES (5332,676,7350,11466,80,0,32);      -- steel_scales
INSERT INTO `guild_shops` VALUES (5332,680,4725,11592,80,0,32);      -- iron_chain
INSERT INTO `guild_shops` VALUES (5332,2143,75,75,255,48,100);       -- mandrel
INSERT INTO `guild_shops` VALUES (5332,2144,75,75,255,48,100);       -- workshop_anvil
INSERT INTO `guild_shops` VALUES (5332,12299,708,2835,20,0,15);      -- aspis
INSERT INTO `guild_shops` VALUES (5332,12450,15300,15300,20,0,10);   -- padded_cap
INSERT INTO `guild_shops` VALUES (5332,12544,36855,83538,20,0,5);    -- breastplate
INSERT INTO `guild_shops` VALUES (5332,12578,61086,81086,20,0,10);   -- padded_armor
INSERT INTO `guild_shops` VALUES (5332,12672,19440,23328,20,0,15);   -- gauntlets
INSERT INTO `guild_shops` VALUES (5332,12704,191,394,20,0,20);       -- bronze_mittens
INSERT INTO `guild_shops` VALUES (5332,12706,12960,12960,20,0,15);   -- iron_mittens
INSERT INTO `guild_shops` VALUES (5332,12800,34020,69552,20,0,10);   -- cuisses
INSERT INTO `guild_shops` VALUES (5332,12832,409,818,20,0,20);       -- bronze_subligar
INSERT INTO `guild_shops` VALUES (5332,12836,19008,38565,20,0,10);   -- iron_subligar
INSERT INTO `guild_shops` VALUES (5332,12928,34927,45144,20,0,5);    -- plate_leggings
INSERT INTO `guild_shops` VALUES (5332,12962,27866,76830,20,0,5);    -- leggings
INSERT INTO `guild_shops` VALUES (5332,13080,13770,14412,20,0,10);   -- gorget
INSERT INTO `guild_shops` VALUES (5332,16406,10713,17020,20,0,10);   -- baghnakhs
INSERT INTO `guild_shops` VALUES (5332,16465,229,754,20,0,20);       -- bronze_knife
INSERT INTO `guild_shops` VALUES (5332,16467,22422,22422,20,0,10);
INSERT INTO `guild_shops` VALUES (5332,16552,8914,8914,20,0,15);
INSERT INTO `guild_shops` VALUES (5332,16558,10200,81600,20,0,10);
INSERT INTO `guild_shops` VALUES (5332,16640,622,2898,20,0,20);
INSERT INTO `guild_shops` VALUES (5332,16657,95040,314160,20,0,3);
INSERT INTO `guild_shops` VALUES (5332,16704,1323,3565,20,0,10);
INSERT INTO `guild_shops` VALUES (5332,16706,30912,90783,20,0,10);
INSERT INTO `guild_shops` VALUES (5332,17045,11970,29366,20,0,10);
INSERT INTO `guild_shops` VALUES (5332,17298,598,620,2970,0,1188);
INSERT INTO `guild_shops` VALUES (5332,17336,4,11,2970,0,1188);

-- Beugungel (Carpenter's Landing) Woodworking Guild
INSERT INTO `guild_shops` VALUES (534,688,12,30,255,48,100);
INSERT INTO `guild_shops` VALUES (534,693,640,1622,255,48,100);
INSERT INTO `guild_shops` VALUES (534,695,120,184,255,48,100);
INSERT INTO `guild_shops` VALUES (534,696,330,686,255,48,100);
INSERT INTO `guild_shops` VALUES (534,698,93,182,255,48,100);
INSERT INTO `guild_shops` VALUES (534,1021,312,500,255,48,100);
INSERT INTO `guild_shops` VALUES (534,1657,75,255,255,48,100);

-- Akamafula (Lower Jeuno) Tenshodo Merchent
INSERT INTO `guild_shops` VALUES (60417,16896,517,592,20,10,20);
INSERT INTO `guild_shops` VALUES (60417,16900,1404,1608,20,7,15);
INSERT INTO `guild_shops` VALUES (60417,16960,3121,3575,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,16974,224510,224510,20,1,3);
INSERT INTO `guild_shops` VALUES (60417,16975,11583,13266,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,16966,1836,2103,20,10,20);
INSERT INTO `guild_shops` VALUES (60417,16982,4752,15760,20,0,10);
INSERT INTO `guild_shops` VALUES (60417,16987,12253,14033,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,17265,25372,25732,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,17301,29,87,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60417,12456,552,858,20,10,20);
INSERT INTO `guild_shops` VALUES (60417,12457,3272,5079,20,7,15);
INSERT INTO `guild_shops` VALUES (60417,12458,8972,13927,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,13111,20061,29942,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,12584,833,1294,20,10,20);
INSERT INTO `guild_shops` VALUES (60417,12585,4931,7654,20,7,15);
INSERT INTO `guild_shops` VALUES (60417,12586,13266,14850,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,12712,458,712,20,10,20);
INSERT INTO `guild_shops` VALUES (60417,12713,2713,4212,20,7,15);
INSERT INTO `guild_shops` VALUES (60417,12714,2713,8316,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,12840,666,1034,20,10,20);
INSERT INTO `guild_shops` VALUES (60417,12841,2713,6133,20,7,15);
INSERT INTO `guild_shops` VALUES (60417,12842,10805,12096,20,5,10);
INSERT INTO `guild_shops` VALUES (60417,12968,424,660,20,10,20);
INSERT INTO `guild_shops` VALUES (60417,12969,2528,3924,20,7,15);
INSERT INTO `guild_shops` VALUES (60417,12970,11071,12393,20,5,10);

-- Blabbivix (Port Bastok) / Gaudylox (Northern San dOria) / Scavnix (Windurst Walls) (Chip Vendors pseudo guild shop)
INSERT INTO `guild_shops` VALUES (60418,474,21000,21000,255,255,255);
INSERT INTO `guild_shops` VALUES (60418,475,21000,21000,255,255,255);
INSERT INTO `guild_shops` VALUES (60418,476,21000,21000,255,255,255);
INSERT INTO `guild_shops` VALUES (60418,477,21000,21000,255,255,255);
INSERT INTO `guild_shops` VALUES (60418,478,21000,21000,255,255,255);
INSERT INTO `guild_shops` VALUES (60418,479,21000,21000,255,255,255);
INSERT INTO `guild_shops` VALUES (60418,480,21000,21000,255,255,255);
INSERT INTO `guild_shops` VALUES (60418,481,21000,21000,255,255,255);

-- Jabbar (Port Bastok) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60419,704,96,149,255,48,100);
INSERT INTO `guild_shops` VALUES (60419,657,4690,21000,165,33,65);
INSERT INTO `guild_shops` VALUES (60419,4928,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60419,4934,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60419,4937,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60419,4943,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60419,4878,37800,41370,30,6,12);
INSERT INTO `guild_shops` VALUES (60419,4879,14070,15750,30,6,12);
INSERT INTO `guild_shops` VALUES (60419,4880,14070,15750,30,6,12);
INSERT INTO `guild_shops` VALUES (60419,1554,431,512,255,48,100);
INSERT INTO `guild_shops` VALUES (60419,1555,1061,1259,255,48,100);
INSERT INTO `guild_shops` VALUES (60419,1590,536,700,255,48,100);
INSERT INTO `guild_shops` VALUES (60419,1475,579,1188,255,48,100);
INSERT INTO `guild_shops` VALUES (60419,4876,39270,41370,15,0,6);
INSERT INTO `guild_shops` VALUES (60419,4877,39270,41370,15,0,6);
INSERT INTO `guild_shops` VALUES (60419,1164,30,120,2970,0,1188);
INSERT INTO `guild_shops` VALUES (60419,4874,39270,41370,15,0,6);
INSERT INTO `guild_shops` VALUES (60419,5164,1945,2854,255,48,100);
INSERT INTO `guild_shops` VALUES (60419,1652,233,250,255,48,100);
INSERT INTO `guild_shops` VALUES (60419,5236,509,525,255,48,100);

-- Silver Owl (Port Bastok) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60420,16896,517,592,20,10,20);
INSERT INTO `guild_shops` VALUES (60420,16919,2728,3125,20,7,15);
INSERT INTO `guild_shops` VALUES (60420,16975,11583,13266,20,5,10);
INSERT INTO `guild_shops` VALUES (60420,16988,14676,16808,20,7,15);
INSERT INTO `guild_shops` VALUES (60420,12456,552,858,20,10,20);
INSERT INTO `guild_shops` VALUES (60420,12457,3272,5079,20,7,15);
INSERT INTO `guild_shops` VALUES (60420,13111,20061,29942,20,5,10);
INSERT INTO `guild_shops` VALUES (60420,13088,43890,52440,20,1,3);
INSERT INTO `guild_shops` VALUES (60420,12584,833,1294,20,10,20);
INSERT INTO `guild_shops` VALUES (60420,12585,4931,7654,20,7,15);
INSERT INTO `guild_shops` VALUES (60420,12712,458,712,20,10,20);
INSERT INTO `guild_shops` VALUES (60420,12713,2713,4212,20,7,15);
INSERT INTO `guild_shops` VALUES (60420,12840,666,1034,20,10,20);
INSERT INTO `guild_shops` VALUES (60420,12968,424,660,20,10,20);
INSERT INTO `guild_shops` VALUES (60420,12969,2528,3924,20,7,15);
INSERT INTO `guild_shops` VALUES (60420,16405,104,225,20,0,20);
INSERT INTO `guild_shops` VALUES (60420,17314,7333,7446,15,0,6);

-- Achika (Norg) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60421,12456,552,858,20,10,20);
INSERT INTO `guild_shops` VALUES (60421,12457,3272,5079,20,7,15);
INSERT INTO `guild_shops` VALUES (60421,12458,8972,13927,20,5,10);
INSERT INTO `guild_shops` VALUES (60421,13111,20061,29942,20,5,10);
INSERT INTO `guild_shops` VALUES (60421,13088,43890,52440,20,1,3);
INSERT INTO `guild_shops` VALUES (60421,12584,833,1294,20,10,20);
INSERT INTO `guild_shops` VALUES (60421,12585,4931,7654,20,7,15);
INSERT INTO `guild_shops` VALUES (60421,12586,13266,14850,20,5,10);
INSERT INTO `guild_shops` VALUES (60421,12712,458,712,20,10,20);
INSERT INTO `guild_shops` VALUES (60421,12713,2713,4212,20,7,15);
INSERT INTO `guild_shops` VALUES (60421,12714,2713,8316,20,5,10);
INSERT INTO `guild_shops` VALUES (60421,12840,666,1034,20,10,20);
INSERT INTO `guild_shops` VALUES (60421,12841,3951,6133,20,7,15);
INSERT INTO `guild_shops` VALUES (60421,12842,10805,12096,20,5,10);
INSERT INTO `guild_shops` VALUES (60421,12968,424,660,20,10,20);
INSERT INTO `guild_shops` VALUES (60421,12969,2528,3924,20,7,15);
INSERT INTO `guild_shops` VALUES (60421,12970,11071,12393,20,5,10);

-- Chiyo (Norg) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60422,4876,39270,41370,15,3,6);
INSERT INTO `guild_shops` VALUES (60422,4879,14070,15750,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4880,14070,15750,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4928,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4931,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4934,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4937,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4940,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4943,1561,1747,30,6,12);
INSERT INTO `guild_shops` VALUES (60422,4877,39270,41370,15,3,6);
INSERT INTO `guild_shops` VALUES (60422,4878,37800,41370,30,6,12);

-- Jirokichi (Norg) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60423,16406,14428,34214,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,16411,11746,21322,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,16419,45760,76416,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,16896,517,592,20,10,20);
INSERT INTO `guild_shops` VALUES (60423,16917,4226,4226,20,7,15);
INSERT INTO `guild_shops` VALUES (60423,16900,1404,1608,20,7,15);
INSERT INTO `guild_shops` VALUES (60423,16919,2728,3125,20,7,15);
INSERT INTO `guild_shops` VALUES (60423,16960,3121,3575,20,7,15);
INSERT INTO `guild_shops` VALUES (60423,16975,11583,13266,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,16966,1836,2103,20,10,20);
INSERT INTO `guild_shops` VALUES (60423,16982,4752,15760,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,16987,12253,14033,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,16988,14676,16808,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,17802,189945,464059,20,2,3);
INSERT INTO `guild_shops` VALUES (60423,16871,183516,404395,20,2,3);
INSERT INTO `guild_shops` VALUES (60423,17259,72144,158976,20,5,10);
INSERT INTO `guild_shops` VALUES (60423,17301,29,87,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60423,17302,347,993,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60423,17303,7333,10120,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60423,17285,101745,101745,20,1,5);
INSERT INTO `guild_shops` VALUES (60423,17314,7333,7446,15,3,6);
INSERT INTO `guild_shops` VALUES (60423,17320,7,10,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60423,17322,81,187,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60423,17340,58,436,2970,594,1188);

-- Vuliaie (Norg) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60424,704,96,149,375,75,150);
INSERT INTO `guild_shops` VALUES (60424,915,2700,16120,165,33,165);
INSERT INTO `guild_shops` VALUES (60424,1134,810,2095,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,1155,436,645,165,33,165);
INSERT INTO `guild_shops` VALUES (60424,657,4690,21000,165,33,65);
INSERT INTO `guild_shops` VALUES (60424,1415,55147,55147,165,33,65);
INSERT INTO `guild_shops` VALUES (60424,1161,66,174,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60424,1164,30,120,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60424,1167,58,107,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60424,1170,58,107,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60424,1173,56,174,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60424,1176,44,174,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60424,1472,369,369,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,1554,431,512,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,1555,1061,1259,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,1590,536,700,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,1475,579,1188,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,5164,1945,2854,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,1652,233,250,255,48,100);
INSERT INTO `guild_shops` VALUES (60424,5235,1284,1350,255,48,100);

-- Wahraga (Alchemy Guild) Aht Urhgan Whitegate
INSERT INTO `guild_shops` VALUES (60425,621,21,50,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,622,37,86,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,636,106,234,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,638,138,156,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,914,1125,3375,165,33,65);
INSERT INTO `guild_shops` VALUES (60425,920,1084,3000,165,35,65);
INSERT INTO `guild_shops` VALUES (60425,933,660,1992,165,33,65);
INSERT INTO `guild_shops` VALUES (60425,951,90,216,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,1108,573,826,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,2131,75,242,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,2175,644,644,80,0,32);
INSERT INTO `guild_shops` VALUES (60425,2229,1080,3000,80,16,32);
INSERT INTO `guild_shops` VALUES (60425,2309,963,963,80,16,32);
INSERT INTO `guild_shops` VALUES (60425,2316,9,9,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,4443,76,147,255,48,100);
INSERT INTO `guild_shops` VALUES (60425,4509,40,55,375,75,150);
INSERT INTO `guild_shops` VALUES (60425,17041,18000,24000,20,0,0);
INSERT INTO `guild_shops` VALUES (60425,18228,114,114,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60425,18232,114,114,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60425,18236,21,21,2970,594,1188);

-- Wahnid (Fishing Guild) Aht Urhgan Whitegate
INSERT INTO `guild_shops` VALUES (60426,2216,1045,1045,255,0,100);
INSERT INTO `guild_shops` VALUES (60426,4426,364,728,255,0,100);
INSERT INTO `guild_shops` VALUES (60426,4428,192,272,255,0,100);
INSERT INTO `guild_shops` VALUES (60426,4451,3540,16000,30,0,12);
INSERT INTO `guild_shops` VALUES (60426,4470,4369,4369,55,0,22);
INSERT INTO `guild_shops` VALUES (60426,4471,12544,12544,55,0,22);
INSERT INTO `guild_shops` VALUES (60426,4472,30,48,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,4477,8000,8000,30,0,12);
INSERT INTO `guild_shops` VALUES (60426,4485,10080,13328,30,0,12);
INSERT INTO `guild_shops` VALUES (60426,5134,89700,89700,6,0,2);
INSERT INTO `guild_shops` VALUES (60426,5140,74256,74256,6,0,2);
INSERT INTO `guild_shops` VALUES (60426,5141,7992,7992,15,0,6);
INSERT INTO `guild_shops` VALUES (60426,5447,21,128,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,5448,2652,7072,165,0,65);
INSERT INTO `guild_shops` VALUES (60426,5449,21,21,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,5453,4560,5952,80,16,32);
INSERT INTO `guild_shops` VALUES (60426,5454,5130,25920,80,16,32);
INSERT INTO `guild_shops` VALUES (60426,5456,1503,1503,165,0,65);
INSERT INTO `guild_shops` VALUES (60426,5458,900,900,255,0,100);
INSERT INTO `guild_shops` VALUES (60426,5459,1350,1350,255,0,100);
INSERT INTO `guild_shops` VALUES (60426,5460,3487,11532,165,0,65);
INSERT INTO `guild_shops` VALUES (60426,16992,52,254,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,16993,52,254,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,16994,52,254,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,16996,52,254,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,16997,52,254,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,16998,30,184,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,16999,52,254,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,17000,52,254,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,17380,25740,25740,30,5,5);
INSERT INTO `guild_shops` VALUES (60426,17382,9657,9657,30,5,10);
INSERT INTO `guild_shops` VALUES (60426,17383,1980,1980,30,10,20);
INSERT INTO `guild_shops` VALUES (60426,17387,4077,4077,30,5,15);
INSERT INTO `guild_shops` VALUES (60426,17388,934,934,30,10,20);
INSERT INTO `guild_shops` VALUES (60426,17389,332,332,30,10,20);
INSERT INTO `guild_shops` VALUES (60426,17390,145,145,30,10,20);
INSERT INTO `guild_shops` VALUES (60426,17391,44,44,30,10,20);
INSERT INTO `guild_shops` VALUES (60426,17392,213,283,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,17393,213,283,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,17394,220,300,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,17395,8,9,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,17396,3,8,255,48,100);
INSERT INTO `guild_shops` VALUES (60426,17399,2394,2394,20,6,12);
INSERT INTO `guild_shops` VALUES (60426,17404,540,540,20,6,12);
INSERT INTO `guild_shops` VALUES (60426,17405,540,540,20,6,12);
INSERT INTO `guild_shops` VALUES (60426,17407,303,303,20,6,12);

-- Ndego (Smithing Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60427,640,9,36,255,48,100);
INSERT INTO `guild_shops` VALUES (60427,641,30,43,255,48,100);
INSERT INTO `guild_shops` VALUES (60427,643,675,2700,165,33,65);
INSERT INTO `guild_shops` VALUES (60427,649,288,349,165,33,65);
INSERT INTO `guild_shops` VALUES (60427,651,2700,3060,165,33,65);
INSERT INTO `guild_shops` VALUES (60427,660,69,294,165,33,65);
INSERT INTO `guild_shops` VALUES (60427,662,4050,9898,165,33,65);
INSERT INTO `guild_shops` VALUES (60427,2143,320,320,255,48,100);
INSERT INTO `guild_shops` VALUES (60427,2144,75,75,255,48,100);

-- Dehbi Moshal (Woodworking Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60428,23,829,2035,20,0,15);
INSERT INTO `guild_shops` VALUES (60428,688,15,30,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,689,27,59,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,690,1401,10295,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,691,45,192,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,693,640,2459,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,694,2119,4182,165,33,65);
INSERT INTO `guild_shops` VALUES (60428,695,120,184,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,696,330,686,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,697,528,930,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,698,72,86,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,699,4740,29072,165,33,65);
INSERT INTO `guild_shops` VALUES (60428,700,9075,10103,165,33,65);
INSERT INTO `guild_shops` VALUES (60428,701,6615,18345,165,33,65);
INSERT INTO `guild_shops` VALUES (60428,702,9600,45568,165,33,65);
INSERT INTO `guild_shops` VALUES (60428,704,108,248,375,100,150);
INSERT INTO `guild_shops` VALUES (60428,705,7,18,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,706,27,97,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,707,1723,1838,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,708,45,276,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,710,2119,2543,165,33,65);
INSERT INTO `guild_shops` VALUES (60428,712,120,256,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,713,330,426,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,714,607,2559,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,715,72,215,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,716,4740,26544,165,33,65);
INSERT INTO `guild_shops` VALUES (60428,721,704,2465,255,48,100);
INSERT INTO `guild_shops` VALUES (60428,17318,6,13,8910,0,3564);
INSERT INTO `guild_shops` VALUES (60428,17320,21,26,5940,0,2376);
INSERT INTO `guild_shops` VALUES (60428,17321,48,60,2970,0,1188);

-- Bornahn (Goldsmithing Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60429,640,9,36,255,48,100);
INSERT INTO `guild_shops` VALUES (60429,644,1500,6000,165,0,65);
INSERT INTO `guild_shops` VALUES (60429,673,210,600,255,48,100);
INSERT INTO `guild_shops` VALUES (60429,681,10500,16000,30,6,12);
INSERT INTO `guild_shops` VALUES (60429,736,315,945,255,48,100);
INSERT INTO `guild_shops` VALUES (60429,769,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (60429,770,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (60429,771,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (60429,772,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (60429,773,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (60429,774,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (60429,775,1400,4200,165,33,65);
INSERT INTO `guild_shops` VALUES (60429,776,1400,4200,165,0,65);
INSERT INTO `guild_shops` VALUES (60429,795,1396,2794,80,16,32);
INSERT INTO `guild_shops` VALUES (60429,796,1396,2794,80,0,32);
INSERT INTO `guild_shops` VALUES (60429,799,1396,2794,80,16,32);
INSERT INTO `guild_shops` VALUES (60429,800,1396,2794,80,0,32);
INSERT INTO `guild_shops` VALUES (60429,806,1396,2794,80,16,32);
INSERT INTO `guild_shops` VALUES (60429,807,1396,2794,80,0,32);
INSERT INTO `guild_shops` VALUES (60429,809,1396,2794,80,0,32);
INSERT INTO `guild_shops` VALUES (60429,814,1396,2794,80,0,32);
INSERT INTO `guild_shops` VALUES (60429,2144,75,75,255,48,100);
INSERT INTO `guild_shops` VALUES (60429,13446,21060,21060,20,0,10);

-- Taten-Bilten (Clothcraft Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60430,2149,815,989,80,0,32);
INSERT INTO `guild_shops` VALUES (60430,825,480,640,80,16,32);
INSERT INTO `guild_shops` VALUES (60430,818,159,768,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,839,173,870,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,835,187,1000,375,75,100);
INSERT INTO `guild_shops` VALUES (60430,823,18240,62350,165,33,65);
INSERT INTO `guild_shops` VALUES (60430,824,240,1344,80,16,32);
INSERT INTO `guild_shops` VALUES (60430,817,45,240,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,2287,2700,17280,165,33,65);
INSERT INTO `guild_shops` VALUES (60430,819,750,790,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,833,15,18,375,75,150);
INSERT INTO `guild_shops` VALUES (60430,2148,815,989,80,0,32);
INSERT INTO `guild_shops` VALUES (60430,834,79,200,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,832,675,4500,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,822,1800,3400,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,2128,75,86,375,75,150);
INSERT INTO `guild_shops` VALUES (60430,2173,405,748,255,48,100);
INSERT INTO `guild_shops` VALUES (60430,2145,75,180,165,33,65);

-- Tsutsuroon (Tenshodo Merchant) Nashmau
INSERT INTO `guild_shops` VALUES (60431,16896,517,592,20,10,20);
INSERT INTO `guild_shops` VALUES (60431,16917,4226,4226,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,16900,1404,1608,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,16919,2728,3125,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,16960,3121,3575,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,16975,11583,13266,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,16966,1836,2103,20,10,20);
INSERT INTO `guild_shops` VALUES (60431,16982,4752,15760,20,0,10);
INSERT INTO `guild_shops` VALUES (60431,16987,12253,14033,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,16988,14676,16808,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,17802,189945,464059,20,2,3);
INSERT INTO `guild_shops` VALUES (60431,16871,183516,404395,20,2,3);
INSERT INTO `guild_shops` VALUES (60431,17259,72144,158976,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,17301,29,87,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,17302,347,993,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,17304,1472,3285,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,17322,81,187,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,17340,58,436,8910,0,3564);
INSERT INTO `guild_shops` VALUES (60431,12456,552,858,20,10,20);
INSERT INTO `guild_shops` VALUES (60431,12457,3272,5079,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,12458,8972,13927,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,13111,20061,29942,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,12584,833,1294,20,10,20);
INSERT INTO `guild_shops` VALUES (60431,12585,4931,7654,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,12586,13266,14850,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,12712,458,712,20,10,20);
INSERT INTO `guild_shops` VALUES (60431,12713,2713,4212,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,12714,2713,8316,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,12840,666,1034,20,10,20);
INSERT INTO `guild_shops` VALUES (60431,12841,2713,6133,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,12842,10805,12096,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,12968,424,660,20,10,20);
INSERT INTO `guild_shops` VALUES (60431,12969,2528,3924,20,7,15);
INSERT INTO `guild_shops` VALUES (60431,12970,11071,12393,20,5,10);
INSERT INTO `guild_shops` VALUES (60431,704,96,149,375,75,150);
INSERT INTO `guild_shops` VALUES (60431,915,2700,16120,165,33,165);
INSERT INTO `guild_shops` VALUES (60431,1134,810,2095,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,1155,436,645,165,33,165);
INSERT INTO `guild_shops` VALUES (60431,657,4690,21000,165,33,65);
INSERT INTO `guild_shops` VALUES (60431,1415,55147,55147,165,33,65);
INSERT INTO `guild_shops` VALUES (60431,1161,66,174,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,1164,30,120,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,1167,58,107,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,1170,58,107,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,1173,56,174,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,1176,44,174,2970,594,1188);
INSERT INTO `guild_shops` VALUES (60431,1472,369,369,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,1554,431,512,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,1555,1061,1259,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,1590,536,700,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,1475,579,1188,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,5164,1945,2854,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,1652,233,250,255,48,100);
INSERT INTO `guild_shops` VALUES (60431,5235,1284,1350,255,48,100);

-- Ilita (Port Bastok) / Paunelie (Southern San dOria) / Khel Pahlhama (Port Windurst) (Linkshells pseudo guild shop)
INSERT INTO `guild_shops` VALUES (60432,512,6000,6000,25,10,25);    -- New Linkshell
INSERT INTO `guild_shops` VALUES (60432,16285,375,375,255,255,255); -- Pendant Compass

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
