-- ----------------------------------
-- Egg Hunt Egg-Stravaganza
-- ----------------------------------
require("scripts/globals/utils")
require("scripts/globals/npc_util")
-- ----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.egg_hunt = xi.events.egg_hunt or {}
xi.events.egg_hunt.data = xi.events.egg_hunt.data or {}
xi.events.egg_hunt.entities = xi.events.egg_hunt.entities or {}

local event = SeasonalEvent:new("egg_hunt")

-- Default settings
local settings =
{
    START  = { DAY   =  6, MONTH = 4 },
    FINISH = { DAY   = 17, MONTH = 4 },

    VAR =
    {
        DAILY_EGG     = "[EGGHUNT]DAILY_EGG",
        DAILY_REWARD  = "[EGGHUNT]DAILY_REWARD",
        DAILY_BONUS   = "[EGGHUNT]DAILY_BONUS",
        DAILY_HELM    = "[EGGHUNT]DAILY_HELM",
        INITIAL_THREE = "[EGGHUNT]INITIAL_THREE",
    },

    -- Default allows additional eras to be added each year
    ERA_2007 = false, -- Jeweled Egg and Egg Helm
    ERA_2008 = false, -- Tier 2 nation eggs
    ERA_2009 = false, -- Egg Buffet set

    -- Consolation prizes for repeating combinations where
    -- the player has already received the relevant reward
    MINOR_REWARDS = true,

    -- Don't add words here
    -- settings/main.lua will overwrite these
    -----------------------------------------------
    -- Set custom combinations, eg. WORD = 1234
    -- Where WORD is an arrangement of lettered eggs
    -- Where 1234 is the itemID for the reward
    BONUS_WORDS = {},
}

local function loadSettings(tbl, name)
    if not xi.settings.main[name] then
        return
    end

    for k, v in pairs(tbl) do
        if xi.settings.main[name][k] then
            tbl[k] = xi.settings.main[name][k]
        end
    end
end

loadSettings(settings, "EGG_HUNT")

xi.events.egg_hunt.enabledCheck = function()
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))

    if month == settings.START.MONTH then
        if day >= settings.START.DAY then
            return true
        end

    elseif month == settings.FINISH.MONTH then
        if day <= settings.FINISH.DAY then
            return true
        end
    end

    return false
end

event:setEnableCheck(xi.events.egg_hunt.enabledCheck)

-- ----------------------------------
-- Data
-- ----------------------------------

xi.events.egg_hunt.data =
{
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        id = 17719704,
        cs = 872,
        message =
        {
            REWARD1 = 7402, -- Egg-cellent! Here's your prize, kupo!
            REWARD2 = 7403, -- Egg-straordinary! Here's your special prize, kupo!
            REWARD3 = 7404, -- How in-eggs-plicably astounding!
            WAITING = 7405, -- Hey, don't get all egg-cited! You can only claim one prize a day, kupo!
            HINTING = 7406, -- These initial eggs are really egg-spensive, kupo!
            TRADE1  = 7407, -- Eggs-actly what I wanted! Here's your reward, kupo!
            TRADE2  = 7408, -- Ku-kupo! Such an egg-stravagant item, for little old me?
            TRADE3  = 7409, -- My eyes! My eyes! Get out of here, and take those egg-ceptionally nasty things with you, kupo!
            TRADE4  = 7410, -- Kupo... Kupo～～～! Please! No more, kupo! Here, take these
            DELAY   = 7411, -- Hey, I can only trade with you once a day.
            HELP    = 7412, -- Hey, you look new here, kupo!
            REWARD4 = 7413, -- Heh heh heh... I have something egg-specially egg-citing
        },
        decorations =
        {
            { 224,  -99.972,  1.000, -57.257, "0x00006B0500000000000000000000000000000000", },
            { 224, -113.320,  1.000, -43.947, "0x00006B0500000000000000000000000000000000", },
            { 160,  113.326,  1.000, -43.947, "0x00006B0500000000000000000000000000000000", },
            { 160,   99.882,  1.000, -57.257, "0x00006B0500000000000000000000000000000000", },
            {  96,  144.679, -2.000, 120.889, "0x00006B0500000000000000000000000000000000", },
            {  96,  152.904, -2.000, 112.697, "0x00006B0500000000000000000000000000000000", },
            {  95,  143.780, -2.000, 119.940, "0x01001E0382116F20173017401750006000700000", },
            {  95,  151.890, -2.000, 111.800, "0x01001E0482116F20173017401750006000700000", },
            { 160,  112.000,  1.000, -42.600, "0x01001E0582116F20173017401750006000700000", },
            { 160,   98.600,  1.000, -56.000, "0x01001E0682116F20173017401750006000700000", },
            { 224,  -98.640,  1.000, -55.940, "0x01001E0782116F20173017401750006000700000", },
            { 224, -112.000,  1.000, -42.600, "0x01001E0882116F20173017401750006000700000", },
        },
    },

    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        id = 17723702,
        cs = 832,
        message =
        {
            REWARD1 = 13102, -- Egg-cellent! Here's your prize, kupo!
            REWARD2 = 13103, -- Egg-straordinary! Here's your special prize, kupo!
            REWARD3 = 13104, -- How in-eggs-plicably astounding!
            WAITING = 13105, -- Hey, don't get all egg-cited! You can only claim one prize a day, kupo!
            HINTING = 13106, -- These initial eggs are really egg-spensive, kupo!
            TRADE1  = 13107, -- Eggs-actly what I wanted! Here's your reward, kupo!
            TRADE2  = 13108, -- Ku-kupo! Such an egg-stravagant item, for little old me?
            TRADE3  = 13109, -- My eyes! My eyes! Get out of here, and take those egg-ceptionally nasty things with you, kupo!
            TRADE4  = 13110, -- Kupo... Kupo～～～! Please! No more, kupo! Here, take these
            DELAY   = 13111, -- Hey, I can only trade with you once a day.
            HELP    = 13112, -- Hey, you look new here, kupo!
            REWARD4 = 13113, -- Heh heh heh... I have something egg-specially egg-citing
        },
        decorations =
        {
            { 163,   87.834, 0.000,  8.015, "0x00006B0500000000000000000000000000000000", },
            { 163,   84.074, 0.000,  4.233, "0x00006B0500000000000000000000000000000000", },
            {   0, -245.045, 7.999, 34.350, "0x00006B0500000000000000000000000000000000", },
            {   0, -245.045, 7.999, 53.650, "0x00006B0500000000000000000000000000000000", },
            {   0, -243.800, 8.000, 33.500, "0x01001E0182116F20173017401750006000700000", },
            {   0, -243.800, 8.000, 35.000, "0x01001E0282116F20173017401750006000700000", },
            {   0, -243.800, 8.000, 52.800, "0x01001E0382116F20173017401750006000700000", },
            {   0, -243.800, 8.000, 54.300, "0x01001E0482116F20173017401750006000700000", },
            { 160,   83.100, 0.000,  5.200, "0x01001E0582116F20173017401750006000700000", },
        },
    },

    [xi.zone.BASTOK_MINES] =
    {
        id = 17735920,
        cs = 561,
        message =
        {
            REWARD1 = 11940, -- Egg-cellent! Here's your prize, kupo!
            REWARD2 = 11941, -- Egg-straordinary! Here's your special prize, kupo!
            REWARD3 = 11942, -- How in-eggs-plicably astounding!
            WAITING = 11943, -- Hey, don't get all egg-cited! You can only claim one prize a day, kupo!
            HINTING = 11944, -- These initial eggs are really egg-spensive, kupo!
            TRADE1  = 11945, -- Eggs-actly what I wanted! Here's your reward, kupo!
            TRADE2  = 11946, -- Ku-kupo! Such an egg-stravagant item, for little old me?
            TRADE3  = 11947, -- My eyes! My eyes! Get out of here, and take those egg-ceptionally nasty things with you, kupo!
            TRADE4  = 11948, -- Kupo... Kupo～～～! Please! No more, kupo! Here, take these
            DELAY   = 11949, -- Hey, I can only trade with you once a day.
            HELP    = 11950, -- Hey, you look new here, kupo!
            REWARD4 = 11951, -- Heh heh heh... I have something egg-specially egg-citing
        },
        decorations =
        {
            { 192, -10.200, -1.000, -127.100, "0x00006C0500000000000000000000000000000000", },
            { 192, -21.800, -1.000, -127.100, "0x00006C0500000000000000000000000000000000", },
            { 128,  82.000,  0.000,  -66.700, "0x00006C0500000000000000000000000000000000", },
            { 128,  82.000,  0.000,  -77.300, "0x00006C0500000000000000000000000000000000", },
            { 127,  80.500,  0.000,  -66.700, "0x01001E0182117120173017401750006000700000", },
            { 127,  80.500,  0.000,  -77.300, "0x01001E0282117120173017401750006000700000", },
            { 192, -10.250, -1.000, -125.900, "0x01001E0382117120173017401750006000700000", },
            { 192, -21.800, -1.000, -125.900, "0x01001E0482117120173017401750006000700000", },
        },
    },

    [xi.zone.BASTOK_MARKETS] =
    {
        id = 17740005,
        cs = 467,
        message =
        {
            REWARD1 = 8296, -- Egg-cellent! Here's your prize, kupo!
            REWARD2 = 8297, -- Egg-straordinary! Here's your special prize, kupo!
            REWARD3 = 8298, -- How in-eggs-plicably astounding!
            WAITING = 8299, -- Hey, don't get all egg-cited! You can only claim one prize a day, kupo!
            HINTING = 8300, -- These initial eggs are really egg-spensive, kupo!
            TRADE1  = 8301, -- Eggs-actly what I wanted! Here's your reward, kupo!
            TRADE2  = 8302, -- Ku-kupo! Such an egg-stravagant item, for little old me?
            TRADE3  = 8303, -- My eyes! My eyes! Get out of here, and take those egg-ceptionally nasty things with you, kupo!
            TRADE4  = 8304, -- Kupo... Kupo～～～! Please! No more, kupo! Here, take these
            DELAY   = 8305, -- Hey, I can only trade with you once a day.
            HELP    = 8306, -- Hey, you look new here, kupo!
            REWARD4 = 8307, -- Heh heh heh... I have something egg-specially egg-citing
        },
        decorations =
        {
            { 128, -153.700,  -4.000,   33.000, "0x00006C0500000000000000000000000000000000", },
            { 128, -153.700,  -4.000,   27.000, "0x00006C0500000000000000000000000000000000", },
            { 128, -153.700,  -4.000,  -27.000, "0x00006C0500000000000000000000000000000000", },
            { 128, -153.700,  -4.000,  -33.000, "0x00006C0500000000000000000000000000000000", },
            { 224, -362.004, -10.002, -173.953, "0x00006C0500000000000000000000000000000000", },
            { 224, -353.928, -10.002, -182.068, "0x00006C0500000000000000000000000000000000", },
            { 224, -353.000, -10.000, -181.080, "0x01001E0582117120173017401750006000700000", },
            { 224, -360.900, -10.000, -173.000, "0x01001E0682117120173017401750006000700000", },
            { 127, -155.000,  -4.000,   33.000, "0x01001E0782117120173017401750006000700000", },
            { 127, -155.000,  -4.000,   27.000, "0x01001E0882117120173017401750006000700000", },
        },
    },

    [xi.zone.WINDURST_WATERS] =
    {
        id = 17752413,
        cs = 969,
        message =
        {
            REWARD1 = 10193, -- Egg-cellent! Here's your prize, kupo!
            REWARD2 = 10194, -- Egg-straordinary! Here's your special prize, kupo!
            REWARD3 = 10195, -- How in-eggs-plicably astounding!
            WAITING = 10196, -- Hey, don't get all egg-cited! You can only claim one prize a day, kupo!
            HINTING = 10197, -- These initial eggs are really egg-spensive, kupo!
            TRADE1  = 10198, -- Eggs-actly what I wanted! Here's your reward, kupo!
            TRADE2  = 10199, -- Ku-kupo! Such an egg-stravagant item, for little old me?
            TRADE3  = 10200, -- My eyes! My eyes! Get out of here, and take those egg-ceptionally nasty things with you, kupo!
            TRADE4  = 10201, -- Kupo... Kupo～～～! Please! No more, kupo! Here, take these
            DELAY   = 10202, -- Hey, I can only trade with you once a day.
            HELP    = 10203, -- Hey, you look new here, kupo!
            REWARD4 = 10204, -- Heh heh heh... I have something egg-specially egg-citing
        },
        decorations =
        {
            { 192, 164.500, -0.250, -30.000, "0x00006D0500000000000000000000000000000000", },
            { 192, 155.500, -0.250, -30.000, "0x00006D0500000000000000000000000000000000", },
            {  64, -46.800, -4.916, 227.570, "0x00006D0500000000000000000000000000000000", },
            {  64, -33.200, -4.982, 227.570, "0x00006D0500000000000000000000000000000000", },
            { 192, 165.000, -0.250, -28.800, "0x01001E0582117020173017401750006000700000", },
            { 192, 164.000, -0.250, -28.800, "0x01001E0682117020173017401750006000700000", },
            { 192, 155.500, -0.250, -28.800, "0x01001E0782117020173017401750006000700000", },
            {  63, -46.800, -4.900, 226.220, "0x01001E0882117020173017401750006000700000", },
            {  63, -33.200, -4.900, 226.220, "0x01001E0182117020173017401750006000700000", },
        },
    },

    [xi.zone.WINDURST_WOODS] =
    {
        id = 17764682,
        cs = 785,
        message =
        {
            REWARD1 = 9783, -- Egg-cellent! Here's your prize, kupo!
            REWARD2 = 9784, -- Egg-straordinary! Here's your special prize, kupo!
            REWARD3 = 9785, -- How in-eggs-plicably astounding!
            WAITING = 9786, -- Hey, don't get all egg-cited! You can only claim one prize a day, kupo!
            HINTING = 9787, -- These initial eggs are really egg-spensive, kupo!
            TRADE1  = 9788, -- Eggs-actly what I wanted! Here's your reward, kupo!
            TRADE2  = 9789, -- Ku-kupo! Such an egg-stravagant item, for little old me?
            TRADE3  = 9790, -- My eyes! My eyes! Get out of here, and take those egg-ceptionally nasty things with you, kupo!
            TRADE4  = 9791, -- Kupo... Kupo～～～! Please! No more, kupo! Here, take these
            DELAY   = 9792, -- Hey, I can only trade with you once a day.
            HELP    = 9793, -- Hey, you look new here, kupo!
            REWARD4 = 9794, -- Heh heh heh... I have something egg-specially egg-citing
        },
        decorations =
        {
            { 128,  107.630, -5.000, -33.200, "0x00006D0500000000000000000000000000000000", },
            { 128,  107.630, -5.000, -46.800, "0x00006D0500000000000000000000000000000000", },
            {   0, -107.000, -5.250,  35.500, "0x00006D0500000000000000000000000000000000", },
            {   0, -107.000, -5.250,  44.500, "0x00006D0500000000000000000000000000000000", },
            {   0, -105.500, -5.250,  35.500, "0x01001E0282117020173017401750006000700000", },
            {   0, -105.500, -5.250,  44.500, "0x01001E0782117020173017401750006000700000", },
            { 127,  106.500, -5.000, -33.200, "0x01001E0382117020173017401750006000700000", },
            { 127,  106.500, -5.000, -46.800, "0x01001E0482117020173017401750006000700000", },
            { 127, -155.000, -4.000, -27.000, "0x01001E0100107120173017401750006000700000", },
            { 127, -155.000, -4.000, -33.000, "0x01001E0282117120173017401750006000700000", },
        },
    },
}

-- ----------------------------------
-- Helpers
-- ----------------------------------

xi.events.egg_hunt.charToEgg = function(char)
    local letter = string.byte(string.lower(char)) - 97
    return xi.items.A_EGG + letter
end

xi.events.egg_hunt.eggInList = function(eggs, egg)
    for j = 1, #eggs do
        if eggs[j] and eggs[j][1] == egg then
            return j
        end
    end

    return -1
end

xi.events.egg_hunt.stringToEggs = function(text)
    local str = string.lower(text)
    local eggs = {}

    for i = 1, #str do
        local letter = string.byte(string.sub(str, i, i))
        local egg = xi.items.A_EGG + (letter - 97)
        local pos = xi.events.egg_hunt.eggInList(eggs, egg)

        if pos > -1 then
            eggs[pos][2] = eggs[pos][2] + 1
        else
            table.insert(eggs, { egg, 1 })
        end
    end

    return eggs
end

local hasInitialThree = function(player)
    return (
        player:getVar(settings.VAR.INITIAL_THREE) == 1 or
        player:hasItem(xi.items.EGG_HELM)
    )
end

-- ----------------------------------
-- Combos
-- ----------------------------------

local minorRewards =
{
    xi.items.CHOCOBO_TICKET,
    xi.items.RED_DROP,
    xi.items.YELLOW_DROP,
    xi.items.BLUE_DROP,
    xi.items.GREEN_DROP,
    xi.items.CLEAR_DROP,
    xi.items.PURPLE_DROP,
    xi.items.WHITE_DROP,
    xi.items.BLACK_DROP,
}

local minorReward = function()
    return minorRewards[math.random(#minorRewards)]
end

local tradeIn = function(player, npc, trade, zoneID)
    local reward = {}

    if
        npcUtil.tradeHasExactly(trade, { { xi.items.BIRD_EGG, 12 } }) or
        npcUtil.tradeHasExactly(trade, { { xi.items.LIZARD_EGG, 6 } }) or
        npcUtil.tradeHasExactly(trade, xi.items.SOFT_BOILED_EGG) or
        npcUtil.tradeHasExactly(trade, xi.items.COLORED_EGG)
    then
        table.insert(reward, math.random(xi.items.A_EGG, xi.items.Z_EGG))
    end

    if npcUtil.tradeHasExactly(trade, xi.items.PARTY_EGG) then
        table.insert(reward, math.random(xi.items.A_EGG, xi.items.Z_EGG))
        table.insert(reward, math.random(xi.items.A_EGG, xi.items.Z_EGG))
    end

    if npcUtil.tradeHasExactly(trade, xi.items.LUCKY_EGG) then
        table.insert(reward, math.random(xi.items.A_EGG, xi.items.Z_EGG))
        table.insert(reward, math.random(xi.items.A_EGG, xi.items.Z_EGG))
        table.insert(reward, math.random(xi.items.A_EGG, xi.items.Z_EGG))
    end

    if #reward > 0 then
        if player:getVar(settings.VAR.DAILY_BONUS) >= vanaDay() then
            player:messageText(npc, xi.events.egg_hunt.data[zoneID].message.DELAY)
            return true
        end

        if #reward >= 3 then
            player:messageText(npc, xi.events.egg_hunt.data[zoneID].message.TRADE2)
        else
            player:messageText(npc, xi.events.egg_hunt.data[zoneID].message.TRADE1)
        end

        if npcUtil.giveItem(player, reward) then
            player:confirmTrade()
            player:setVar(settings.VAR.DAILY_BONUS, vanaDay())
        else
            player:tradeComplete(false)
        end

        return true
    end

    return false
end

local firstThree = function(player, npc, trade)
    local charName = player:getName()

    if
        npcUtil.tradeHasExactly(trade, {
            xi.events.egg_hunt.charToEgg(string.sub(charName, 1, 1)),
            xi.events.egg_hunt.charToEgg(string.sub(charName, 2, 2)),
            xi.events.egg_hunt.charToEgg(string.sub(charName, 3, 3)),
        })
    then
        -- if not 2007, or player already has Egg Helm,.minor reward is issued instead
        if settings.ERA_2007 and not player:hasItem(xi.items.EGG_HELM) then
            player:setVar(settings.VAR.INITIAL_THREE, 1)
            return xi.items.EGG_HELM
        end

        player:setVar(settings.VAR.INITIAL_THREE, 1)
        return minorReward()
    end
end

local sevenKind = function(player, npc, trade)
    -- Initial three required first
    if not hasInitialThree(player) then
        return
    end

    for i = 0, 26 do
        if npcUtil.tradeHasExactly(trade, { { xi.items.A_EGG + i, 7 } }) then
            if not player:hasItem(xi.items.FORTUNE_EGG) then
                return xi.items.FORTUNE_EGG
            end

            if settings.MINOR_REWARDS then
                return minorReward()
            end

            return
        end
    end
end

local straightEight = function(player, npc, trade)
    -- Initial three required first
    if not hasInitialThree(player) then
        return
    end

    local initial = string.lower(string.sub(player:getName(), 1, 1))        -- eg. "a"
    local letter = string.byte(initial) - 97 + xi.items.A_EGG -- itemID
    local eggs = {}

    for i = 1, 8 do
        table.insert(eggs, letter)
        letter = letter + 1

        if letter > xi.items.Z_EGG then
            letter = xi.items.A_EGG
        end
    end

    if npcUtil.tradeHasExactly(trade, eggs) then
        if not player:hasItem(xi.items.HAPPY_EGG) then
            return xi.items.HAPPY_EGG
        end

        if settings.MINOR_REWARDS then
            return minorReward()
        end
    end
end

local regionNames =
{
    xi.events.egg_hunt.stringToEggs("RONFA"),
    xi.events.egg_hunt.stringToEggs("ZULKH"),
    xi.events.egg_hunt.stringToEggs("NORVA"),
    xi.events.egg_hunt.stringToEggs("GUSTA"),
    xi.events.egg_hunt.stringToEggs("DERFL"),
    xi.events.egg_hunt.stringToEggs("SARUT"),
    xi.events.egg_hunt.stringToEggs("KOLSH"),
    xi.events.egg_hunt.stringToEggs("ARAGO"),
    xi.events.egg_hunt.stringToEggs("FAURE"),
    xi.events.egg_hunt.stringToEggs("VALDE"),
    xi.events.egg_hunt.stringToEggs("QUFIM"),
    xi.events.egg_hunt.stringToEggs("LITEL"),
    xi.events.egg_hunt.stringToEggs("KUZOT"),
    xi.events.egg_hunt.stringToEggs("VOLLB"),
    xi.events.egg_hunt.stringToEggs("ELSHI"),
    xi.events.egg_hunt.stringToEggs("ELSHI"),
    xi.events.egg_hunt.stringToEggs("TULIA"),
    xi.events.egg_hunt.stringToEggs("MOVAL"),
    xi.events.egg_hunt.stringToEggs("TAVNA"),
}

local beastCostumes =
{
    580, -- Yagudo
    612, -- Orc
    644, -- Quadav
}

local nationRewards =
{
    { xi.items.WING_EGG,   xi.items.MELODIUS_EGG,  xi.items.EGG_STOOL, },
    { xi.items.LAMP_EGG,   xi.items.CLOCKWORK_EGG, xi.items.EGG_TABLE, },
    { xi.items.FLOWER_EGG, xi.items.HATCHLING_EGG, xi.items.EGG_LOCKER, },
}

local regionControl = function(player, npc, trade)
    -- Initial three required first
    if not hasInitialThree(player) then
        return
    end

    for k, v in pairs(regionNames) do
        if npcUtil.tradeHasExactly(trade, v) then
            local owner = GetRegionOwner(k - 1)

            -- Beastmen controlled
            if owner == 3 then
                local costume = beastCostumes[math.random(#beastCostumes)]
                player:addStatusEffect(xi.effect.COSTUME, costume, 0, 300)
                player:tradeComplete()

                return
            else
                local reward = nationRewards[owner + 1]

                if not player:hasItem(reward[1]) then
                    return reward[1]

                elseif
                    settings.ERA_2008 and
                    not player:hasItem(reward[2])
                then
                    return reward[2]

                elseif settings.ERA_2009 then
                    if not player:hasItem(reward[3]) then
                        return reward[3]
                    elseif not player:hasItem(xi.items.EGG_LANTERN) then
                        return xi.items.EGG_LANTERN
                    elseif settings.MINOR_REWARDS then
                        return minorReward()
                    end

                elseif
                    settings.ERA_2007 and
                    not player:hasItem(xi.items.JEWELED_EGG)
                then
                    return xi.items.JEWELED_EGG
                end

                if settings.MINOR_REWARDS then
                    return minorReward()
                end
            end
        end
    end
end

local elementNames =
{
    { xi.events.egg_hunt.stringToEggs("FIRE"),    xi.items.RED_DROP    },
    { xi.events.egg_hunt.stringToEggs("ICE"),     xi.items.CLEAR_DROP  },
    { xi.events.egg_hunt.stringToEggs("AIR"),     xi.items.GREEN_DROP  },
    { xi.events.egg_hunt.stringToEggs("EARTH"),   xi.items.YELLOW_DROP },
    { xi.events.egg_hunt.stringToEggs("THUNDER"), xi.items.PURPLE_DROP },
    { xi.events.egg_hunt.stringToEggs("WATER"),   xi.items.BLUE_DROP   },
    { xi.events.egg_hunt.stringToEggs("LIGHT"),   xi.items.WHITE_DROP  },
    { xi.events.egg_hunt.stringToEggs("DARK"),    xi.items.BLACK_DROP  },
}

local weekDay = function(player, npc, trade)
    -- Initial three required first
    if not hasInitialThree(player) then
        return
    end

    local elementDay = elementNames[VanadielDayElement()]

    if npcUtil.tradeHasExactly(trade, elementDay[1]) then
        if player:hasItem(xi.items.ORPHIC_EGG) then
            return elementDay[2] -- Colored Drop
        else
            return xi.items.ORPHIC_EGG
        end
    end
end

local getSecondInitial = function(player, option)
    local party = player:getParty()

    for i = 1, #party do
        if
            party[i]           ~= nil and                -- Player exists
            player:getName()   ~= party[i]:getName() and -- Different player
            player:getZoneID() == party[i]:getZoneID()   -- Same zone
        then
            local playerName   = party[i]:getName()
            local initial      = string.sub(playerName, 1, 1)
            local firstLetter  = string.byte(string.lower(initial)) - 97
            local second       = string.sub(playerName, 2, 2)
            local secondLetter = string.byte(string.lower(second)) - 97

            if
                firstLetter == (option - 3) and
                party[i]:getEquipID(xi.slot.HEAD) == xi.items.EGG_HELM
            then
                return xi.items.A_EGG + secondLetter
            end
        end
    end

    return 0
end

xi.events.egg_hunt.combos =
{
    { check = firstThree,    message = "REWARD1", daily = true },
    { check = sevenKind,     message = "REWARD2", daily = true },
    { check = straightEight, message = "REWARD2", daily = true },
    { check = regionControl, message = "REWARD2", daily = true },
    { check = weekDay,       message = "REWARD2", daily = true },
}

for k, v in pairs(settings.BONUS_WORDS) do
    local customEggs = xi.events.egg_hunt.stringToEggs(k)

    table.insert(xi.events.egg_hunt.combos,
    {
        check = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, customEggs) then
                return v
            end
        end,

        message = "REWARD2",
        daily = true,
    })
end

-- ----------------------------------
-- Moogle event handlers
-- ----------------------------------

xi.events.egg_hunt.onTrigger = function(player, npc)
    local zoneID = player:getZoneID()

    if player:getVar(settings.VAR.DAILY_EGG) >= vanaDay() then
        player:messageText(npc, xi.events.egg_hunt.data[zoneID].message.HINTING)
    else
        local party = player:getParty()
        local options = -1

        for i = 1, #party do
            if
                party[i]           ~= nil and                -- Player exists
                player:getName()   ~= party[i]:getName() and -- Different player
                player:getZoneID() == party[i]:getZoneID()   -- Same zone
            then
                local initial = string.sub(party[i]:getName(), 1, 1)
                local letter = string.byte(string.lower(initial)) - 97
                options = utils.mask.setBit(options, letter, 0)
            end
        end

        if options ~= -1 then
            options = utils.mask.setBit(options, 26, 0)
            player:startEvent(xi.events.egg_hunt.data[zoneID].cs, 3, options)
        else
            player:startEvent(xi.events.egg_hunt.data[zoneID].cs, 1)
        end
    end
end

xi.events.egg_hunt.onEventFinish = function(player, csid, option)
    local zoneID = player:getZoneID()
    local ID = zones[zoneID]

    -- "Forget it." or out of range
    if option > 28 then
        return

    -- Selected party member initial
    elseif option >= 3 then
        local eggsGiven = { xi.items.A_EGG + option - 3 }
        local second = getSecondInitial(player, option)

        -- Give second letter if selected player has Egg Helm equipped
        if second > 0 then
            table.insert(eggsGiven, second)
        end

        if npcUtil.giveItem(player, eggsGiven) then
            player:setVar(settings.VAR.DAILY_EGG, vanaDay())
        end

    -- Random daily letter
    else
        if npcUtil.giveItem(player, math.random(xi.items.A_EGG, xi.items.Z_EGG)) then
            player:setVar(settings.VAR.DAILY_EGG, vanaDay())
        end
    end
end

xi.events.egg_hunt.onTrade = function(player, npc, trade)
    local zoneID = player:getZoneID()

    if tradeIn(player, npc, trade, zoneID) then
        return
    end

    for _, v in pairs(xi.events.egg_hunt.combos) do
        local reward = v.check(player, npc, trade)
        if reward then
            -- If reward already received today, send message and skip everything else
            if
                v.daily and
                player:getVar(settings.VAR.DAILY_REWARD) >= vanaDay()
            then
                player:messageText(npc, xi.events.egg_hunt.data[zoneID].message.WAITING)
                player:tradeComplete(false)
                return
            end

            -- If reward message is set, attempt to use messageText, if not use custom text
            if v.message ~= nil then
                if xi.events.egg_hunt.data[zoneID].message[v.message] then
                    player:messageText(npc, xi.events.egg_hunt.data[zoneID].message[v.message])
                else
                    player:PrintToPlayer(string.format("Moogle : %s", v.message), xi.msg.channel.NS_SAY, "Moogle")
                end
            end

            -- Attempt to give item
            if npcUtil.giveItem(player, reward) then
                player:confirmTrade()

                -- One reward per day (If true)
                if v.daily then
                    player:setVar(settings.VAR.DAILY_REWARD, vanaDay())
                end

                -- Call "after" function if it exists
                if v.after then
                    v.after(player, npc, trade)
                end
            else
                player:tradeComplete(false)
            end

            return
        end
    end

    player:tradeComplete(false)
end

-- ----------------------------------
-- Show/hide Moogles and decorations
-- ----------------------------------

xi.events.egg_hunt.showMoogle = function(data)
    local moogle = GetNPCByID(data.id)
    if moogle then
        moogle:setStatus(xi.status.NORMAL)
    end
end

xi.events.egg_hunt.hideMoogles = function()
    for zoneId, data in pairs(xi.events.egg_hunt.data) do
        local zone = GetZone(zoneId)
        if zone then
            local moogle = GetNPCByID(data.id)
            if moogle then
                moogle:setStatus(xi.status.DISAPPEAR)
            end
        end
    end
end

xi.events.egg_hunt.generateEntities = function()
    for zoneId, data in pairs(xi.events.egg_hunt.data) do
        local zone = GetZone(zoneId)
        if zone then
            xi.events.egg_hunt.showMoogle(data)

            for _, entry in pairs(data.decorations) do
                local rot  = entry[1]
                local x    = entry[2]
                local y    = entry[3]
                local z    = entry[4]
                local look = entry[5]

                local npc = zone:insertDynamicEntity({
                    objtype = xi.objType.NPC,
                    name = "     ",
                    look = look,
                    x = x,
                    y = y,
                    z = z,
                    rotation = rot,
                    widescan = 0,
                    entityFlags = 2075,
                    namevis = 64,
                    releaseIdOnDisappear = true,
                })

                table.insert(xi.events.egg_hunt.entities, npc:getID())
            end
        end
    end
end

xi.events.egg_hunt.showEntities = function(enabled)
    if enabled and #xi.events.egg_hunt.entities == 0 then
        xi.events.egg_hunt.generateEntities()
    end

    for _, entityID in pairs(xi.events.egg_hunt.entities) do
        local entity = GetNPCByID(entityID)
        if entity then
            if enabled then
                entity:setStatus(xi.status.NORMAL)
            else
                entity:setStatus(xi.status.INVISIBLE)
            end
        end
    end

    if not enabled then
        xi.events.egg_hunt.entities = {}
        xi.events.egg_hunt.hideMoogles()
    end
end

event:setStartFunction(function()
    xi.events.egg_hunt.showEntities(true)
end)

event:setEndFunction(function()
    xi.events.egg_hunt.showEntities(false)
end)

return event
