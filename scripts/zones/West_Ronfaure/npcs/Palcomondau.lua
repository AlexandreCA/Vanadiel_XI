-----------------------------------
-- Area: West Ronfaure
--  NPC: Palcomondau
-- Type: Patrol
-- !pos -349.796 -45.345 344.733 100
-----------------------------------
local ID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -373.096863, y = -45.742077, z = 340.182159 },
    { x = -361.441864, y = -46.052444, z = 340.367371 },
    { x = -360.358276, y = -46.063702, z = 340.457428 },
    { x = -359.297211, y = -46.093231, z = 340.693817 },
    { x = -358.264465, y = -46.285988, z = 341.032928 },
    { x = -357.301941, y = -45.966343, z = 341.412994 },
    { x = -356.365295, y = -45.641331, z = 341.804657 },
    { x = -353.933533, y = -45.161453, z = 342.873901 },
    { x = -346.744659, y = -45.006634, z = 346.113251 },
    { x = -345.843506, y = -44.973419, z = 346.716309 },
    { x = -345.138519, y = -44.939915, z = 347.540436 },
    { x = -344.564056, y = -44.925575, z = 348.463470 },
    { x = -344.069366, y = -44.945713, z = 349.431824 },
    { x = -343.621704, y = -45.004826, z = 350.421936 },
    { x = -343.194946, y = -45.062874, z = 351.421173 },
    { x = -342.118958, y = -45.391632, z = 354.047485 },
    { x = -334.448578, y = -44.964996, z = 373.198242 },
    { x = -333.936615, y = -45.028484, z = 374.152283 },
    { x = -333.189636, y = -45.068111, z = 374.939209 },
    { x = -332.252838, y = -45.073158, z = 375.488129 },
    { x = -331.241516, y = -45.065205, z = 375.888031 },
    { x = -330.207855, y = -45.043056, z = 376.226532 },
    { x = -329.165100, y = -45.022049, z = 376.536011 },
    { x = -328.118622, y = -45.000935, z = 376.832428 },
    { x = -323.437805, y = -45.726982, z = 378.101166 },
    { x = -305.333038, y = -49.030193, z = 382.936646 },
    { x = -304.308228, y = -49.435581, z = 383.130188 },
    { x = -303.259979, y = -49.765697, z = 383.194305 },
    { x = -302.209290, y = -50.104950, z = 383.175659 },
    { x = -301.161774, y = -50.446033, z = 383.117767 },
    { x = -300.114624, y = -50.787590, z = 383.041473 },
    { x = -298.422943, y = -51.390713, z = 382.898590 },
    { x = -281.798126, y = -56.178822, z = 381.370544 },
    { x = -280.718414, y = -56.161697, z = 381.241425 },
    { x = -279.641785, y = -56.142433, z = 381.087341 },
    { x = -278.567627, y = -56.121262, z = 380.917938 },
    { x = -261.485809, y = -55.875919, z = 378.010284 },
    { x = -260.404205, y = -55.893314, z = 377.898254 },
    { x = -259.317078, y = -55.908813, z = 377.861389 },
    { x = -258.229248, y = -55.923473, z = 377.879669 },
    { x = -257.142151, y = -55.938625, z = 377.919037 },
    { x = -254.834976, y = -55.888081, z = 378.032623 },
    { x = -224.857941, y = -56.603645, z = 379.721832 },
    { x = -194.892044, y = -59.911034, z = 381.416382 },
    { x = -178.437729, y = -61.500011, z = 382.347656, wait = 8000 }, -- report?
    { x = -179.524124, y = -61.500011, z = 382.285919 },
    { x = -209.530518, y = -58.837189, z = 380.588806 },
    { x = -239.543137, y = -56.145073, z = 378.891602 },
    { x = -257.769012, y = -55.930656, z = 377.861328 },
    { x = -258.856445, y = -55.915405, z = 377.839905 },
    { x = -259.943420, y = -55.900009, z = 377.884918 },
    { x = -261.025116, y = -55.882565, z = 377.999329 },
    { x = -262.102173, y = -55.864536, z = 378.151794 },
    { x = -263.193237, y = -55.845242, z = 378.320587 },
    { x = -279.088043, y = -56.134182, z = 381.021332 },
    { x = -280.165344, y = -56.153133, z = 381.172882 },
    { x = -281.246033, y = -56.168983, z = 381.299683 },
    { x = -282.302917, y = -56.181866, z = 381.408691 },
    { x = -301.977173, y = -50.175457, z = 383.230652 },
    { x = -302.993134, y = -49.847698, z = 383.246735 },
    { x = -303.998260, y = -49.580284, z = 383.147003 },
    { x = -305.083649, y = -49.109840, z = 382.933411 },
    { x = -306.061432, y = -48.755005, z = 382.706818 },
    { x = -307.152679, y = -48.355675, z = 382.435608 },
    { x = -327.497711, y = -45.027401, z = 377.016663 },
    { x = -328.548553, y = -45.009663, z = 376.735291 },
    { x = -331.569672, y = -45.071396, z = 375.927429 },
    { x = -332.566711, y = -45.084835, z = 375.500153 },
    { x = -333.347351, y = -45.055779, z = 374.749634 },
    { x = -333.952423, y = -44.990082, z = 373.848999 },
    { x = -334.454071, y = -44.958176, z = 372.884399 },
    { x = -334.909607, y = -44.930862, z = 371.896698 },
    { x = -335.338989, y = -44.939476, z = 370.897034 },
    { x = -336.319305, y = -45.033978, z = 368.508484 },
    { x = -344.092773, y = -44.934128, z = 349.103394 },
    { x = -344.599304, y = -44.920494, z = 348.142578 },
    { x = -345.289124, y = -44.948330, z = 347.305328 },
    { x = -346.152740, y = -44.981884, z = 346.646881 },
    { x = -347.087494, y = -45.014847, z = 346.091278 },
    { x = -348.052368, y = -45.047348, z = 345.589172 },
    { x = -349.030975, y = -45.039383, z = 345.114044 },
    { x = -350.016052, y = -45.036438, z = 344.652252 },
    { x = -357.274414, y = -45.947830, z = 341.359833 },
    { x = -358.277222, y = -46.126381, z = 340.958984 },
    { x = -359.326965, y = -46.091412, z = 340.679291 },
    { x = -360.404205, y = -46.072746, z = 340.529785 },
    { x = -361.488525, y = -46.061684, z = 340.441284 },
    { x = -362.575226, y = -46.055046, z = 340.388184 },
    { x = -363.662323, y = -46.050694, z = 340.353088 },
    { x = -367.288086, y = -45.562141, z = 340.276978 },
    { x = -397.408386, y = -46.031933, z = 339.796722 },
    { x = -427.522491, y = -45.366581, z = 339.319641 },
    { x = -457.651947, y = -45.910805, z = 338.841827 },
    { x = -463.498932, y = -45.831551, z = 338.757111 },
    { x = -464.580750, y = -45.752060, z = 338.776215 },
    { x = -465.656433, y = -45.603558, z = 338.822693 },
    { x = -467.953491, y = -45.463387, z = 338.967407 },
    { x = -494.403381, y = -45.661190, z = 340.958710 },
    { x = -495.442017, y = -45.667831, z = 341.254303 },
    { x = -496.256042, y = -45.713417, z = 341.966400 },
    { x = -496.865723, y = -45.720673, z = 342.866852 },
    { x = -497.385132, y = -45.755371, z = 343.821838 },
    { x = -498.376312, y = -45.856812, z = 345.908539 },
    { x = -498.820007, y = -45.996841, z = 346.899353 },
    { x = -499.174530, y = -46.197227, z = 347.923767 },
    { x = -499.352539, y = -46.093906, z = 348.989563 },
    { x = -499.416016, y = -46.074814, z = 350.073944 },
    { x = -499.423279, y = -46.070366, z = 351.161072 },
    { x = -499.397400, y = -46.084679, z = 352.248505 },
    { x = -499.358795, y = -46.133957, z = 353.335815 },
    { x = -498.771545, y = -46.025249, z = 365.000885 },
    { x = -498.687347, y = -45.804886, z = 366.615082 },
    { x = -498.166779, y = -45.846115, z = 376.640106 },
    { x = -498.109924, y = -45.862961, z = 377.726410 },
    { x = -497.697968, y = -45.951462, z = 385.738007 },
    { x = -497.694122, y = -46.004673, z = 386.825317 },
    { x = -497.737915, y = -46.056293, z = 387.912231 },
    { x = -497.809082, y = -46.020039, z = 388.997162 },
    { x = -498.192322, y = -46.074364, z = 393.595886 },
    { x = -499.513733, y = -47.018887, z = 408.449036 },
    { x = -499.682556, y = -47.223618, z = 409.509949 },
    { x = -499.959503, y = -47.415245, z = 410.549194 },
    { x = -500.307434, y = -47.595810, z = 411.566589 },
    { x = -500.686859, y = -48.017868, z = 412.545349 },
    { x = -501.077026, y = -48.478256, z = 413.506836 },
    { x = -501.873901, y = -49.394321, z = 415.425659 },
    { x = -502.207245, y = -49.737534, z = 416.425812 },
    { x = -502.382660, y = -50.058594, z = 417.464630 },
    { x = -502.406891, y = -50.394829, z = 418.516327 },
    { x = -502.342438, y = -50.724243, z = 419.565948 },
    { x = -502.251190, y = -51.088074, z = 420.607056 },
    { x = -502.139435, y = -51.460213, z = 421.645935 },
    { x = -501.954468, y = -52.022106, z = 423.198792 },
    { x = -500.171021, y = -55.784023, z = 437.153931 },
    { x = -500.033447, y = -56.010731, z = 438.356873 },
    { x = -499.879120, y = -56.021641, z = 439.981689 },
    { x = -499.679840, y = -55.963177, z = 442.392639 },
    { x = -499.790558, y = -55.536102, z = 443.497894 },
    { x = -500.205383, y = -55.237358, z = 444.453308 },
    { x = -500.785736, y = -55.148598, z = 445.369598 },
    { x = -501.427277, y = -55.099243, z = 446.246521 },
    { x = -502.103760, y = -55.051254, z = 447.097015 },
    { x = -502.791046, y = -55.003696, z = 447.939423 },
    { x = -503.574524, y = -55.015862, z = 448.879730 },
    { x = -510.872284, y = -55.089428, z = 457.484222 },
    { x = -511.691742, y = -55.159729, z = 458.188812 },
    { x = -512.678040, y = -55.280975, z = 458.628448 },
    { x = -513.720825, y = -55.419674, z = 458.910309 },
    { x = -514.785461, y = -55.554832, z = 459.097260 },
    { x = -515.851929, y = -55.741619, z = 459.240265 },
    { x = -516.923096, y = -55.906597, z = 459.366913 },
    { x = -517.998413, y = -56.087105, z = 459.482513 },
    { x = -521.921387, y = -56.035919, z = 459.879913 },
    { x = -522.965271, y = -55.886223, z = 460.131927 },
    { x = -523.947327, y = -55.785652, z = 460.568665 },
    { x = -524.886719, y = -55.581245, z = 461.082581 },
    { x = -525.805237, y = -55.438984, z = 461.645203 },
    { x = -526.824829, y = -55.279068, z = 462.300720 },
    { x = -531.560181, y = -54.945484, z = 465.464722 },
    { x = -532.406555, y = -54.961479, z = 466.143524 },
    { x = -533.060120, y = -54.995003, z = 467.010559 },
    { x = -533.618408, y = -55.030079, z = 467.943695 },
    { x = -534.158691, y = -55.026203, z = 468.887848 },
    { x = -538.343323, y = -55.609158, z = 476.336639 },
    { x = -538.852539, y = -55.920918, z = 477.273773 },
    { x = -539.335510, y = -56.089600, z = 478.277985 },
    { x = -539.767029, y = -56.035652, z = 479.274902 },
    { x = -540.283997, y = -56.042004, z = 480.532135 },
    { x = -544.975769, y = -55.047729, z = 492.510040 },
    { x = -545.471375, y = -55.034317, z = 493.475891 },
    { x = -546.206604, y = -55.009632, z = 494.270599 },
    { x = -547.121643, y = -54.949020, z = 494.853882 },
    { x = -548.100342, y = -54.921333, z = 495.329163 },
    { x = -549.105103, y = -54.930302, z = 495.747131 },
    { x = -550.121033, y = -54.979893, z = 496.133270 },
    { x = -551.140991, y = -55.035213, z = 496.507385 },
    { x = -556.089600, y = -55.924522, z = 498.256134 },
    { x = -557.125793, y = -56.028824, z = 498.568329 },
    { x = -558.182983, y = -56.208153, z = 498.806641 },
    { x = -559.256592, y = -56.133862, z = 498.981354 },
    { x = -560.335327, y = -56.116646, z = 499.118896 },
    { x = -562.091736, y = -56.104050, z = 499.314911 },
    { x = -574.530396, y = -56.559124, z = 500.553680 },
    { x = -575.606262, y = -56.603722, z = 500.706024 },
    { x = -576.649963, y = -56.813107, z = 500.963989 },
    { x = -577.670288, y = -57.037365, z = 501.291138 },
    { x = -578.679321, y = -57.266209, z = 501.647278 },
    { x = -579.683105, y = -57.510010, z = 502.019379 },
    { x = -581.321777, y = -57.800549, z = 502.643463 },
    { x = -608.199463, y = -60.061394, z = 513.086548 }, -- turn around
    { x = -607.195618, y = -59.956524, z = 512.696411 },
    { x = -579.141602, y = -57.367210, z = 501.788940 },
    { x = -578.157959, y = -57.136345, z = 501.407318 },
    { x = -577.150146, y = -56.915344, z = 501.086304 },
    { x = -576.116089, y = -56.711021, z = 500.848358 },
    { x = -575.049622, y = -56.572414, z = 500.676178 },
    { x = -573.971497, y = -56.540531, z = 500.535004 },
    { x = -572.891418, y = -56.511803, z = 500.410767 },
    { x = -571.541260, y = -56.454227, z = 500.267334 },
    { x = -559.917480, y = -56.117676, z = 499.110870 },
    { x = -558.841248, y = -56.137356, z = 498.953400 },
    { x = -557.782593, y = -56.166878, z = 498.714447 },
    { x = -556.750061, y = -55.982758, z = 498.415985 },
    { x = -555.608704, y = -55.807209, z = 498.053894 },
    { x = -553.104614, y = -55.239231, z = 497.204651 },
    { x = -547.725464, y = -54.925472, z = 495.326019 },
    { x = -546.765625, y = -54.984024, z = 494.821899 },
    { x = -546.022339, y = -55.011047, z = 494.032928 },
    { x = -545.445923, y = -55.024132, z = 493.110931 },
    { x = -544.951660, y = -55.061985, z = 492.142212 },
    { x = -544.503357, y = -55.055382, z = 491.151031 },
    { x = -544.083557, y = -55.041119, z = 490.147827 },
    { x = -543.675354, y = -55.021049, z = 489.139801 },
    { x = -540.065735, y = -56.014805, z = 479.933258 },
    { x = -539.634155, y = -56.052246, z = 478.935516 },
    { x = -539.166565, y = -56.161896, z = 477.960266 },
    { x = -538.697327, y = -55.847233, z = 477.044403 },
    { x = -538.208557, y = -55.557598, z = 476.136658 },
    { x = -537.436646, y = -55.298710, z = 474.733032 },
    { x = -533.392761, y = -55.013466, z = 467.513885 },
    { x = -532.726868, y = -54.979912, z = 466.657013 },
    { x = -531.930054, y = -54.948929, z = 465.917389 },
    { x = -531.075134, y = -54.949390, z = 465.244354 },
    { x = -530.197693, y = -54.950920, z = 464.600464 },
    { x = -529.308838, y = -54.990524, z = 463.974792 },
    { x = -525.172791, y = -55.543240, z = 461.159485 },
    { x = -524.214478, y = -55.720425, z = 460.668243 },
    { x = -523.196838, y = -55.850220, z = 460.304413 },
    { x = -522.141357, y = -56.015007, z = 460.066986 },
    { x = -521.068726, y = -56.020702, z = 459.886475 },
    { x = -519.991577, y = -56.039570, z = 459.735687 },
    { x = -518.911011, y = -56.055336, z = 459.609558 },
    { x = -517.433777, y = -55.982838, z = 459.449738 },
    { x = -513.966614, y = -55.460213, z = 459.099396 },
    { x = -512.921997, y = -55.323360, z = 458.849701 },
    { x = -512.001587, y = -55.181244, z = 458.291351 },
    { x = -511.179230, y = -55.105251, z = 457.583893 },
    { x = -510.412476, y = -55.032543, z = 456.816132 },
    { x = -509.680267, y = -54.958725, z = 456.014191 },
    { x = -508.602783, y = -54.942749, z = 454.788452 },
    { x = -500.669189, y = -55.143158, z = 445.473999 },
    { x = -500.128296, y = -55.247131, z = 444.541412 },
    { x = -499.898651, y = -55.518276, z = 443.507935 },
    { x = -499.821869, y = -55.910942, z = 442.468292 },
    { x = -499.832764, y = -56.027439, z = 441.384308 },
    { x = -499.881256, y = -56.021374, z = 440.297485 },
    { x = -499.962463, y = -56.011227, z = 439.212982 },
    { x = -500.072205, y = -56.031265, z = 438.133789 },
    { x = -500.329163, y = -55.395157, z = 435.970062 },
    { x = -502.441742, y = -50.690495, z = 419.476440 },
    { x = -502.485474, y = -50.371307, z = 418.460999 },
    { x = -502.368835, y = -50.054039, z = 417.447144 },
    { x = -502.131531, y = -49.750740, z = 416.450317 },
    { x = -501.775696, y = -49.393009, z = 415.406342 },
    { x = -501.394318, y = -48.913757, z = 414.410278 },
    { x = -500.999023, y = -48.445408, z = 413.431396 },
    { x = -500.303253, y = -47.637516, z = 411.756561 },
    { x = -499.980103, y = -47.454823, z = 410.747284 },
    { x = -499.763947, y = -47.256901, z = 409.705627 },
    { x = -499.603699, y = -47.051754, z = 408.654358 },
    { x = -499.474274, y = -46.886150, z = 407.591583 },
    { x = -499.360931, y = -46.714558, z = 406.528320 },
    { x = -497.842590, y = -45.999271, z = 389.667542 },
    { x = -497.735077, y = -46.047218, z = 388.312012 },
    { x = -497.702972, y = -46.022728, z = 387.226166 },
    { x = -497.717407, y = -45.968018, z = 386.140686 },
    { x = -497.752014, y = -45.910450, z = 385.054596 },
    { x = -498.532532, y = -45.704178, z = 369.587616 },
    { x = -498.589294, y = -45.753151, z = 368.501129 },
    { x = -499.547089, y = -46.040310, z = 350.040375 },
    { x = -499.412354, y = -46.078503, z = 348.964417 },
    { x = -499.099609, y = -46.221172, z = 347.926239 },
    { x = -498.741913, y = -46.030338, z = 346.926208 },
    { x = -498.351959, y = -45.860306, z = 345.923828 },
    { x = -497.941467, y = -45.805256, z = 344.918884 },
    { x = -497.518524, y = -45.751751, z = 343.918427 },
    { x = -497.074768, y = -45.707314, z = 342.926636 },
    { x = -496.434631, y = -45.690395, z = 342.056549 },
    { x = -495.518555, y = -45.685642, z = 341.481903 },
    { x = -494.478638, y = -45.677624, z = 341.169525 },
    { x = -493.406281, y = -45.681431, z = 340.990509 },
    { x = -492.333801, y = -46.148170, z = 340.858154 },
    { x = -491.272858, y = -45.972626, z = 340.751801 },
    { x = -490.196564, y = -45.903652, z = 340.655212 },
    { x = -466.653748, y = -45.466057, z = 338.859863 },
    { x = -465.575256, y = -45.615093, z = 338.803314 },
    { x = -464.496521, y = -45.763508, z = 338.779785 },
    { x = -463.410126, y = -45.832458, z = 338.774506 },
    { x = -433.375122, y = -45.735828, z = 339.226624 },
    { x = -403.243805, y = -46.015915, z = 339.704468 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onPath = function(npc)
    if
        npc:getLocalVar('reported') ~= 1 and
        npc:atPoint(xi.path.get(pathNodes, 45))
    then
        GetNPCByID(npc:getID() + 3):showText(npc, ID.text.PALCOMONDAU_REPORT)
        npc:setLocalVar('reported', 1)
    elseif npc:atPoint(xi.path.last(pathNodes)) then
        npc:setLocalVar('reported', 0)
    end
end

return entity
