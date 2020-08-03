-----------------------------------
-- A collection of frequently needed teleport shortcuts.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/zone")

tpz = tpz or {}
tpz.teleport = tpz.teleport or {}

-----------------------------------
-- TELEPORT IDS
-----------------------------------
local ids =
{
    DEM                 = 1,
    HOLLA               = 2,
    YHOAT               = 3,
    VAHZL               = 4,
    MEA                 = 5,
    ALTEP               = 6,
    WARP                = 7,
    ESCAPE              = 8,
    JUGNER              = 9,
    PASHH               = 10,
    MERIPH              = 11,
    AZOUPH              = 12,
    BHAFLAU             = 13,
    ZHAYOLM             = 14,
    DVUCCA              = 15,
    REEF                = 16,
    ALZADAAL            = 17,
    CUTTER              = 18,
    Z_REM               = 19,
    A_REM               = 20,
    B_REM               = 21,
    S_REM               = 22,
    MAAT                = 23,
    OUTPOST             = 24,
    LEADER              = 25,
    EXITPROMMEA         = 26,
    EXITPROMHOLLA       = 27,
    EXITPROMDEM         = 28,
    LUFAISE             = 29,
    CHOCO_WINDURST      = 30,
    CHOCO_SANDORIA      = 31,
    CHOCO_BASTOK        = 32,
    DUCALGUARD          = 33,
    PURGONORGO          = 34,
    AZOUPH_SP           = 35,
    DVUCCA_SP           = 36,
    MAMOOL_SP           = 37,
    HALVUNG_SP          = 38,
    ILRUSI_SP           = 39,
    NYZUL_SP            = 40,
    SKY                 = 41,
    CLOISTER_OF_FLAMES  = 42,
    CLOISTER_OF_FROST   = 43,
    CLOISTER_OF_GALES   = 44,
    CLOISTER_OF_STORMS  = 45,
    CLOISTER_OF_TIDES   = 46,
    CLOISTER_OF_TREMORS = 47,
    GHELSBA_HUT         = 48,
    WAJAOM_LEYPOINT     = 49,
    VALKURM_VORTEX      = 50,
    QUFIM_VORTEX        = 51,
    LUFAISE_VORTEX      = 52,
    MISAREAUX_VORTEX    = 53,
    MINESHAFT           = 54,
    WHITEGATE           = 55,
    SEA                 = 56,
    HOME_NATION         = 57,
    CHOCO_UPPER_JEUNO   = 58,
    ZVAHL_KEEP          = 59
}
tpz.teleport.id = ids

-----------------------------------
-- TELEPORT TO SINGLE DESTINATION
-----------------------------------

local destinations =
{
    [ids.DEM]                   = { 220.000,   19.104,  300.000,   0, 108}, -- {R}
    [ids.HOLLA]                 = { 420.000,   19.104,   20.000,   0, 102}, -- {R}
    [ids.YHOAT]                 = {-280.942,    0.596, -144.156,   0, 124}, -- {R}
    [ids.VAHZL]                 = { 150.258,  -21.048,  -37.256,  94, 112}, -- {R}
    [ids.MEA]                   = { 100.000,   35.151,  340.000,   0, 117}, -- {R}
    [ids.ALTEP]                 = { -61.942,    3.949,  224.900,   0, 114}, -- {R}
    [ids.JUGNER]                = {-122.862,    0.000, -163.154, 192,  82}, -- {R}
    [ids.PASHH]                 = { 345.472,   24.280, -114.731,  99,  90}, -- {R}
    [ids.MERIPH]                = { 305.989,  -14.978,   18.960, 192,  97}, -- {R}
    [ids.AZOUPH]                = { 495.450,  -28.250, -478.430,  32,  79}, -- {R}
    [ids.BHAFLAU]               = {-172.863,  -12.250, -801.021, 128,  52}, -- {R}
    [ids.ZHAYOLM]               = { 681.950,  -24.000,  369.936,  64,  61}, -- {R}
    [ids.DVUCCA]                = {-252.715,   -7.666,  -30.640, 128,  79}, -- {R}
    [ids.REEF]                  = {   9.304,   -7.376,  620.133,   0,  54}, -- {R}
    [ids.ALZADAAL]              = { 180.000,    0.000,   20.000,   0,  72}, -- {R}
    [ids.CUTTER]                = {-456.000,   -3.000, -405.000, -405,  54},
    [ids.A_REM]                 = {-579.000,   -0.050, -100.000, 192,  72},
    [ids.B_REM]                 = { 620.000,    0.000, -260.640,  72,  72}, -- {R}
    [ids.S_REM]                 = { 580.000,    0.000,  500.000, 192,  72}, -- {R}
--  [ids.Z_REM]                 = { 000.000,    0.000,  000.000, 000,  72},
    [ids.MAAT]                  = {  11.000,    3.000,  117.000,   0, 243},
    [ids.EXITPROMMEA]           = { 179.000,   35.000,  256.000,  63, 117},
    [ids.EXITPROMHOLLA]         = { 337.000,   19.000,  -60.000, 125, 102},
    [ids.EXITPROMDEM]           = { 136.000,   19.000,  220.000, 130, 108},
    [ids.LUFAISE]               = { 438.000,    0.000,  -18.000,  11,  24},
    [ids.CHOCO_SANDORIA]        = {  -8.557,    1.999,  -80.093,  64, 230}, -- {R}
    [ids.CHOCO_BASTOK]          = {  40.164,    0.000,  -83.578,  64, 234}, -- {R}
    [ids.CHOCO_WINDURST]        = { 113.355,   -5.000, -133.118,   0, 241}, -- {R}
    [ids.CHOCO_UPPER_JEUNO]     = { -44.000,    7.900,   98.000, 170, 244},
    [ids.DUCALGUARD]            = {  48.930,   10.002,  -71.032, 195, 243},
    [ids.PURGONORGO]            = {-398.689,   -3.038, -415.835,   0,   4}, -- {R}
    [ids.AZOUPH_SP]             = { 522.730,  -28.009, -502.621, 161,  79}, -- {R}
    [ids.DVUCCA_SP]             = {-265.632,   -6.000,  -29.472,  94,  79}, -- {R}
    [ids.MAMOOL_SP]             = {-210.291,  -11.500, -818.056, 255,  52}, -- {R}
    [ids.HALVUNG_SP]            = { 688.994,  -23.960,  351.496, 191,  61}, -- {R}
    [ids.ILRUSI_SP]             = {  17.540,   -7.250,  627.968, 254,  54}, -- {R}
    [ids.NYZUL_SP]              = { 222.798,   -0.500,   19.872,   0,  72}, -- {R}
    [ids.SKY]                   = {-134.145,  -32.328, -205.947, 215, 130}, -- {R}
    [ids.CLOISTER_OF_FLAMES]    = {-716.461,    0.407, -606.661, 168, 207}, -- {R}
    [ids.CLOISTER_OF_FROST]     = { 550.403,    0.006,  584.820, 217, 203}, -- {R}
    [ids.CLOISTER_OF_GALES]     = {-374.919,    0.628, -386.774, 226, 201}, -- {R}
    [ids.CLOISTER_OF_STORMS]    = { 540.853,  -13.329,  511.298,  82, 202}, -- {R}
    [ids.CLOISTER_OF_TIDES]     = { 570.294,   36.757,  546.895, 167, 211}, -- {R}
    [ids.CLOISTER_OF_TREMORS]   = {-540.269,    1.396, -509.800, 192, 209}, -- {R}
    [ids.GHELSBA_HUT]           = {-156.000,  -10.000,   80.000, 119, 140},
    [ids.WAJAOM_LEYPOINT]       = {-200.116,  -10.000,   79.879, 213,  51}, -- {R}
    [ids.VALKURM_VORTEX]        = { 420.062,    0.000, -199.904,  87, 103}, -- {R}
    [ids.QUFIM_VORTEX]          = {-436.000,  -13.499,  340.117, 107, 126}, -- {R}
    [ids.LUFAISE_VORTEX]        = { 458.847,    7.999,    5.519,  72,  24}, -- {R}
    [ids.MISAREAUX_VORTEX]      = {-118.000,  -32.000,  219.000,   3,  25}, -- {R}
    [ids.MINESHAFT]             = { -93.657, -120.000, -583.561,   0,  13}, -- (R)
    [ids.WHITEGATE]             = {  27.424,   -6.000, -123.792, 192,  50}, -- {R}
    [ids.SEA]                   = { -31.800,    0.000, -618.700, 190,  33}, -- {R}
    [ids.ZVAHL_KEEP]            = {-555.996,  -70.100,   59.989,   0, 162}
}

tpz.teleport.type =
{
    OUTPOST_SANDORIA   = 0,
    OUTPOST_BASTOK     = 1,
    OUTPOST_WINDURST   = 2,
    RUNIC_PORTAL       = 3,
    PAST_MAW           = 4,
    ABBYSEA_MAW        = 5,
    CAMPAIGN_SANDORIA  = 6,
    CAMPAIGN_BASTOK    = 7,
    CAMPAIGN_WINDURST  = 8,
    HOMEPOINT          = 9,
    SURVIVAL           = 10
}

tpz.teleport.runic_portal =
{
    AZOUPH  = 1,
    DVUCCA  = 2,
    MAMOOL  = 3,
    HALVUNG = 4,
    ILRUSI  = 5,
    NYZUL   = 6,
}

tpz.teleport.to = function(player, destination)
    local dest = destinations[destination]
    if dest then
        player:setPos(unpack(dest))
    end
end

-----------------------------------
-- TELEPORT TO PARTY LEADER
-----------------------------------

tpz.teleport.toLeader = function(player)
    local leader = player:getPartyLeader()
    if leader ~= nil and not leader:isInMogHouse() then
        player:gotoPlayer(leader:getName())
    end
end

-----------------------------------
-- TELEPORT TO CAMPAIGN DESTINATION
-----------------------------------

local campaignDestinations =
{
    [ 1] = { 205.973, -23.587, -206.606, 167, 137}, -- {R} {R} Xarcabard [S]
    [ 2] = { -46.172, -60.109,  -38.487,  16, 136}, -- {R} Beaucedine Glacier [S]
    [ 3] = { 306.939,  -1.000, -141.567, 173,  84}, -- {R} Batallia Downs [S]
    [ 4] = {  -4.701,  15.982,  235.996, 160,  91}, -- {R} Rolanberry Fields [S]
    [ 5] = { -64.212,   7.625,  -51.292, 192,  98}, -- {R} Sauromugue Champaign [S]
    [ 6] = {  60.617,  -3.949,   56.658,  64,  82}, -- {R} Jugner Forest [S]
    [ 7] = { 504.088,  24.511,  628.360,  69,  90}, -- {R} Pashhow Marshlands [S]
    [ 8] = {-447.084,  23.433,  586.847,  31,  97}, -- {R} Meriphataud Mountains [S]
    [ 9] = { -77.817, -47.234, -302.732, 135,  83}, -- {R} Vunkerl Inlet [S]
    [10] = { 314.335, -36.368,  -12.200, 192,  89}, -- {R} Grauberg [S]
    [11] = { 141.021, -45.000,   19.543,   0,  96}, -- {R} Fort Karugo-Narugo [S]
    [12] = { 183.297, -19.971, -240.895,   2,  81}, -- {R} East Ronfaure [S]
    [13] = {-441.332,  40.000,  -77.986, 164,  88}, -- {R} North Gustaberg [S]
    [14] = {-104.707, -21.838,  258.043, 237,  95}, -- {R} West Sarutabaruta [S]
    [15] = { -98.000,   1.000,  -41.000, 224,  80}, --     Southern San d'Oria [S]
    [16] = {-291.000, -10.000, -107.000, 212,  87}, --     Bastok Markets [S]
    [17] = { -31.442,  -5.000,  129.202, 128,  94}, -- {R} Windurst Waters [S}
    [18] = {-194.095,   0.000,   30.009,   0, 164}, -- {R} Garlaige Citdadel [S]
    [19] = {  59.213, -32.158,  -38.022,  64, 171}, -- {R} Crawlers' Nest [S]
    [20] = { 294.350, -27.500,   19.947,   0, 175}, -- {R} The Eldieme Necropolis [S]
}

tpz.teleport.toCampaign = function(player, option)
    local dest = campaignDestinations[option]
    if dest then
        player:setPos(unpack(dest))
    end
end

    -- TODO: Abyessa Maws:
    -- Tahrongi Canyon (H-12)
    -- Konschtat Highlands (I-12)
    -- La Theine Plateau (E-4)
    -- Valkurm Dunes (I-9)
    -- Jugner Forest (J-8)
    -- Buburimu Peninsula (F-7)
    -- South Gustaberg (J-10)
    -- North Gustaberg (G-6)
    -- Xarcabard (H-8)

-----------------------------------
-- TELEPORT TO REGIONAL OUTPOST
-----------------------------------

local outpostDestinations =
{
    [tpz.region.RONFAURE]        = {-437.688, -20.255, -219.227, 124, 100}, -- Ronfaure {R}
    [tpz.region.ZULKHEIM]        = { 148.231,  -7.975,   93.479, 154, 103}, -- Zulkheim {R}
    [tpz.region.NORVALLEN]       = {  62.030,   0.463,   -2.025,  67, 104}, -- Norvallen {R}
    [tpz.region.GUSTABERG]       = {-580.161,  39.578,   62.680,  89, 106}, -- Gustaberg {R}
    [tpz.region.DERFLAND]        = { 465.820,  23.625,  423.164,  29, 109}, -- Derfland {R}
    [tpz.region.SARUTABARUTA]    = { -17.921, -13.335,  318.156, 254, 115}, -- Sarutabaruta {R}
    [tpz.region.KOLSHUSHU]       = {-480.237, -30.943,   58.079,  62, 118}, -- Kolshushu {R}
    [tpz.region.ARAGONEU]        = {-297.047,  16.988,  418.026, 225, 119}, -- Aragoneu {R}
    [tpz.region.FAUREGANDI]      = { -18.690, -60.048, -109.243, 100, 111}, -- Fauregandi {R}
    [tpz.region.VALDEAUNIA]      = { 211.210, -24.016, -207.338, 160, 112}, -- Valdeaunia {R}
    [tpz.region.QUFIMISLAND]     = {-243.049, -19.983,  306.712,  71, 126}, -- Qufim Island {R}
    [tpz.region.LITELOR]         = { -37.669,   0.419, -141.216,  69, 121}, -- Li'Telor {R}
    [tpz.region.KUZOTZ]          = {-249.983,   7.965, -252.976, 122, 114}, -- Kuzotz {R}
    [tpz.region.VOLLBOW]         = {-176.360,   7.624,  -63.580, 122, 113}, -- Vollbow {R}
    [tpz.region.ELSHIMOLOWLANDS] = {-240.860,  -0.031, -388.434,  64, 123}, -- Elshimo Lowlands {R}
    [tpz.region.ELSHIMOUPLANDS]  = { 207.821,  -0.128,  -86.623, 159, 124}, -- Elshimo Uplands {R}
    [tpz.region.TULIA]           = {   4.000, -54.000, -600.000, 192, 130}, -- Tu'Lia (can't acquire on retail, but exists in NCP event menu)
    [tpz.region.TAVNAZIANARCH]   = {-535.861,  -7.149,  -53.628, 122,  24}, -- Tavnazia {R}
}

tpz.teleport.toOutpost = function(player, region)
    local dest = outpostDestinations[region]
    player:setPos(unpack(dest))
end

-----------------------------------
-- TELEPORT TO HOME NATION
-----------------------------------

tpz.teleport.toHomeNation = function(player)
    local pNation = player:getNation()
    if pNation == tpz.nation.BASTOK then
        player:setPos(89, 0 , -66, 0, 234)
    elseif pNation == tpz.nation.SANDORIA then
        player:setPos(49, -1 , 29, 164, 231)
    else
        player:setPos(193, -12 , 220, 64, 240)
    end
end

-----------------------------------
-- TELEPORT TO CHAMBER OF PASSAGE
-----------------------------------

tpz.teleport.toChamberOfPassage = function(player)
    if math.random(1, 2) == 1 then
        player:setPos(133.400, 1.485, 47.427, 96, 50) -- {R} Aht Urhgan Whitegate Chamber of Passage Left
    else
        player:setPos(116.670, 1.485, 47.427, 32, 50) -- {R} Aht Urhgan Whitegate Chamber of Passage Right
    end
end

-----------------------------------
-- TELEPORT TO EXPLORER MOOGLE
-----------------------------------

tpz.teleport.toExplorerMoogle = function(player, zone)
    if zone == 231 then
        player:setPos(39.4, -0.2, 25, 253, zone)       -- Northern_San_d'Oria
    elseif zone == 234 then
        player:setPos(76.82, 0, -66.12, 232, zone)     -- Bastok_Mines
    elseif zone == 240 then
        player:setPos(185.6, -12, 223.5, 96, zone)     -- Port_Windurst
    elseif zone == 248 then
        player:setPos(14.67, -14.56, 66.69, 96, zone)  -- Selbina
    elseif zone == 249 then
        player:setPos(2.87, -4, 71.95, 0, zone)        -- Mhaura
    end
end

-----------------------------------
-- CAST ESCAPE SPELL
-----------------------------------

tpz.teleport.escape = function(player)
    local zone = player:getZoneID()

    -- Ronfaure {R}
    if zone == 139 or zone == 140 or zone == 141 or zone == 142 then         -- From Ghelsba Outpost, Fort Ghelsba, Yughott Grotto, Horlais Peak
        player:setPos(-720, -61, 600, 64, 100)                                 -- To West Ronfaure at E-4
    elseif zone == 167 then                                                 -- From Bostaunieux Oubliette
        player:setPos(-685, -30, 18, 0, 100)                                     -- To West Ronfaure at F-8
    elseif zone == 190 then                                                 -- From King Ranperre's Tomb
        player:setPos(203, -1, -521, 192, 101)                                 -- To East Ronfaure at H-11
    -- Valdeaunia {R}
    elseif zone == 162 or zone == 161 or zone == 165 then                     -- From Castle Zvahl Keep, Castle Zvahl Baileys, Throne Room
        player:setPos(-414, -44, 19, 0, 112)                                     -- To Xarcabard at G-7
    -- Norvallen {R}
    elseif zone == 195 then                                                 -- From The Eldieme Necropolis
        player:setPos(382.398, 7.314, -106.298, 160, 105)                         -- To Batallia Downs at F-8
    elseif zone == 149 or zone == 150 then                                 -- From Davoi or Monastic Cavern
        player:setPos(-232, -8, -562, 0, 104)                                     -- To Jugner Forest at G-12
    -- Fauregandi {R}
    elseif zone == 166 then                                                 -- From Ranguemont Pass
        player:setPos(803, -61, 635, 128, 101)                                 -- To East Ronfaure at K-4
    elseif zone == 9 or zone == 10 then                                    -- From Pso'Xja, The Shrouded Maw
        player:setPos(-427, -41, -422, 0, 111)                                 -- To Beaucedine Glacier at E-11
    elseif zone == 204 or zone == 206 or zone == 203 then                     -- From Fei'Yin, Qu'Bia Arena, Cloister of Frost
        player:setPos(279, 19, 536, 64, 111)                                     -- To Beaucedine Glacier at J-5
    -- Derfland {R}
    elseif zone == 197 then                                                 -- From Crawlers' Nest
        player:setPos(-356, -24, -763, 192, 110)                                 -- To Rolanberry Fields at F-13
    elseif zone == 148 or zone == 147 then                                 -- From Qulun Dome, Beadeaux
        player:setPos(557, 24, -385, 192, 109)                                 -- To Pashhow Marshlands at K-11
    -- Emptiness {R}
    elseif zone == 16 or zone == 17 then                                    -- From Promyvion-Holla, Spire of Holla
        player:setPos(332, 24, -148, 96, 102)                                     -- To La Theine Plateau at J-9
    elseif zone == 18 or zone == 19 then                                    -- From Promyvion-Dem, Spire of Dem
        player:setPos(134, 24, 134, 96, 108)                                     -- To Konschtat Highlands at I-7
    elseif zone == 20 or zone == 21 then                                    -- From Promyvion-Mea, Spire of Mea
        player:setPos(266, 40, 254, 32, 117)                                     -- To Tahrongi Canyon at J-6
    elseif zone == 22 or zone == 23 then                                    -- From Promyvion-Vahzl, Spire of Vahzl
        player:setPos(-331, -100, 128, 32, 111)                                 -- To Beaucedine Glacier at F-7
    -- Qufim Island {R}
    elseif zone == 157 or zone == 158 or zone == 184 or zone == 179 then     -- From Delkfutt's Tower: Middle, Upper, Lower, Stellar Fulcrum
        player:setPos(-267, -20, 320, 0, 126)                                     -- To Qufim Island at F-6
    -- Tu'Lia {R}
    elseif zone == 177 or zone == 178 or zone == 180 or zone == 181 then    -- From Ve'Lugannon Palace, Shrine of Ru'Avitau, LaLoff Amphitheater, The Celestial Nexus
        player:setPos(0, -35, -472, 192, 130)                                     -- To Ru'Aun Gardens at H-11
    -- Li'Telor {R}
    elseif zone == 153 or zone == 154 or zone == 202 then                     -- From The Boyahda Tree, Dragon's Aery, Cloister of Storms
        player:setPos(509.5, 1, -575, 128, 121)                                 -- To The Sanctuary of Zi'Tah at K-12
    -- Aragonau {R}
    elseif zone == 200 then                                                 -- From Garlaige Citadel
        player:setPos(-112, -24, -403, 192, 120)                                 -- To Sauromugue Champaign at H-10
    elseif zone == 152 or zone == 151 then                                 -- From Altar Room, Castle Oztroja
        player:setPos(718, -31, -63, 128, 119)                                 -- To Meriphataud Mountains at L-8
    -- Kolshushu {R}
    elseif zone == 213 then                                                 -- From Labyrinth of Onzozo
        player:setPos(447, 18, 191, 32, 118)                                     -- To Buburimu Peninsula at K-6
    elseif zone == 198 then                                                 -- From Maze of Shakhrami
        player:setPos(446, 46, 481, 128, 117)                                     -- To Tahrongi Canyon at K-5
    -- Sarutabaruta {R}
    elseif zone == 169 or zone == 192 or zone == 194 or zone == 170 then     -- From Toraimarai Canal, Inner Horutoto Ruins, Outer Horutoto Ruins, Full Moon Fountain
        player:setPos(366, -13, 92, 128, 116)                                     -- To East Sarutabaruta at J-7
    elseif zone == 145 or zone == 146 then                                 -- From Giddeus, Balgas Dais
        player:setPos(-360, -20, 78, 192, 115)                                 -- To West Sarutabaruta at F-8
    -- Elshimo Uplands {R}
    elseif zone == 159 or zone == 160 or zone == 163 or zone == 211 then     -- From Temple of Uggalepih, Den of Rancor, Sacrificial Chamber, Cloister of Tides
        player:setPos(298, -2, -445, 192, 124)                                 -- To Yhoator Jungle at J-11
    elseif zone == 205 or zone == 207 then                                                 -- From Ifrit's Cauldron, Cloister of Flames
        player:setPos(91, -1, 336, 96, 124)                                     -- To Yhoator Jungle at I-6
    -- Elshimo Lowlands {R}
    elseif zone == 176 then                                                 -- From Sea Serpent Grotto
        player:setPos(-627, 16, -427, 192, 123)                                -- To Yuhtunga Jungle at E-11
    -- Gustaberg {R}
    elseif zone == 173 then                                                 -- From Korroloka Tunnel
        player:setPos(-75, -1, 20, 0, 172)                                     -- To Zeruhn Mines at H-7
    elseif zone == 191 then                                                 -- From Dangruf Wadi
        player:setPos(-564, 38, -541, 0, 107)                                     -- To South Gustaberg at E-9
    elseif zone == 143 or zone == 144 then                                    -- From Palborough Mines, Waughroon Shrine
        player:setPos(483, -31, 1159, 128, 106)                                 -- To North Gustaberg at K-3
    -- Movalpolos {R}
    elseif zone == 13 or zone == 12 or zone == 11 then                     -- From Mine Shaft 2716, Newton Movalpolos, Oldton Movalpolos
        player:setPos(448, -4, 730, 96, 106)                                     -- To North Gustaberg at K-6
    -- Kuzotz {R}
    elseif zone == 208 or zone == 168 or zone == 209 then                     -- From Quicksand Caves, Chamber of Oracles, Cloister of Tremors
        player:setPos(454, -11, -35, 128, 114)                                 -- To Eastern Altepa Desert at J-8
    -- Vollbow {R}
    elseif zone == 174 then                                                 -- From Kuftal Tunnel
        player:setPos(-46, 6, 418, 192, 125)                                     -- To Western Altepa Desert at I-5
    elseif zone == 212 then                                                 -- From Gustav Tunnel
        player:setPos(-791, -6, 57, 192, 103)                                     -- To Valkurm Dunes at B-8
    elseif zone == 201 then                                                -- From Cloister of Gales
        player:setPos(-291, -3, 494, 32, 113)                                     -- To Cape Teriggan F-5
    -- Zulkheim {R}
    elseif zone == 196 then                                                 -- From Gusgen Mines
        player:setPos(680, 21, 204, 64, 108)                                     -- To Konschtat Highlands at L-7
    elseif zone == 193 then                                                 -- From Ordelle's Caves
        player:setPos(-261, 23, 123, 192, 102)                                 -- To La Theine Plateau at F-7
    -- Tavnazian Archipelago {R}
    elseif zone == 27 then                                                 -- From Phomiuna Aqueducts
        player:setPos(540, -16, 265, 160, 25)                                     -- To Misareaux Coast at K-7
    elseif zone == 28 then                                                 -- From Sacrarium
        player:setPos(39, -24, 743, 64, 25)                                     -- To Misareaux Coast at H-4
    elseif zone == 29 or zone == 30 or zone == 31 then                        -- From Riverne - Site B01, Riverne - Site A01, Monarch Linn
        player:setPos(-483, -31, 403, 116, 25)                                 -- To Misareaux Coast at D-6
    -- Mamool Ja Savagelands {R}
    elseif zone == 65 then                                                 -- From Mamook
        player:setPos(-459.961, -4.357, -513.191, 192, 51)                     -- To Wajaom Woodlands at E-12
    elseif zone == 66 then                                                    -- From Mamool Ja Training Grounds
        player:setPos(-172.863, -12.25, -801.021, 128, 52)                 -- Bhaflau Thickets
    elseif zone == 67 then                                                 -- From Jade Sepulcher
        player:setPos(-125.762, -12.226, -499.689, 124, 52)                     -- To Bhaflau Thickets at I-9
    elseif zone == 68 then                                                 -- From Aydeewa Subterrane
        player:setPos(95.251, -16.04, 428.910, 64, 51)                         -- To Wajaom Woodlands at I-6
    -- Halvung Territory {R}
    elseif zone == 62 then                                                 -- From Halvung
        player:setPos(860.994, -15.675, 223.567, 192, 61)                         -- To Mount Zhayolm at L-7
    elseif zone == 63 then                                                    -- From Lebros Cavern
        player:setPos(681.950, -24, 369.936, 64, 61)                        -- To Mount Zhayolm
    elseif zone == 64 then                                                 -- From Navukgo Execution Chamber
        player:setPos(-630.146, -17.643, 223.012, 0, 61)                         -- To Mount Zhayolm at C-7
    -- Arrapago Islands {R}
    elseif zone == 54 then                                                 -- From Arrapago Reef
        player:setPos(227.36, -17.276, -60.718, 95, 79)                         -- To Caedarva Mire Azouph Isle at I-6
    elseif zone == 55 then                                                 -- From Ilrusi Atoll
        player:setPos(9.304, -7.376, 620.133, 0, 54)                             -- To Arrapago Reef G-4
    elseif zone == 56 then                                                    -- From Periqia
        player:setPos(-252.715, -7.666, -30.64, 128, 79)                    -- To Caedarva Mire
    elseif zone == 57 or zone == 78 then                                     -- From Talacca Cove, Hazhalm Testing Grounds
        player:setPos(-467.077, 7.89, -538.603, 0, 79)                         -- To Caedarva Mire Azouph Isle at E-9
    elseif zone == 69 then                                                    -- From Leujaoam Sanctum
        player:setPos(495.450, -28.25, -478.430, 32, 79)                    -- To Caedarva Mire
    -- Ruins of Alzadaal {R}
    elseif zone == 72 then                                                 -- From Alzadaal Undersea Ruins
        player:setPos(14.186, -29.789, 590.427, 0, 52)                         -- To Bhaflau Thickets at F-6
    elseif zone == 75 then                                                    -- From Bhaflau Remnants I/II
        player:setPos(620, 0, -260, 64, 72)                                     -- To Alzadaal Undersea Ruins BR H-8
    elseif zone == 76 then                                                 -- From Silver Sea Remnants I/II
        player:setPos(580, 0, 500, 192, 72)                                     -- To Alzadaal Undersea Ruins SSR H-8
    elseif zone == 77 then                                                    -- From Nyzul Isle Investigation/Uncharted Region
        player:setPos(180, 0, 20, 0, 72)                                         -- To Alzadaal Undersea Ruins
    -- Lumoria {R}
    elseif zone == 34 or zone == 35 or zone == 36 then                        -- From Grand Palace of HuXzoi or The Garden of RuHmet or Empyreal Paradox
        player:setPos(-23, 0, -465, 64, 33)                                    -- To Al'Taieu (H-11)
    -- The Aragoneu Front {R}
    elseif zone == 99 then                                                 -- From Castle Oztroja (S)
        player:setPos(720.589, -31.999, -81.495, 162, 97)                         -- To Meriphataud Mountains (S) at L-8
    elseif zone == 164 then                                                 -- From Garlaige Citadel (S)
        player:setPos(-112, -24, -403, 192, 98)                                 -- To Sauromugue Champaign (S) at H-11
    -- The Derfland Front {R}
    elseif zone == 92 then                                                 -- From Beadeaux (S)
        player:setPos(548.199, 24.999, -341.959, 128, 90)                         -- To Pashhow Marshlands (S) at K-11
    elseif zone == 171 then                                                 -- From Crawlers' Nest (S)
        player:setPos(-356, -24, -763, 192, 91)                                 -- To Rolanberry Field (S) G-13
    -- The Valdeaunia Front {R}
    elseif zone == 155 or zone == 138 then                                 -- Fromn Castle Zvahl Keep (S), Castle Zvahl Baileys (S)
        player:setPos(-414, -44, 19, 0, 137)                                     -- To Xarcabard (S) at G-7
    -- The Norvallen Front {R}
    elseif zone == 85 then                                                 -- From La Vaule (S)
        player:setPos(-203.576, -7.351, -494.53, 0, 82)                         -- To Jugner Forest (S) at G-12
    elseif zone == 175 then                                                 -- From The Eldieme Necropolis (S)
        player:setPos(283.593, 7.999, -403.207, 145, 84)                         -- To Batallia Downs (S) J-10
    end

    -- TODO: Arrapago Remnants I/II, Zhaylohm Remnants I/II, Everbloom Hollow?, Ruhoyz Silvermines?, The Ashu Talif?
    -- TODO: Abyssea / SOA Areas
    -- MISC Flag in zone_settings will also need +1 or -1 depending on escape possibility.
end

-----------------------------------
-- EXPLORER MOOGLE EVENTS
-----------------------------------

tpz.teleport.explorerMoogleOnTrigger = function(player, event)
    local accept = 0

    if player:getGil() < 300 then
        accept = 1
    end

    if player:getMainLvl() < EXPLORER_MOOGLE_LV then
        event = event + 1
    end

    player:startEvent(event, player:getZoneID(), 0, accept)
end

tpz.teleport.explorerMoogleOnEventFinish = function(player, csid, option, event)
    local price = 300

    if csid == event then
        if option == 1 and player:delGil(price) then
            tpz.teleport.toExplorerMoogle(player, 231)
        elseif option == 2 and player:delGil(price) then
            tpz.teleport.toExplorerMoogle(player, 234)
        elseif option == 3 and player:delGil(price) then
            tpz.teleport.toExplorerMoogle(player, 240)
        elseif option == 4 and player:delGil(price) then
            tpz.teleport.toExplorerMoogle(player, 248)
        elseif option == 5 and player:delGil(price) then
            tpz.teleport.toExplorerMoogle(player, 249)
        end
    end
end
