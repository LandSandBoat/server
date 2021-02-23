-----------------------------------
-- Unity Concord NPC Global
-----------------------------------
 require("scripts/globals/zone")
-----------------------------------
tpz = tpz or {}
tpz.unity = tpz.unity or {}

-- Table Format: Needs 10 RoE Objectives, All for One not set, All for One set, Unity Joined, Zone Directory Name
local zoneEventIds =
{
    [tpz.zone.SOUTHERN_SAN_DORIA ] = { 3528, 3525, 3526, 3529, "Southern_San_dOria" },
    [tpz.zone.BASTOK_MARKETS     ] = {  597,  594,  595,  598, "Bastok_Markets"     },
    [tpz.zone.WINDURST_WOODS     ] = {  878,  875,  876,  879, "Windurst_Woods"     },
    [tpz.zone.WESTERN_ADOULIN    ] = { 5148, 5145, 5146, 5149, "Western_Adoulin"    },
}

-- Table Format: X, Y, Z, Rot, Zone ID
local unityOptions =
{
    [1] =
    { -- Unity Warp
        [ 0] = {  176.000, -240.000, -20.002,   7, 101 }, -- East Ronfaure
        [ 1] = { -450.000, -149.000,  38.750,  95, 107 }, -- South Gustaberg
        [ 2] = {  358.750,   10.000, -12.375, 127, 116 }, -- East Sarutabaruta
        [ 3] = {    2.180,    0.420,   0.000, 114, 102 }, -- La Theine Plateau
        [ 4] = { -112.100,  271.180,  12.428, 166, 108 }, -- Konschtat Highlands
        [ 5] = {  360.000,  -45.000,  -0.133,  83, 117 }, -- Tahrongi Canyon
        [ 6] = {   63.000,  -75.000,   1.149, 179, 103 }, -- Valkurm Dunes
        [ 7] = { -325.560,  286.500, -40.923,  40, 118 }, -- Buburimu Peninsula
        [ 8] = {  187.500,  -20.200, -21.374, 131, 126 }, -- Qufim Island
        [ 9] = {  641.500,  881.500, -20.000,  85,   4 }, -- Bibiki Bay
        [10] = {   34.500, -740.820,  -5.861, 253,   2 }, -- Carpenters' Landing
        [11] = { -478.620, -379.840,  16.301,   0, 123 }, -- Yuhtunga Jungle
        [12] = {  408.000,  -73.520,  -0.375,  99,  24 }, -- Lufaise Meadows
        [13] = {   60.000,  -10.000,   0.549, 192, 104 }, -- Jugner Forest
        [14] = { -499.000, -597.500,  25.000, 192, 109 }, -- Pashhow Marshlands
        [15] = { -159.220, -560.320, -24.000, 144, 119 }, -- Meriphataud Mountains
        [16] = {  454.810,  -25.850, -11.415,  91, 114 }, -- Eastern Altepa Desert
        [17] = {  253.850,  103.290,   3.228,  81, 124 }, -- Yhoator Jungle
        [18] = {  508.600, -577.550,   2.450, 143, 121 }, -- The Sanctuary of Zi'Tah
        [19] = { -245.460,  245.440, -32.247,  31,  25 }, -- Misareaux Coast
        [20] = {  -60.000,  110.000,   5.209, 192, 213 }, -- Labyrinth of Onzozo
        [21] = { -378.000, -220.000,  -4.000,   0, 167 }, -- Bostaunieux Oubliette
        [22] = {  439.530, -151.750,   8.212, 148, 105 }, -- Batallia Downs
        [23] = { -770.980, -491.900, -35.768, 222, 110 }, -- Rolanberry Fields
        [24] = {  303.910,  305.350,  37.775, 160, 120 }, -- Sauromugue Champaign
        [25] = {  120.570, -179.600,  -3.645, 255, 111 }, -- Beaucedine Glacier
        [26] = {  576.200, -264.850,   0.000, 110, 112 }, -- Xarcabard
        [27] = {    0.000, -145.000,  -8.000, 192, 122 }, -- Ro'Maeve
        [28] = {   91.340,  -23.440,  -1.167, 127, 125 }, -- Western Altepa Desert
        [29] = { -311.000,  167.000,  -5.085, 111,   7 }, -- Attohwa Chasm
        [30] = { -300.000,  322.500,  18.000,  63, 200 }, -- Garlaige Citadel
        [31] = {   80.000,  259.000,   0.000, 127, 205 }, -- Ifrit's Cauldron
        [32] = {  -60.000,   17.000, -19.329,  15, 153 }, -- The Boyahda Tree
        [33] = {   27.450,  264.000, -13.531,   7, 174 }, -- Kuftal Tunnel
        [34] = {   18.500, -105.500,  19.969,  99, 176 }, -- Sea Serpent Grotto
        [35] = {  -60.000,   82.000,  -8.000,  63, 159 }, -- Temple of Uggalepih
        [36] = {  860.000, -372.000,  -8.094,  63, 208 }, -- Quicksand Caves
        [37] = {  100.000, -163.000, -12.000,  63,  51 }, -- Wajaom Woodlands
        [38] = {  408.000,  -73.520,  -0.375,  99,  24 }, -- Lufaise Meadows
        [39] = {   68.230,  148.040,  -6.185,   0, 113 }, -- Cape Teriggan
    --  [40] = ???
        [41] = { -418.320, -103.470, -16.758, 176,   5 }, -- Uleguerand Range
        [42] = {   23.750, -259.740,  26.593, 212, 160 }, -- Den of Rancor
        [43] = { -177.000, -171.000, -23.979, 232, 204 }, -- Fei'Yin
    --  [44] = ???
    --  [45] = ???
        [46] = { -245.460,  245.440, -32.247,  31,  25 }, -- Misareaux Coast
        [47] = { -613.000,  230.000, -21.301, 224,  61 }, -- Mount Zhayolm
        [48] = {  -60.000, -119.000, -10.000, 192, 212 }, -- Gustav Tunnel
        [49] = { -183.100,   57.900, -19.854, 127, 127 }, -- Behemoth's Dominion
        [50] = {  -60.000,   17.000, -19.329,  15, 153 }, -- The Boyahda Tree
    --  [51] = Valley of Sorrows
    --  [52] = Wajaom Woodlands
    --  [53] = Mount Zhayolm
    },

    -- 5 - Change Unity
}

local function changeUnityLeader(player, leader)
    player:setUnityLeader(leader)
    player:setCharVar("unity_changed", 1)

    -- Reset ranking data on change
    player:setCurrency("current_accolades", 0)
    player:setCurrency("prev_accolades", 0)
end

function tpz.unity.onTrade(player, npc, trade, eventid)
end

function tpz.unity.onTrigger(player, npc)
    local zoneId = player:getZoneID()
    local hasAllForOne = player:hasEminenceRecord(5)
    local allForOneCompleted = player:getEminenceCompleted(5)
    local accolades = player:getCurrency("unity_accolades")
    local remainingLimit = WEEKLY_EXCHANGE_LIMIT - player:getCharVar("weekly_accolades_spent")

    -- Check player total records completed
    if player:getNumEminenceCompleted() < 10 then
        player:startEvent(zoneEventIds[zoneId][1])

    -- Check for "All for One"
    elseif not hasAllForOne and not allForOneCompleted then
        player:startEvent(zoneEventIds[zoneId][2])

    -- First time selecting Unity
    elseif not allForOneCompleted then
        player:startEvent(zoneEventIds[zoneId][3])
    else
        player:startEvent(zoneEventIds[zoneId][4], 0, 0, accolades, remainingLimit)
    end
end

function tpz.unity.onEventUpdate(player, csid, option)
    local category  = bit.band(option, 0x1F)
    local selection = bit.rshift(option, 5) -- This may need tuning
end

function tpz.unity.onEventFinish(player, csid, option)
    local zoneNum = player:getZoneID()
    local ID = require(string.format("scripts/zones/%s/IDs", zoneEventIds[zoneNum][5]))
    local category  = bit.band(option, 0x1F)
    local selection = bit.rshift(option, 5) -- This may need tuning

    if
        csid == zoneEventIds[zoneId][3] and
        option >= 1 and
        option <= 11
    then
        changeUnityLeader(player, option)
        tpz.roe.onRecordTrigger(player, 5)
        player:messageSpecial(ID.text.YOU_HAVE_JOINED_UNITY, option)
    end
end
