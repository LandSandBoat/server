-----------------------------------
-- A collection of frequently needed teleport shortcuts.
-----------------------------------
require('scripts/globals/utils')

xi = xi or {}
xi.teleport = xi.teleport or {}

-----------------------------------
-- TELEPORT IDS
-----------------------------------
local ids =
{
    DEM                   = 1,
    HOLLA                 = 2,
    YHOAT                 = 3,
    VAHZL                 = 4,
    MEA                   = 5,
    ALTEP                 = 6,
    WARP                  = 7,
    ESCAPE                = 8,
    JUGNER                = 9,
    PASHH                 = 10,
    MERIPH                = 11,
    AZOUPH                = 12,
    BHAFLAU               = 13,
    ZHAYOLM               = 14,
    DVUCCA                = 15,
    REEF                  = 16,
    ALZADAAL              = 17,
    CUTTER                = 18,
    Z_REM                 = 19,
    A_REM                 = 20,
    B_REM                 = 21,
    S_REM                 = 22,
    MAAT                  = 23,
    OUTPOST               = 24,
    LEADER                = 25,
    EXITPROMHOLLA         = 26,
    EXITPROMDEM           = 27,
    EXITPROMMEA           = 28,
    LUFAISE               = 29,
    CHOCO_WINDURST        = 30,
    CHOCO_SANDORIA        = 31,
    CHOCO_BASTOK          = 32,
    DUCALGUARD            = 33,
    PURGONORGO            = 34,
    AZOUPH_SP             = 35,
    MAMOOL_SP             = 36,
    HALVUNG_SP            = 37,
    DVUCCA_SP             = 38,
    ILRUSI_SP             = 39,
    NYZUL_SP              = 40,
    SKY                   = 41,
    CLOISTER_OF_FLAMES    = 42,
    CLOISTER_OF_FROST     = 43,
    CLOISTER_OF_GALES     = 44,
    CLOISTER_OF_STORMS    = 45,
    CLOISTER_OF_TIDES     = 46,
    CLOISTER_OF_TREMORS   = 47,
    GHELSBA_HUT           = 48,
    WAJAOM_LEYPOINT       = 49,
    VALKURM_VORTEX        = 50,
    QUFIM_VORTEX          = 51,
    LUFAISE_VORTEX        = 52,
    MISAREAUX_VORTEX      = 53,
    MINESHAFT             = 54,
    WHITEGATE             = 55,
    SEA                   = 56,
    HOME_NATION           = 57,
    CHOCO_UPPER_JEUNO     = 58,
    ZVAHL_KEEP            = 59,
    RETRACE               = 60,
    SOUTHERN_SAN_DORIA_S  = 61,
    BASTOK_MARKETS_S      = 62,
    WINDURST_WATERS_S     = 63,
    ESCHA_ZITAH           = 64,
    QUFIM_CONFLUENCE      = 65,
    ESCHA_RUAUN           = 66,
    MISAREAUX_CONFLUENCE  = 67,
    CAMPAIGN              = 68,
    TIDAL_TALISMAN        = 69,
}
xi.teleport.id = ids

-----------------------------------
-- TELEPORT TO SINGLE DESTINATION
-----------------------------------

xi.teleport.destination =
{
    [ids.DEM]                   = {  220.000,   19.104,  300.000,   0, 108 }, -- (R)
    [ids.HOLLA]                 = {  420.000,   19.104,   20.000,   0, 102 }, -- (R)
    [ids.YHOAT]                 = { -280.942,    0.596, -144.156,   0, 124 }, -- (R)
    [ids.VAHZL]                 = {  150.258,  -21.048,  -37.256,  94, 112 }, -- (R)
    [ids.MEA]                   = {  100.000,   35.151,  340.000,   0, 117 }, -- (R)
    [ids.ALTEP]                 = {  -61.942,    3.949,  224.900,   0, 114 }, -- (R)
    [ids.JUGNER]                = { -122.862,    0.000, -163.154, 192,  82 }, -- (R)
    [ids.PASHH]                 = {  345.472,   24.280, -114.731,  99,  90 }, -- (R)
    [ids.MERIPH]                = {  305.989,  -14.978,   18.960, 192,  97 }, -- (R)
    [ids.AZOUPH]                = {  495.450,  -28.250, -478.430,  32,  79 }, -- (R)
    [ids.BHAFLAU]               = { -172.863,  -12.250, -801.021, 128,  52 }, -- (R)
    [ids.ZHAYOLM]               = {  681.950,  -24.000,  369.936,  64,  61 }, -- (R)
    [ids.DVUCCA]                = { -252.715,   -7.666,  -30.640, 128,  79 }, -- (R)
    [ids.REEF]                  = {    9.304,   -7.376,  620.133,   0,  54 }, -- (R)
    [ids.ALZADAAL]              = {  180.000,    0.000,   20.000,   0,  72 }, -- (R)
    [ids.CUTTER]                = { -456.000,   -3.000, -405.000, -405, 54 },
    [ids.A_REM]                 = { -579.000,   -0.050, -100.000, 192,  72 },
    [ids.B_REM]                 = {  620.000,    0.000, -260.640,  72,  72 }, -- (R)
    [ids.S_REM]                 = {  580.000,    0.000,  500.000, 192,  72 }, -- (R)
--  [ids.Z_REM]                 = {  000.000,    0.000,  000.000, 000,  72 },
    [ids.MAAT]                  = {   11.000,    3.000,  117.000,   0, 243 },
    [ids.EXITPROMMEA]           = {  179.000,   35.000,  256.000,  63, 117 },
    [ids.EXITPROMHOLLA]         = {  337.000,   19.000,  -60.000, 125, 102 },
    [ids.EXITPROMDEM]           = {  136.000,   19.000,  220.000, 130, 108 },
    [ids.LUFAISE]               = {  438.000,    0.000,  -18.000,  11,  24 },
    [ids.CHOCO_SANDORIA]        = {   -8.557,    1.999,  -80.093,  64, 230 }, -- (R)
    [ids.CHOCO_BASTOK]          = {   40.164,    0.000,  -83.578,  64, 234 }, -- (R)
    [ids.CHOCO_WINDURST]        = {  113.355,   -5.000, -133.118,   0, 241 }, -- (R)
    [ids.CHOCO_UPPER_JEUNO]     = {  -44.000,    7.900,   98.000, 170, 244 },
    [ids.DUCALGUARD]            = {   48.930,   10.002,  -71.032, 195, 243 },
    [ids.PURGONORGO]            = { -398.689,   -3.038, -415.835,   0,   4 }, -- (R)
    [ids.AZOUPH_SP]             = {  522.730,  -28.009, -502.621, 161,  79 }, -- (R)
    [ids.MAMOOL_SP]             = { -210.291,  -11.500, -818.056, 255,  52 }, -- (R)
    [ids.HALVUNG_SP]            = {  688.994,  -23.960,  351.496, 191,  61 }, -- (R)
    [ids.DVUCCA_SP]             = { -265.632,   -6.000,  -29.472,  94,  79 }, -- (R)
    [ids.ILRUSI_SP]             = {   17.540,   -7.250,  627.968, 254,  54 }, -- (R)
    [ids.NYZUL_SP]              = {  222.798,   -0.500,   19.872,   0,  72 }, -- (R)
    [ids.SKY]                   = { -134.145,  -32.328, -205.947, 215, 130 }, -- (R)
    [ids.CLOISTER_OF_FLAMES]    = { -716.461,    0.407, -606.661, 168, 207 }, -- (R)
    [ids.CLOISTER_OF_FROST]     = {  550.403,    0.006,  584.820, 217, 203 }, -- (R)
    [ids.CLOISTER_OF_GALES]     = { -374.919,    0.628, -386.774, 226, 201 }, -- (R)
    [ids.CLOISTER_OF_STORMS]    = {  540.853,  -13.329,  511.298,  82, 202 }, -- (R)
    [ids.CLOISTER_OF_TIDES]     = {  570.294,   36.757,  546.895, 167, 211 }, -- (R)
    [ids.CLOISTER_OF_TREMORS]   = { -540.269,    1.396, -509.800, 192, 209 }, -- (R)
    [ids.GHELSBA_HUT]           = { -156.000,  -10.000,   80.000, 119, 140 },
    [ids.WAJAOM_LEYPOINT]       = { -200.116,  -10.000,   79.879, 213,  51 }, -- (R)
    [ids.VALKURM_VORTEX]        = {  420.062,    0.000, -199.904,  87, 103 }, -- (R)
    [ids.QUFIM_VORTEX]          = { -436.000,  -13.499,  340.117, 107, 126 }, -- (R)
    [ids.LUFAISE_VORTEX]        = {  458.847,    7.999,    5.519,  72,  24 }, -- (R)
    [ids.MISAREAUX_VORTEX]      = { -118.000,  -32.000,  219.000,   3,  25 }, -- (R)
    [ids.MINESHAFT]             = {  -93.657, -120.000, -583.561,   0,  13 }, -- (R)
    [ids.WHITEGATE]             = {   27.424,   -6.000, -123.792, 192,  50 }, -- (R)
    [ids.SEA]                   = {  -31.800,    0.000, -618.700, 190,  33 }, -- (R)
    [ids.ZVAHL_KEEP]            = { -555.996,  -70.100,   59.989,   0, 162 },
    [ids.SOUTHERN_SAN_DORIA_S]  = {  -98.000,    1.000,  -41.000, 224,  80 },
    [ids.BASTOK_MARKETS_S]      = { -291.000,  -10.000, -107.000, 212,  87 },
    [ids.WINDURST_WATERS_S]     = {  -31.442,   -5.000,  129.202, 128,  94 },
    [ids.ESCHA_ZITAH]           = {     -338,        6,     -225, 172, 288 },
    [ids.QUFIM_CONFLUENCE]      = {     -203,      -20,       81,  76, 126 },
    [ids.ESCHA_RUAUN]           = {   -0.371,  -34.279, -466.980, 192, 289 },
    [ids.MISAREAUX_CONFLUENCE]  = {  -57.385,  -21.460,  568.941, 160,  25 }
}

xi.teleport.type =
{
    OUTPOST_SANDORIA   = 0,
    OUTPOST_BASTOK     = 1,
    OUTPOST_WINDURST   = 2,
    RUNIC_PORTAL       = 3,
    PAST_MAW           = 4,
    ABYSSEA_CONFLUX    = 5,
    CAMPAIGN_SANDORIA  = 6,
    CAMPAIGN_BASTOK    = 7,
    CAMPAIGN_WINDURST  = 8,
    HOMEPOINT          = 9,
    SURVIVAL           = 10,
    WAYPOINT           = 11,
    ESCHAN_PORTAL      = 12,
}

xi.teleport.runic_portal =
{
    AZOUPH  = 1,
    DVUCCA  = 2,
    MAMOOL  = 3,
    HALVUNG = 4,
    ILRUSI  = 5,
    NYZUL   = 6,
}

xi.teleport.to = function(player, destination)
    local dest = xi.teleport.destination[destination]
    if dest then
        player:setPos(unpack(dest))
    end
end

-----------------------------------
-- TELEPORT TO PARTY LEADER
-----------------------------------

xi.teleport.toLeader = function(player)
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
    [ 1] = {  205.973, -23.587, -206.606, 167, 137 }, -- (R) Xarcabard [S]
    [ 2] = {  -46.172, -60.109,  -38.487,  16, 136 }, -- (R) Beaucedine Glacier [S]
    [ 3] = {  306.939,  -1.000, -141.567, 173,  84 }, -- (R) Batallia Downs [S]
    [ 4] = {   -4.701,  15.982,  235.996, 160,  91 }, -- (R) Rolanberry Fields [S]
    [ 5] = {  -64.212,   7.625,  -51.292, 192,  98 }, -- (R) Sauromugue Champaign [S]
    [ 6] = {   60.617,  -3.949,   56.658,  64,  82 }, -- (R) Jugner Forest [S]
    [ 7] = {  504.088,  24.511,  628.360,  69,  90 }, -- (R) Pashhow Marshlands [S]
    [ 8] = { -447.084,  23.433,  586.847,  31,  97 }, -- (R) Meriphataud Mountains [S]
    [ 9] = {  -77.817, -47.234, -302.732, 135,  83 }, -- (R) Vunkerl Inlet [S]
    [10] = {  314.335, -36.368,  -12.200, 192,  89 }, -- (R) Grauberg [S]
    [11] = {  141.021, -45.000,   19.543,   0,  96 }, -- (R) Fort Karugo-Narugo [S]
    [12] = {  183.297, -19.971, -240.895,   2,  81 }, -- (R) East Ronfaure [S]
    [13] = { -441.332,  40.000,  -77.986, 164,  88 }, -- (R) North Gustaberg [S]
    [14] = { -104.707, -21.838,  258.043, 237,  95 }, -- (R) West Sarutabaruta [S]
    [15] = {  -98.000,   1.000,  -41.000, 224,  80 }, --     Southern San d'Oria [S]
    [16] = { -291.000, -10.000, -107.000, 212,  87 }, --     Bastok Markets [S]
    [17] = {  -31.442,  -5.000,  129.202, 128,  94 }, -- (R) Windurst Waters [S]
    [18] = { -194.095,   0.000,   30.009,   0, 164 }, -- (R) Garlaige Citdadel [S]
    [19] = {   59.213, -32.158,  -38.022,  64, 171 }, -- (R) Crawlers' Nest [S]
    [20] = {  294.350, -27.500,   19.947,   0, 175 }, -- (R) The Eldieme Necropolis [S]
}

xi.teleport.toCampaign = function(player, option)
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
    [xi.region.RONFAURE]        = { -437.688, -20.255, -219.227, 124, 100 }, -- Ronfaure (R)
    [xi.region.ZULKHEIM]        = {  148.231,  -7.975,   93.479, 154, 103 }, -- Zulkheim (R)
    [xi.region.NORVALLEN]       = {   62.030,   0.463,   -2.025,  67, 104 }, -- Norvallen (R)
    [xi.region.GUSTABERG]       = { -580.161,  39.578,   62.680,  89, 106 }, -- Gustaberg (R)
    [xi.region.DERFLAND]        = {  465.820,  23.625,  423.164,  29, 109 }, -- Derfland (R)
    [xi.region.SARUTABARUTA]    = {  -17.921, -13.335,  318.156, 254, 115 }, -- Sarutabaruta (R)
    [xi.region.KOLSHUSHU]       = { -480.237, -30.943,   58.079,  62, 118 }, -- Kolshushu (R)
    [xi.region.ARAGONEU]        = { -297.047,  16.988,  418.026, 225, 119 }, -- Aragoneu (R)
    [xi.region.FAUREGANDI]      = {  -18.690, -60.048, -109.243, 100, 111 }, -- Fauregandi (R)
    [xi.region.VALDEAUNIA]      = {  211.210, -24.016, -207.338, 160, 112 }, -- Valdeaunia (R)
    [xi.region.QUFIMISLAND]     = { -243.049, -19.983,  306.712,  71, 126 }, -- Qufim Island (R)
    [xi.region.LITELOR]         = {  -37.669,   0.419, -141.216,  69, 121 }, -- Li'Telor (R)
    [xi.region.KUZOTZ]          = { -249.983,   7.965, -252.976, 122, 114 }, -- Kuzotz (R)
    [xi.region.VOLLBOW]         = { -176.360,   7.624,  -63.580, 122, 113 }, -- Vollbow (R)
    [xi.region.ELSHIMOLOWLANDS] = { -240.860,  -0.031, -388.434,  64, 123 }, -- Elshimo Lowlands (R)
    [xi.region.ELSHIMOUPLANDS]  = {  207.821,  -0.128,  -86.623, 159, 124 }, -- Elshimo Uplands (R)
    [xi.region.TULIA]           = {    4.000, -54.000, -600.000, 192, 130 }, -- Tu'Lia (can't acquire on retail, but exists in NCP event menu)
    [xi.region.TAVNAZIANARCH]   = { -535.861,  -7.149,  -53.628, 122,  24 }, -- Tavnazia (R)
}

xi.teleport.toOutpost = function(player, region)
    local dest = outpostDestinations[region]
    player:setPos(unpack(dest))
end

-----------------------------------
-- TELEPORT TO HOME NATION
-----------------------------------

xi.teleport.toHomeNation = function(player)
    local pNation = player:getNation()
    if pNation == xi.nation.BASTOK then
        player:setPos(89, 0 , -66, 0, 234)
    elseif pNation == xi.nation.SANDORIA then
        player:setPos(49, -1 , 29, 164, 231)
    else
        player:setPos(193, -12 , 220, 64, 240)
    end
end

-----------------------------------
-- TELEPORT TO ALLIED NATION
-----------------------------------

xi.teleport.toAlliedNation = function(player)
    local allegiance = player:getCampaignAllegiance()
    local sandoriaPos = xi.teleport.destination[ids.SOUTHERN_SAN_DORIA_S]
    local bastokPos = xi.teleport.destination[ids.BASTOK_MARKETS_S]
    local windurstPos = xi.teleport.destination[ids.WINDURST_WATERS_S]

    if allegiance == xi.alliedNation.SANDORIA then
        player:setPos(unpack(sandoriaPos))
    elseif allegiance == xi.alliedNation.BASTOK then
        player:setPos(unpack(bastokPos))
    elseif allegiance == xi.alliedNation.WINDURST then
        player:setPos(unpack(windurstPos))
    end
end

-----------------------------------
-- TELEPORT TO CHAMBER OF PASSAGE
-----------------------------------

xi.teleport.toChamberOfPassage = function(player)
    if math.random(1, 2) == 1 then
        player:setPos(133.400, 1.485, 47.427, 96, 50) -- (R) Aht Urhgan Whitegate Chamber of Passage Left
    else
        player:setPos(116.670, 1.485, 47.427, 32, 50) -- (R) Aht Urhgan Whitegate Chamber of Passage Right
    end
end

-----------------------------------
-- TELEPORT TO EXPLORER MOOGLE
-----------------------------------

xi.teleport.toExplorerMoogle = function(player, zone)
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

-- TODO: Use Zone Table for FromZone and perhaps ToZone, heck, maybe just move this to one beefy zone table?
-- TODO: Arrapago Remnants I/II, Zhaylohm Remnants I/II, Everbloom Hollow?, Ruhoyz Silvermines?, The Ashu Talif?
-- TODO: Abyssea / SOA Areas
-- MISC Flag in zone_settings will also need +1 or -1 depending on escape possibility.
local escapeDestinations =
{
--  FromZone        X      Y         Z  Rot  ToZone
    [  9] = {    -427,   -41,     -422,   0, 111 }, -- Pso'Xja to Beaucedine Glacier (E-11)
    [ 10] = {    -427,   -41,     -422,   0, 111 }, -- The Shrouded Maw to Beaucedine Glacier (E-11)
    [ 11] = {     448,    -4,      730,  96, 106 }, -- Oldton Movalpolos to North Gustaberg (K-6)
    [ 12] = {     448,    -4,      730,  96, 106 }, -- Newton Movalpolos to North Gustaberg (K-6)
    [ 13] = {     448,    -4,      730,  96, 106 }, -- Mine Shaft 2716 to North Gustaberg (K-6)
    [ 16] = {     332,    24,     -148,  96, 102 }, -- Promyvion-Holla to La Theine Plateau (J-9)
    [ 17] = {     332,    24,     -148,  96, 102 }, -- Spire of Holla to La Theine Plateau (J-9)
    [ 18] = {     134,    24,      134,  96, 108 }, -- Promyvion-Dem to Konschtat Highlands (I-7)
    [ 19] = {     134,    24,      134,  96, 108 }, -- Spire of Dem to Konschtat Highlands (I-7)
    [ 20] = {     266,    40,      254,  32, 117 }, -- Promyvion-Mea to Tahrongi Canyon (J-6)
    [ 21] = {     266,    40,      254,  32, 117 }, -- Spire of Mea to Tahrongi Canyon (J-6)
    [ 22] = {    -331,  -100,      128,  32, 111 }, -- Promyvion-Vahzl to Beaucedine Glacier (F-7)
    [ 23] = {    -331,  -100,      128,  32, 111 }, -- Spire of Vahzl to Beaucedine Glacier (F-7)
    [ 27] = {     540,   -16,      265, 160,  25 }, -- Phomiuna Aqueducts to Misareaux Coast (K-7)
    [ 28] = {      39,   -24,      743,  64,  25 }, -- Sacrarium to Misareaux Coast (H-4)
    [ 29] = {    -483,   -31,      403, 116,  25 }, -- Riverne - Site #B01 to Misareaux Coast (D-6)
    [ 30] = {    -483,   -31,      403, 116,  25 }, -- Riverne - Site #A01 to Misareaux Coast (D-6)
    [ 31] = {    -483,   -31,      403, 116,  25 }, -- Monarch Linn to Misareaux Coast (D-6)
    [ 34] = {     -23,     0,     -465,  64,  33 }, -- Grand Palace of HuXzoi to Al'Taieu (H-11)
    [ 35] = {     -23,     0,     -465,  64,  33 }, -- The Garden of RuHmet to Al'Taieu (H-11)
    [ 36] = {     -23,     0,     -465,  64,  33 }, -- Empyreal Paradox to Al'Taieu (H-11)
    [ 54] = {  227.36, -17.3,  -60.718,  95,  79 }, -- Arrapago Reef to Caedarva Mire Azouph Isle (I-6)
    [ 55] = {   9.304,  -7.4,  620.133,   0,  54 }, -- Ilrusi Atoll to Arrapago Reef (G-4)
    [ 56] = { -252.72,  -7.7,   -30.64, 128,  79 }, -- Periqia to Caedarva Mire (?-??)
    [ 57] = { -467.08,  7.89, -538.603,   0,  79 }, -- Talacca Cove to Caedarva Mire Azouph Isle (E-9)
    [ 62] = { 860.994, -15.7,  223.567, 192,  61 }, -- Halvung to Mount Zhayolm (L-7)
    [ 63] = { 681.950,   -24,  369.936,  64,  61 }, -- Lebros Cavernto Mount Zhayolm (?-??)
    [ 64] = { -630.15, -17.6,  223.012,   0,  61 }, -- Navukgo Execution Chamber to Mount Zhayolm (C-7)
    [ 65] = { -459.96, -4.36,  -513.19, 192,  51 }, -- Mamook to Wajaom Woodlands (E-12)
    [ 66] = { -172.86, -12.3,  -801.02, 128,  52 }, -- Mamool Ja Training Grounds to Bhaflau Thickets (?-??)
    [ 67] = { -125.76, -12.2,  -499.69, 124,  52 }, -- Jade Sepulcher to Bhaflau Thickets (I-9)
    [ 68] = {  95.251,   -16,  428.910,  64,  51 }, -- Aydeewa Subterrane to Wajaom Woodlands (I-6)
    [ 69] = {  495.45, -28.3,  -478.43,  32,  79 }, -- Leujaoam Sanctum to Caedarva Mire (?-??)
    [ 72] = {  14.186, -29.8,  590.427,   0,  52 }, -- Alzadaal Undersea Ruins to Bhaflau Thickets (F-6)
    [ 75] = {     620,     0,     -260,  64,  72 }, -- Bhaflau Remnants I/II to Alzadaal Undersea Ruins BR (H-8)
    [ 76] = {     580,     0,      500, 192,  72 }, -- Silver Sea Remnants I/II to Alzadaal Undersea Ruins SSR (H-8)
    [ 77] = {     180,     0,       20,   0,  72 }, -- Nyzul Isle Investigation/Uncharted Region to Alzadaal Undersea Ruins (?-??)
    [ 78] = { -467.08,  7.89, -538.603,   0,  79 }, -- Hazhalm Testing Grounds to Caedarva Mire Azouph Isle (E-9)
    [ 85] = { -203.58, -7.35,  -494.53,   0,  82 }, -- La Vaule (S) to Jugner Forest (S) (G-12)
    [ 92] = { 548.199,    25, -341.959, 128,  90 }, -- Beadeaux (S) to Pashhow Marshlands (S) (K-11)
    [ 99] = { 720.589,   -32,  -81.495, 162,  97 }, -- Castle Oztroja (S) to Meriphataud Mountains (S) (L-8)
    [138] = {    -414,   -44,       19,   0, 137 }, -- Castle Zvahl Baileys (S) to Xarcabard (S) (G-7)
    [139] = {    -720,   -61,      600,  64, 100 }, -- Ghelsba Outpost to West Ronfaure (E-4)
    [140] = {    -720,   -61,      600,  64, 100 }, -- Fort Ghelsba to West Ronfaure (E-4)
    [141] = {    -720,   -61,      600,  64, 100 }, -- Yughott Grotto to West Ronfaure (E-4)
    [142] = {    -720,   -61,      600,  64, 100 }, -- Horlais Peak to West Ronfaure (E-4)
    [143] = {     483,   -31,     1159, 128, 106 }, -- Palborough Mines to North Gustaberg (K-3)
    [144] = {     483,   -31,     1159, 128, 106 }, -- Waughroon Shrine to North Gustaberg (K-3)
    [145] = {    -360,   -20,       78, 192, 115 }, -- Giddeus to West Sarutabaruta (F-8)
    [146] = {    -360,   -20,       78, 192, 115 }, -- Balgas Dais to West Sarutabaruta (F-8)
    [147] = {     557,    24,     -385, 192, 109 }, -- Beadeaux to Pashhow Marshlands (K-11)
    [148] = {     557,    24,     -385, 192, 109 }, -- Qulun Dome to Pashhow Marshlands (K-11)
    [149] = {    -232,    -8,     -562,   0, 104 }, -- Davoi to Jugner Forest (G-12)
    [150] = {    -232,    -8,     -562,   0, 104 }, -- Monastic Cavern to Jugner Forest (G-12)
    [151] = {     718,   -31,      -63, 128, 119 }, -- Castle Oztroja to Meriphataud Mountains (L-8)
    [152] = {     718,   -31,      -63, 128, 119 }, -- Altar Room to Meriphataud Mountains (L-8)
    [153] = {   509.5,     1,     -575, 128, 121 }, -- The Boyahda Tree to The Sanctuary of Zi'Tah (K-12)
    [154] = {   509.5,     1,     -575, 128, 121 }, -- Dragon's Aery to The Sanctuary of Zi'Tah (K-12)
    [155] = {    -414,   -44,       19,   0, 137 }, -- Castle Zvahl Keep (S) to Xarcabard (S) (G-7)
    [157] = {    -267,   -20,      320,   0, 126 }, -- Middle Delkfutt's Tower to Qufim Island (F-6)
    [158] = {    -267,   -20,      320,   0, 126 }, -- Upper Delkfutt's Tower to Qufim Island (F-6)
    [159] = {     298,    -2,     -445, 192, 124 }, -- Temple of Uggalepih to Yhoator Jungle (J-11)
    [160] = {     298,    -2,     -445, 192, 124 }, -- Den of Rancor to Yhoator Jungle (J-11)
    [161] = {    -414,   -44,       19,   0, 112 }, -- Castle Zvahl Baileys to Xarcabard (G-7)
    [162] = {    -414,   -44,       19,   0, 112 }, -- Castle Zvahl Keep to Xarcabard (G-7)
    [163] = {     298,    -2,     -445, 192, 124 }, -- Sacrificial Chamber to Yhoator Jungle (J-11)
    [164] = {    -112,   -24,     -403, 192,  98 }, -- Garlaige Citadel (S) to Sauromugue Champaign (S) (H-11)
    [165] = {    -414,   -44,       19,   0, 112 }, -- Throne Room to Xarcabard (G-7)
    [166] = {     803,   -61,      635, 128, 101 }, -- Ranguemont Pass to East Ronfaure (K-4)
    [167] = {    -685,   -30,       18,   0, 100 }, -- Bostaunieux Oubliette to West Ronfaure (F-8)
    [168] = {     454,   -11,      -35, 128, 114 }, -- Chamber of Oracles to Eastern Altepa Desert (J-8)
    [169] = {     366,   -13,       92, 128, 116 }, -- Toraimarai Canal to East Sarutabaruta (J-7)
    [170] = {     366,   -13,       92, 128, 116 }, -- Full Moon Fountain to East Sarutabaruta (J-7)
    [171] = {    -356,   -24,     -763, 192,  91 }, -- Crawlers' Nest (S) to Rolanberry Field (S) (G-13)
    [173] = {     -75,    -1,       20,   0, 172 }, -- Korroloka Tunnel to Zeruhn Mines (H-7)
    [174] = {     -46,     6,      418, 192, 125 }, -- Kuftal Tunnel to Western Altepa Desert (I-5)
    [175] = { 283.593, 7.999, -403.207, 145,  84 }, -- The Eldieme Necropolis (S) to Batallia Downs (S) (J-10)
    [176] = {    -627,    16,     -427, 192, 123 }, -- Sea Serpent Grotto to Yuhtunga Jungle (E-11)
    [177] = {       0,   -35,     -472, 192, 130 }, -- Ve'Lugannon Palace to Ru'Aun Gardens (H-11)
    [178] = {       0,   -35,     -472, 192, 130 }, -- Shrine of Ru'Avitau to Ru'Aun Gardens (H-11)
    [179] = {    -267,   -20,      320,   0, 126 }, -- Stellar Fulcrum to Qufim Island (F-6)
    [180] = {       0,   -35,     -472, 192, 130 }, -- LaLoff Amphitheater to Ru'Aun Gardens (H-11)
    [181] = {       0,   -35,     -472, 192, 130 }, -- The Celestial Nexus to Ru'Aun Gardens (H-11)
    [184] = {    -267,   -20,      320,   0, 126 }, -- Lower Delkfutt's Tower to Qufim Island (F-6)
    [190] = {     203,    -1,     -521, 192, 101 }, -- King Ranperre's Tomb to East Ronfaure (H-11)
    [191] = {    -564,    38,     -541,   0, 107 }, -- Dangruf Wadi to South Gustaberg (E-9)
    [192] = {     366,   -13,       92, 128, 116 }, -- Inner Horutoto Ruins to East Sarutabaruta (J-7)
    [193] = {    -261,    23,      123, 192, 102 }, -- Ordelle's Caves to La Theine Plateau (F-7)
    [194] = {     366,   -13,       92, 128, 116 }, -- Outer Horutoto Ruins to East Sarutabaruta (J-7)
    [195] = { 382.398, 7.314, -106.298, 160, 105 }, -- The Eldieme Necropolis to Batallia Downs (F-8)
    [196] = {     680,    21,      204,  64, 108 }, -- Gusgen Mines to Konschtat Highlands (L-7)
    [197] = {    -356,   -24,     -763, 192, 110 }, -- Crawlers' Nest to Rolanberry Fields (F-13)
    [198] = {     446,    46,      481, 128, 117 }, -- Maze of Shakhrami to Tahrongi Canyon (K-5)
    [200] = {    -112,   -24,     -403, 192, 120 }, -- Garlaige Citadel to Sauromugue Champaign (H-10)
    [201] = {    -291,    -3,      494,  32, 113 }, -- Cloister of Gales to Cape Teriggan (F-5)
    [202] = {   509.5,     1,     -575, 128, 121 }, -- Cloister of Storms to The Sanctuary of Zi'Tah (K-12)
    [203] = {     279,    19,      536,  64, 111 }, -- Cloister of Frost to Beaucedine Glacier (J-5)
    [204] = {     279,    19,      536,  64, 111 }, -- Fei'Yin to Beaucedine Glacier (J-5)
    [205] = {      91,    -1,      336,  96, 124 }, -- Ifrit's Cauldron to Yhoator Jungle (I-6)
    [206] = {     279,    19,      536,  64, 111 }, -- Qu'Bia Arena to Beaucedine Glacier (J-5)
    [207] = {      91,    -1,      336,  96, 124 }, -- Cloister of Flames to Yhoator Jungle (I-6)
    [208] = {     454,   -11,      -35, 128, 114 }, -- Quicksand Caves to Eastern Altepa Desert (J-8)
    [209] = {     454,   -11,      -35, 128, 114 }, -- Cloister of Tremors to Eastern Altepa Desert (J-8)
    [211] = {     298,    -2,     -445, 192, 124 }, -- Cloister of Tides to Yhoator Jungle (J-11)
    [212] = {    -791,    -6,       57, 192, 103 }, -- Gustav Tunnel to Valkurm Dunes (B-8)
    [213] = {     447,    18,      191,  32, 118 }, -- Labyrinth of Onzozo to Buburimu Peninsula (K-6)
}

xi.teleport.escape = function(player)
    local zone = player:getZoneID()

    if utils.hasKey(zone, escapeDestinations) then
        player:setPos(unpack(escapeDestinations[zone]))
    else
        printf('WARNING: xi.teleport.escape received undefined escapeDestinations zone (%d)', zone)
    end
end

-----------------------------------
-- EXPLORER MOOGLE EVENTS
-----------------------------------

xi.teleport.explorerMoogleOnTrigger = function(player, event)
    local accept = 0

    if player:getGil() < 300 then
        accept = 1
    end

    if player:getMainLvl() < xi.settings.main.EXPLORER_MOOGLE_LV then
        event = event + 1
    end

    player:startEvent(event, player:getZoneID(), 0, accept)
end

xi.teleport.explorerMoogleOnEventFinish = function(player, csid, option, event)
    local price = 300

    if csid == event then
        if option == 1 and player:delGil(price) then
            xi.teleport.toExplorerMoogle(player, 231)
        elseif option == 2 and player:delGil(price) then
            xi.teleport.toExplorerMoogle(player, 234)
        elseif option == 3 and player:delGil(price) then
            xi.teleport.toExplorerMoogle(player, 240)
        elseif option == 4 and player:delGil(price) then
            xi.teleport.toExplorerMoogle(player, 248)
        elseif option == 5 and player:delGil(price) then
            xi.teleport.toExplorerMoogle(player, 249)
        end
    end
end

xi.teleport.tidalDestinations =
{
    [xi.zone.CHATEAU_DORAGUILLE]   = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.NORTHERN_SAN_DORIA]   = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.SOUTHERN_SAN_DORIA]   = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.PORT_SAN_DORIA]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.BASTOK_MARKETS]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.BASTOK_MINES]         = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.METALWORKS]           = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.PORT_BASTOK]          = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.PORT_WINDURST]        = {   0,   3,   2 , 64, xi.zone.RULUDE_GARDENS },
    [xi.zone.WINDURST_WALLS]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.WINDURST_WATERS]      = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.WINDURST_WOODS]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.KAZHAM]               = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.LOWER_JEUNO]          = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.PORT_JEUNO]           = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.UPPER_JEUNO]          = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.RULUDE_GARDENS]       = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.MHAURA]               = {  18, -14,  79,  62, xi.zone.SELBINA },
    [xi.zone.SELBINA]              = {   0,  -8,  59,  62, xi.zone.MHAURA },
    [xi.zone.AHT_URHGAN_WHITEGATE] = {  12,  -6,  31,  63, xi.zone.NASHMAU },
    [xi.zone.NASHMAU]              = { -73,   0,   0, 252, xi.zone.AHT_URHGAN_WHITEGATE },
}

xi.teleport.tidalTeleport = function(player)
    local zone = player:getZoneID()
    local destination = xi.teleport.tidalDestinations[zone]

    if destination then
        player:setPos(unpack(destination))
    end
end
