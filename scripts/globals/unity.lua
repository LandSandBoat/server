-----------------------------------
-- Unity Concord NPC Global
-----------------------------------
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.unity = xi.unity or {}

-- Table Format: Needs 10 RoE Objectives, All for One not set, All for One set, Unity Joined, Zone Directory Name
local zoneEventIds =
{
    [xi.zone.SOUTHERN_SAN_DORIA ] = { 3528, 3525, 3526, 3529, "Southern_San_dOria" },
    [xi.zone.BASTOK_MARKETS     ] = {  597,  594,  595,  598, "Bastok_Markets"     },
    [xi.zone.WINDURST_WOODS     ] = {  878,  875,  876,  879, "Windurst_Woods"     },
    [xi.zone.WESTERN_ADOULIN    ] = { 5148, 5145, 5146, 5149, "Western_Adoulin"    },
}

-- Table Format: X, Y, Z, Rot, Zone ID
local unityOptions =
{
    [1] =
    { -- Unity Warp
        [ 0] = {  176.000,  -20.002, -240.000,   7, 101 }, -- East Ronfaure
        [ 1] = { -450.000,   38.750, -149.000,  95, 107 }, -- South Gustaberg
        [ 2] = {  358.750,  -12.375,   10.000, 127, 116 }, -- East Sarutabaruta
        [ 3] = {    2.180,    0.000,    0.420, 114, 102 }, -- La Theine Plateau
        [ 4] = { -112.100,   12.428,  271.180, 166, 108 }, -- Konschtat Highlands
        [ 5] = {  360.000,   -0.133,  -45.000,  83, 117 }, -- Tahrongi Canyon
        [ 6] = {   63.000,    1.149,  -75.000, 179, 103 }, -- Valkurm Dunes
        [ 7] = { -325.560,  -40.923,  286.500,  40, 118 }, -- Buburimu Peninsula
        [ 8] = {  187.500,  -21.374,  -20.200, 131, 126 }, -- Qufim Island
        [ 9] = {  641.500,  -20.000,  881.500,  85,   4 }, -- Bibiki Bay
        [10] = {   34.500,   -5.861, -740.820, 253,   2 }, -- Carpenters' Landing
        [11] = { -478.620,   16.301, -379.840,   0, 123 }, -- Yuhtunga Jungle
        [12] = {  408.000,   -0.375,  -73.520,  99,  24 }, -- Lufaise Meadows
        [13] = {   60.000,    0.549,  -10.000, 192, 104 }, -- Jugner Forest
        [14] = { -499.000,   25.000, -597.500, 192, 109 }, -- Pashhow Marshlands
        [15] = { -159.220,  -24.000, -560.320, 144, 119 }, -- Meriphataud Mountains
        [16] = {  454.810,  -11.415,  -25.850,  91, 114 }, -- Eastern Altepa Desert
        [17] = {  253.850,    3.228,  103.290,  81, 124 }, -- Yhoator Jungle
        [18] = {  508.600,    2.450, -577.550, 143, 121 }, -- The Sanctuary of Zi'Tah
        [19] = { -245.460,  -32.247,  245.440,  31,  25 }, -- Misareaux Coast
        [20] = {  -60.000,    5.209,  110.000, 192, 213 }, -- Labyrinth of Onzozo
        [21] = { -378.000,   -4.000, -220.000,   0, 167 }, -- Bostaunieux Oubliette
        [22] = {  439.530,    8.212, -151.750, 148, 105 }, -- Batallia Downs
        [23] = { -770.980,  -35.768, -491.900, 222, 110 }, -- Rolanberry Fields
        [24] = {  303.910,   37.775,  305.350, 160, 120 }, -- Sauromugue Champaign
        [25] = {  120.570,   -3.645, -179.600, 255, 111 }, -- Beaucedine Glacier
        [26] = {  576.200,    0.000, -264.850, 110, 112 }, -- Xarcabard
        [27] = {    0.000,   -8.000, -145.000, 192, 122 }, -- Ro'Maeve
        [28] = {   91.340,   -1.167,  -23.440, 127, 125 }, -- Western Altepa Desert
        [29] = { -311.000,   -5.085,  167.000, 111,   7 }, -- Attohwa Chasm
        [30] = { -300.000,   18.000,  322.500,  63, 200 }, -- Garlaige Citadel
        [31] = {   80.000,    0.000,  259.000, 127, 205 }, -- Ifrit's Cauldron
        [32] = {  -60.000,  -19.329,   17.000,  15, 153 }, -- The Boyahda Tree
        [33] = {   27.450,  -13.531,  264.000,   7, 174 }, -- Kuftal Tunnel
        [34] = {   18.500,   19.969, -105.500,  99, 176 }, -- Sea Serpent Grotto
        [35] = {  -60.000,   -8.000,   82.000,  63, 159 }, -- Temple of Uggalepih
        [36] = {  860.000,   -8.094, -372.000,  63, 208 }, -- Quicksand Caves
        [37] = {  100.000,  -12.000, -163.000,  63,  51 }, -- Wajaom Woodlands
        [38] = {  408.000,   -0.375,  -73.520,  99,  24 }, -- Lufaise Meadows
        [39] = {   68.230,   -6.185,  148.040,   0, 113 }, -- Cape Teriggan
        [40] = nil,                                        -- ???
        [41] = { -418.320,  -16.758, -103.470, 176,   5 }, -- Uleguerand Range
        [42] = {   23.750,   26.593, -259.740, 212, 160 }, -- Den of Rancor
        [43] = { -177.000,  -23.979, -171.000, 232, 204 }, -- Fei'Yin
        [44] = nil,                                        -- ???
        [45] = nil,                                        -- ???
        [46] = { -245.460,  -32.247,  245.440,  31,  25 }, -- Misareaux Coast
        [47] = { -613.000,  -21.301,  230.000, 224,  61 }, -- Mount Zhayolm
        [48] = {  -60.000,  -10.000, -119.000, 192, 212 }, -- Gustav Tunnel
        [49] = { -183.100,  -19.854,   57.900, 127, 127 }, -- Behemoth's Dominion
        [50] = {  -60.000,  -19.329,   17.000,  15, 153 }, -- The Boyahda Tree
        [51] = nil,                                        -- Valley of Sorrows
        [52] = nil,                                        -- Wajaom Woodlands
        [53] = nil,                                        -- Mount Zhayolm
    },

    [4] = -- Items (Item ID, askQuantity (0 = true), limitSize (99 = limit by accolades), cost)
    {
        [ 0] = { 9049, 0, 99, 15000 }, -- Refractive Crystal
        [ 1] = { 8973, 0, 99, 15000 }, -- Special Gobbiedial Key
        [ 2] = { 4181, 1,  1, 10 }, -- Scroll of Instant Warp
        [ 3] = { 4182, 1,  1, 10 }, -- Scroll of Instant Reraise
        [ 4] = { 5988, 1,  1, 10 }, -- Scroll of Instant Protect
        [ 5] = { 5989, 1,  1, 10 }, -- Scroll of Instant Shell
        [ 6] = { 5114, 0, 99, 10 }, -- Moist Rolanberry
        [ 7] = { 5115, 0, 99, 10 }, -- Ravaged Moko Grass
        [ 8] = { 5116, 0, 99, 10 }, -- Cavorting Worm
        [ 9] = { 5117, 0, 99, 10 }, -- Levigated Rock
        [10] = { 5118, 0, 99, 10 }, -- Little Lugworm
        [11] = { 5119, 0, 99, 10 }, -- Training Manual
        [12] = { 5945, 0, 99, 10 }, -- Prize Powder
    },
}

local function changeUnityLeader(player, leader)
    player:setCharVar("unity_changed", 1)
    player:setCurrency("current_accolades", 0)
    player:setCurrency("prev_accolades", 0)
    player:setUnityLeader(leader)
end

local function getChangeUnityCost(player, selection)
    local currentRank = player:getUnityRank()
    local newRank = player:getUnityRank(selection)
    local changeCost = (500 * (11 - newRank)) - ((11 - currentRank) * 400)

    if changeCost < 100 then
        changeCost = 100
    end

    return changeCost
end

function xi.unity.onTrade(player, npc, trade, eventid)
end

function xi.unity.onTrigger(player, npc)
    local zoneId = player:getZoneID()
    local hasAllForOne = player:hasEminenceRecord(5)
    local allForOneCompleted = player:getEminenceCompleted(5)
    local accolades = player:getCurrency("unity_accolades")
    local remainingLimit = WEEKLY_EXCHANGE_LIMIT - player:getCharVar("weekly_accolades_spent")
    utils.unused(remainingLimit)

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
        player:startEvent(zoneEventIds[zoneId][4], 0, player:getUnityLeader(), accolades, 0, 0, 0, 0, 0)
    end
end

function xi.unity.onEventUpdate(player, csid, option)
    local zoneId = player:getZoneID()
    local ID = require(string.format("scripts/zones/%s/IDs", zoneEventIds[zoneId][5]))
    local accolades = player:getCurrency("unity_accolades")
    local weeklyAccoladesSpent = player:getCharVar("weekly_sparks_spent")
    local remainingLimit = WEEKLY_EXCHANGE_LIMIT - player:getCharVar("weekly_accolades_spent")
    local category  = bit.band(option, 0xF)
    local selection = bit.band(bit.rshift(option, 5), 0xFF)

    if option == 10 then
        player:updateEvent(0, 0, 0, remainingLimit, 0, 0, 0, 0)

    -- Item Selected, enter amount/confirm
    elseif category == 3 then
        player:updateEvent(unityOptions[4][selection][2], unityOptions[4][selection][3], 0, 0, 0, 0, 0, player:getUnityLeader())

    -- Attempt to grant the Item selected
    elseif category == 4 then
        local qty = bit.rshift(option, 13)
        local itemId = unityOptions[category][selection][1]
        local cost = unityOptions[category][selection][4] * qty

        if npcUtil.giveItem(player, { {itemId, qty} }) then
            accolades = accolades - cost
            player:delCurrency("unity_accolades", cost)
            if ENABLE_EXCHANGE_LIMIT == 1 then
                remainingLimit = remainingLimit - cost
                player:setCharVar("weekly_accolades_spent", weeklyAccoladesSpent + cost)
            end

            player:updateEvent(itemId, qty, accolades, remainingLimit, 0, 0, 0, player:getUnityLeader())
        else
            player:updateEvent(utils.MAX_UINT32)
        end

    -- Change Unity
    elseif category == 5 then
        if player:getCharVar("unity_changed") == 1 then
            player:updateEvent(utils.MAX_UINT32)
            player:messageSpecial(ID.text.HAVE_ALREADY_CHANGED_UNITY, option)
        else
            local changeUnityCost = getChangeUnityCost(player, selection)
            player:updateEvent(changeUnityCost, changeUnityCost)
        end
    end
end

function xi.unity.onEventFinish(player, csid, option)
    local zoneId = player:getZoneID()
    local ID = require(string.format("scripts/zones/%s/IDs", zoneEventIds[zoneId][5]))
    local category  = bit.band(option, 0x1F)
    local selection = bit.rshift(option, 5) -- This may need tuning for other menu options

    -- First time joining Unity (Requirements met for num Objectives and All for One set)
    if csid == zoneEventIds[zoneId][3] and option >= 1 and option <= 11 then
        changeUnityLeader(player, option)
        xi.roe.onRecordTrigger(player, 5)
        player:messageSpecial(ID.text.YOU_HAVE_JOINED_UNITY, option - 1)

    -- Player is a member of a Unity
    elseif csid == zoneEventIds[zoneId][4] then

        -- Unity Warp
        if category == 1 and unityOptions[category][selection] ~= nil then
            player:delCurrency("unity_accolades", 100)
            player:setPos(unpack(unityOptions[category][selection]))

        -- Change Unity
        elseif category == 6 then
            local newUnityLeader = bit.band(selection, 0xF)

            player:delCurrency("unity_accolades", getChangeUnityCost(player, newUnityLeader))
            changeUnityLeader(player, newUnityLeader)
            player:messageSpecial(ID.text.YOU_HAVE_JOINED_UNITY, newUnityLeader - 1)
        end
    end
end
