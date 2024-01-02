-----------------------------------
-- Egg Hunt Egg-Stravaganza
-----------------------------------
-- Southern San d'Oria !pos 56.195 1.999 -25.207 230
-- Northern San d'Oria !pos -224.135 8.000 53.476 231
-- Bastok Mines        !pos -33.600 -0.001 -110.000 234
-- Bastok Markets      !pos -260.440 -12.021 -79.538 235
-- Windurst Waters     !pos -55.470 -5.391 216.362 238
-- Windurst Woods      !pos 104.823 -5.000 -55.745 241
-----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.eggHunt = xi.events.eggHunt or {}
xi.events.eggHunt.data = xi.events.eggHunt.data or {}
xi.events.eggHunt.entities = xi.events.eggHunt.entities or {}

local event = SeasonalEvent:new('egg_hunt')

-- Default settings
local settings =
{
    ANNOUNCE = false, -- Announce settings on load
    START  = { DAY   =  6, MONTH = 4 },
    FINISH = { DAY   = 17, MONTH = 4 },

    VAR =
    {
        DAILY_EGG     = '[EGG_HUNT]DAILY_EGG',
        DAILY_REWARD  = '[EGG_HUNT]DAILY_REWARD',
        DAILY_BONUS   = '[EGG_HUNT]DAILY_BONUS',
        DAILY_HELM    = '[EGG_HUNT]DAILY_HELM',
        FIRST_THREE   = '[EGG_HUNT]FIRST_THREE',
    },

    -- Default era is 2005
    ERA_2006 = false, -- Orphic Egg
    ERA_2007 = false, -- Jeweled Egg and Egg Helm
    ERA_2008 = false, -- Tier 2 nation eggs, allows trading Hard-Boiled Eggs
    ERA_2009 = false, -- Egg Buffet set
    -- 2009, 2010, 2011 and 2012 are identical
    ERA_2013 = false, -- Prinseggstarta
    ERA_2014 = false, -- Hatchling Shield, Copse Candy, Cracker
    ERA_2015 = false, -- Rabbit Cap, show Rabbit Cap wearing NPCs
    ERA_2018 = false, -- Allows trading Sairui-Ran x99 and Imperial Egg
    ERA_2019 = false, -- Allows trading Apkallu Egg

    -- Consolation prizes for repeating combinations where
    -- the player has already received the relevant reward
    MINOR_REWARDS = true,

    -- Don't add words here
    -- settings/main.lua will overwrite these
    BONUS_WORDS = {},
}

local function loadSettings(currentTable, settingsName)
    local settingTable = xi.settings.main[settingsName]

    if not settingTable then
        if currentTable.ANNOUNCE then
            print('[EggHunt] No settings in main.lua, using default')
        end

        return
    else
        if currentTable.ANNOUNCE then
            print('[EggHunt] Loading settings from main.lua')
        end
    end

    -- Load from main settings into current table
    for settingName, _ in pairs(currentTable) do
        if settingTable[settingName] then
            currentTable[settingName] = settingTable[settingName]
        end
    end
end

loadSettings(settings, 'EGG_HUNT')

xi.events.eggHunt.enabledCheck = function()
    local month = tonumber(os.date('%m'))
    local day = tonumber(os.date('%d'))

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

event:setEnableCheck(xi.events.eggHunt.enabledCheck)

-----------------------------------
-- Data
-----------------------------------

xi.events.eggHunt.data =
{
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        cs          = 872,
        moogle      = { 194, 56.195, 1.999, -25.207 }, --!pos 56.195 1.999 -25.207 230
        decorations =
        {
            { 224,  -99.972,  1.000, -57.257, '0x00006B0500000000000000000000000000000000', },
            { 224, -113.320,  1.000, -43.947, '0x00006B0500000000000000000000000000000000', },
            { 160,  113.326,  1.000, -43.947, '0x00006B0500000000000000000000000000000000', },
            { 160,   99.882,  1.000, -57.257, '0x00006B0500000000000000000000000000000000', },
            {  96,  144.679, -2.000, 120.889, '0x00006B0500000000000000000000000000000000', },
            {  96,  152.904, -2.000, 112.697, '0x00006B0500000000000000000000000000000000', },
        },
        helpers =
        {
            {  95,  143.780, -2.000, 119.940, '0x01001E0382116F20173017401750006000700000', },
            {  95,  151.890, -2.000, 111.800, '0x01001E0482116F20173017401750006000700000', },
            { 160,  112.000,  1.000, -42.600, '0x01001E0582116F20173017401750006000700000', },
            { 160,   98.600,  1.000, -56.000, '0x01001E0682116F20173017401750006000700000', },
            { 224,  -98.640,  1.000, -55.940, '0x01001E0782116F20173017401750006000700000', },
            { 224, -112.000,  1.000, -42.600, '0x01001E0882116F20173017401750006000700000', },
        },
    },

    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        cs          = 832,
        moogle      = { 128, -224.135, 8.000, 53.476 }, -- !pos -224.135 8.000 53.476 231
        decorations =
        {
            { 163,   87.834, 0.000,  8.015, '0x00006B0500000000000000000000000000000000', },
            { 163,   84.074, 0.000,  4.233, '0x00006B0500000000000000000000000000000000', },
            {   0, -245.045, 7.999, 34.350, '0x00006B0500000000000000000000000000000000', },
            {   0, -245.045, 7.999, 53.650, '0x00006B0500000000000000000000000000000000', },
        },
        helpers =
        {
            {   0, -243.800, 8.000, 33.500, '0x01001E0182116F20173017401750006000700000', },
            {   0, -243.800, 8.000, 35.000, '0x01001E0282116F20173017401750006000700000', },
            {   0, -243.800, 8.000, 52.800, '0x01001E0382116F20173017401750006000700000', },
            {   0, -243.800, 8.000, 54.300, '0x01001E0482116F20173017401750006000700000', },
            { 160,   83.100, 0.000,  5.200, '0x01001E0582116F20173017401750006000700000', },
        },
    },

    [xi.zone.BASTOK_MINES] =
    {
        cs          = 561,
        moogle      = { 0, -33.600, -0.001, -110.000 }, -- !pos -33.600 -0.001 -110.000 234
        decorations =
        {
            { 192, -10.200, -1.000, -127.100, '0x00006C0500000000000000000000000000000000', },
            { 192, -21.800, -1.000, -127.100, '0x00006C0500000000000000000000000000000000', },
            { 128,  82.000,  0.000,  -66.700, '0x00006C0500000000000000000000000000000000', },
            { 128,  82.000,  0.000,  -77.300, '0x00006C0500000000000000000000000000000000', },
        },
        helpers =
        {
            { 127,  80.500,  0.000,  -66.700, '0x01001E0182117120173017401750006000700000', },
            { 127,  80.500,  0.000,  -77.300, '0x01001E0282117120173017401750006000700000', },
            { 192, -10.250, -1.000, -125.900, '0x01001E0382117120173017401750006000700000', },
            { 192, -21.800, -1.000, -125.900, '0x01001E0482117120173017401750006000700000', },
        },
    },

    [xi.zone.BASTOK_MARKETS] =
    {
        cs          = 467,
        moogle      = { 40, -260.440, -12.021, -79.538 }, -- !pos -260.440 -12.021 -79.538 235
        decorations =
        {
            { 128, -153.700,  -4.000,   33.000, '0x00006C0500000000000000000000000000000000', },
            { 128, -153.700,  -4.000,   27.000, '0x00006C0500000000000000000000000000000000', },
            { 128, -153.700,  -4.000,  -27.000, '0x00006C0500000000000000000000000000000000', },
            { 128, -153.700,  -4.000,  -33.000, '0x00006C0500000000000000000000000000000000', },
            { 224, -362.004, -10.002, -173.953, '0x00006C0500000000000000000000000000000000', },
            { 224, -353.928, -10.002, -182.068, '0x00006C0500000000000000000000000000000000', },
        },
        helpers =
        {
            { 224, -353.000, -10.000, -181.080, '0x01001E0582117120173017401750006000700000', },
            { 224, -360.900, -10.000, -173.000, '0x01001E0682117120173017401750006000700000', },
            { 127, -155.000,  -4.000,   33.000, '0x01001E0782117120173017401750006000700000', },
            { 127, -155.000,  -4.000,   27.000, '0x01001E0882117120173017401750006000700000', },
        },
    },

    [xi.zone.WINDURST_WATERS] =
    {
        cs          = 969,
        moogle      = { 0, -55.470, -5.391, 216.362 }, -- !pos -55.470 -5.391 216.362 238
        decorations =
        {
            { 192, 164.500, -0.250, -30.000, '0x00006D0500000000000000000000000000000000', },
            { 192, 155.500, -0.250, -30.000, '0x00006D0500000000000000000000000000000000', },
            {  64, -46.800, -4.916, 227.570, '0x00006D0500000000000000000000000000000000', },
            {  64, -33.200, -4.982, 227.570, '0x00006D0500000000000000000000000000000000', },
        },
        helpers =
        {
            { 192, 165.000, -0.250, -28.800, '0x01001E0582117020173017401750006000700000', },
            { 192, 164.000, -0.250, -28.800, '0x01001E0682117020173017401750006000700000', },
            { 192, 155.500, -0.250, -28.800, '0x01001E0782117020173017401750006000700000', },
            {  63, -46.800, -4.900, 226.220, '0x01001E0882117020173017401750006000700000', },
            {  63, -33.200, -4.900, 226.220, '0x01001E0182117020173017401750006000700000', },
        },
    },

    [xi.zone.WINDURST_WOODS] =
    {
        cs          = 785,
        moogle      = { 161, 104.823, -5.000, -55.745 }, -- !pos 104.823 -5.000 -55.745 241
        decorations =
        {
            { 128,  107.630, -5.000, -33.200, '0x00006D0500000000000000000000000000000000', },
            { 128,  107.630, -5.000, -46.800, '0x00006D0500000000000000000000000000000000', },
            {   0, -107.000, -5.250,  35.500, '0x00006D0500000000000000000000000000000000', },
            {   0, -107.000, -5.250,  44.500, '0x00006D0500000000000000000000000000000000', },
        },
        helpers =
        {
            {   0, -105.500, -5.250,  35.500, '0x01001E0282117020173017401750006000700000', },
            {   0, -105.500, -5.250,  44.500, '0x01001E0782117020173017401750006000700000', },
            { 127,  106.500, -5.000, -33.200, '0x01001E0382117020173017401750006000700000', },
            { 127,  106.500, -5.000, -46.800, '0x01001E0482117020173017401750006000700000', },
            { 127, -155.000, -4.000, -27.000, '0x01001E0100107120173017401750006000700000', },
            { 127, -155.000, -4.000, -33.000, '0x01001E0282117120173017401750006000700000', },
        },
    },
}

local messageOffset =
{
    REWARD1 = 0,  -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
    REWARD2 = 1,  -- Egg-straordinary! Here's your special prize, kupo! But how did you figure out the secret combination...?
    REWARD3 = 2,  -- How in-eggs-plicably astounding! You're truly a hard-boiled detective of the highest degree, kupo! Here's your prize, and don't forget to enjoy the rest of the festivities.
    WAITING = 3,  -- Hey, don't get all egg-cited! You can only claim one prize a day, kupo!
    HINTING = 4,  -- These initial eggs are really egg-spensive, kupo! If you want one I'm going to need a little more incentive. No egg-ceptions!
    TRADE1  = 5,  -- Eggs-actly what I wanted! Here's your reward, kupo!
    TRADE2  = 6,  -- Ku-kupo! Such an egg-stravagant item, for little old me? Here's a whole basketful of initial eggs for you, kupo!
    TRADE3  = 7,  -- My eyes! My eyes! Get out of here, and take those egg-ceptionally nasty things with you, kupo!
    TRADE4  = 8,  -- Kupo... Kupo! Please! No more, kupo! Here, take these and get out of here, kupo!
    DELAY   = 9,  -- Hey, I can only trade with you once a day. We wouldn't want to make the egg hunt over easy, now, kupo!
    HELP    = 10, -- Hey, you look new here, kupo! If you need anything, just let me know!
    REWARD4 = 11, -- Heh heh heh... I have something egg-specially egg-citing in store for you, kupo!
}

-----------------------------------
-- Helpers
-----------------------------------

xi.events.eggHunt.charToEgg = function(char)
    -- Char offset from 'A', eg. B = 1, C = 2, etc.
    local charOffset = string.byte(string.lower(char)) - 97
    return xi.item.A_EGG + charOffset
end

-- If egg is already in table, return index so it can be added to total eg. 2x 'A' Egg
xi.events.eggHunt.findEggIndex = function(eggList, eggLetter)
    for index, egg in pairs(eggList) do
        if egg and egg[1] == eggLetter then
            return index
        end
    end

    return -1
end

-- Convert string to table of lettered eggs
xi.events.eggHunt.stringToEggs = function(text)
    local str     = string.lower(text)
    local eggList = {}

    for char = 1, #str do
        local ascii   = string.byte(string.sub(str, char, char))
        local itemID  = xi.item.A_EGG + (ascii - 97)
        local itemPos = xi.events.eggHunt.findEggIndex(eggList, itemID)

        -- If table already contains this egg, add to total
        if itemPos > -1 then
            eggList[itemPos][2] = eggList[itemPos][2] + 1
        else
            table.insert(eggList, { itemID, 1 })
        end
    end

    return eggList
end

local hasFirstThree = function(player)
    return (
        player:getCharVar(settings.VAR.FIRST_THREE) == 1 or
        player:hasItem(xi.item.EGG_HELM)
    )
end

-----------------------------------
-- Combos
-----------------------------------

local minorRewards =
{
    xi.item.CHOCOBO_TICKET,
    xi.item.RED_DROP,
    xi.item.YELLOW_DROP,
    xi.item.BLUE_DROP,
    xi.item.GREEN_DROP,
    xi.item.CLEAR_DROP,
    xi.item.PURPLE_DROP,
    xi.item.WHITE_DROP,
    xi.item.BLACK_DROP,
}

local minorReward = function()
    return minorRewards[math.random(#minorRewards)]
end

local tradeInReward =
{
    -- Bird Egg       x12 or
    -- Lizard Egg      x6 or
    -- Soft-boiled Egg x1 or
    -- Colored Egg     x1 =
    ------------------------
    -- <Random> Egg    x1
    {
        rewardAmount = 1,
        itemsAccepted =
        {
            { { xi.item.BIRD_EGG, 12 } },
            { { xi.item.LIZARD_EGG, 6 } },
            xi.item.SOFT_BOILED_EGG,
            xi.item.COLORED_EGG,
        },
        conditional =
        {
            { settings.ERA_2008, { { xi.item.HARD_BOILED_EGG, 12 } } },
            { settings.ERA_2019, xi.item.APKALLU_EGG },
        },
    },

    -- Party Egg    x1 =
    --------------------
    -- <Random> Egg x2
    {
        rewardAmount  = 2,
        itemsAccepted =
        {
            xi.item.PARTY_EGG
        },
    },

    -- Lucky Egg    x1 =
    --------------------
    -- <Random> Egg x3
    {
        rewardAmount  = 3,
        itemsAccepted =
        {
            xi.item.LUCKY_EGG
        },
        conditional   =
        {
            { settings.ERA_2018, { { xi.item.SAIRUI_RAN, 99 } } },
        },
    },

    -- Imperial Egg x1 =
    --------------------
    -- <Random> Egg x8
    {
        rewardAmount = 8,
        conditional  =
        {
            { settings.ERA_2018, xi.item.IMPERIAL_EGG },
        },
    },
}

local rollRewardAmount = function(rewardAmount)
    if rewardAmount == 1 then
        return { math.random(xi.item.A_EGG, xi.item.Z_EGG) }
    end

    local rewardTable = {}

    for i = 1, rewardAmount do
        table.insert(rewardTable, math.random(xi.item.A_EGG, xi.item.Z_EGG))
    end

    return rewardTable
end

local getTradeInReward = function(player, trade)
    for _, tradeType in pairs(tradeInReward) do
        if tradeType.itemsAccepted ~= nil then
            for _, items in pairs(tradeType.itemsAccepted) do
                if npcUtil.tradeHasExactly(trade, items) then
                    return rollRewardAmount(tradeType.rewardAmount)
                end
            end
        end

        if tradeType.conditional ~= nil then
            for _, items in pairs(tradeType.conditional) do
                if
                    npcUtil.tradeHasExactly(trade, items[2]) and
                    items[1] -- Check trade condition, eg. settings
                then
                    return rollRewardAmount(tradeType.rewardAmount)
                end
            end
        end
    end

    return {}
end

local tradeIn = function(player, npc, trade, zoneID)
    local reward = getTradeInReward(player, trade)

    if #reward > 0 then
        if player:getCharVar(settings.VAR.DAILY_BONUS) >= VanadielUniqueDay() then
            player:messageText(npc, zones[zoneID].text.EGG_HUNT_OFFSET + messageOffset.DELAY)
            return true
        end

        if #reward >= 3 then
            player:messageText(npc, zones[zoneID].text.EGG_HUNT_OFFSET + messageOffset.TRADE2)
        else
            player:messageText(npc, zones[zoneID].text.EGG_HUNT_OFFSET + messageOffset.TRADE1)
        end

        if npcUtil.giveItem(player, reward) then
            player:confirmTrade()
            player:setVar(settings.VAR.DAILY_BONUS, VanadielUniqueDay())
        end

        return true
    end

    return false
end

local firstThree = function(player, npc, trade)
    local charName = player:getName()

    if
        npcUtil.tradeHasExactly(trade, {
            xi.events.eggHunt.charToEgg(string.sub(charName, 1, 1)),
            xi.events.eggHunt.charToEgg(string.sub(charName, 2, 2)),
            xi.events.eggHunt.charToEgg(string.sub(charName, 3, 3)),
        })
    then
        -- If not 2007, or player already has Egg Helm,.minor reward is issued instead
        if settings.ERA_2007 and not player:hasItem(xi.item.EGG_HELM) then
            player:setVar(settings.VAR.FIRST_THREE, 1)
            return xi.item.EGG_HELM
        end

        player:setVar(settings.VAR.FIRST_THREE, 1)
        return minorReward()
    end
end

local sevenKind = function(player, npc, trade)
    -- First three required
    if not hasFirstThree(player) then
        return
    end

    for letterOffset = 0, 26 do
        if npcUtil.tradeHasExactly(trade, { { xi.item.A_EGG + letterOffset, 7 } }) then
            if not player:hasItem(xi.item.FORTUNE_EGG) then
                return xi.item.FORTUNE_EGG
            end

            if settings.MINOR_REWARDS then
                return minorReward()
            end

            return
        end
    end
end

local straightEight = function(player, npc, trade)
    -- First three required
    if not hasFirstThree(player) then
        return
    end

    local initial = string.lower(string.sub(player:getName(), 1, 1)) -- eg. 'a'
    local letter = string.byte(initial) - 97 + xi.item.A_EGG        -- itemID
    local eggs = {}

    for i = 1, 8 do
        table.insert(eggs, letter)
        letter = letter + 1

        if letter > xi.item.Z_EGG then
            letter = xi.item.A_EGG
        end
    end

    if npcUtil.tradeHasExactly(trade, eggs) then
        if not player:hasItem(xi.item.HAPPY_EGG) then
            return xi.item.HAPPY_EGG
        end

        if settings.MINOR_REWARDS then
            return minorReward()
        end
    end
end

local regionNames =
{
    xi.events.eggHunt.stringToEggs('RONFA'),
    xi.events.eggHunt.stringToEggs('ZULKH'),
    xi.events.eggHunt.stringToEggs('NORVA'),
    xi.events.eggHunt.stringToEggs('GUSTA'),
    xi.events.eggHunt.stringToEggs('DERFL'),
    xi.events.eggHunt.stringToEggs('SARUT'),
    xi.events.eggHunt.stringToEggs('KOLSH'),
    xi.events.eggHunt.stringToEggs('ARAGO'),
    xi.events.eggHunt.stringToEggs('FAURE'),
    xi.events.eggHunt.stringToEggs('VALDE'),
    xi.events.eggHunt.stringToEggs('QUFIM'),
    xi.events.eggHunt.stringToEggs('LITEL'),
    xi.events.eggHunt.stringToEggs('KUZOT'),
    xi.events.eggHunt.stringToEggs('VOLLB'),
    xi.events.eggHunt.stringToEggs('ELSHI'),
    xi.events.eggHunt.stringToEggs('ELSHI'),
    xi.events.eggHunt.stringToEggs('TULIA'),
    xi.events.eggHunt.stringToEggs('MOVAL'),
    xi.events.eggHunt.stringToEggs('TAVNA'),
}

local beastCostumes =
{
    580, -- Yagudo
    612, -- Orc
    644, -- Quadav
}

local nationRewards =
{
    { xi.item.WING_EGG,   xi.item.MELODIUS_EGG,  xi.item.EGG_STOOL, },
    { xi.item.LAMP_EGG,   xi.item.CLOCKWORK_EGG, xi.item.EGG_TABLE, },
    { xi.item.FLOWER_EGG, xi.item.HATCHLING_EGG, xi.item.EGG_LOCKER, },
}

local regionControl = function(player, npc, trade)
    -- First three required
    if not hasFirstThree(player) then
        return
    end

    for regionID, regionName in pairs(regionNames) do
        if npcUtil.tradeHasExactly(trade, regionName) then
            local owner = GetRegionOwner(regionID - 1)

            -- Beastmen controlled
            if owner == 3 then
                local costume = beastCostumes[math.random(#beastCostumes)]
                player:addStatusEffect(xi.effect.COSTUME, costume, 0, utils.minutes(60))
                player:confirmTrade()

                return
            else
                local reward = nationRewards[owner + 1]

                -- 2005 Reward
                if not player:hasItem(reward[1]) then
                    return reward[1]

                -- 2007 Reward
                elseif
                    settings.ERA_2007 and
                    not player:hasItem(xi.item.JEWELED_EGG)
                then
                    return xi.item.JEWELED_EGG

                -- 2008 Reward
                elseif
                    settings.ERA_2008 and
                    not player:hasItem(reward[2])
                then
                    return reward[2]

                -- 2009 Rewards
                elseif
                    settings.ERA_2009 and
                    not player:hasItem(reward[3])
                then
                    return reward[3]

                elseif
                    settings.ERA_2009 and
                    not player:hasItem(xi.item.EGG_LANTERN)
                then
                    return xi.item.EGG_LANTERN

                -- 2013 Reward
                elseif
                    settings.ERA_2013 and
                    player:hasItem(reward[2]) and
                    player:hasItem(reward[3]) and
                    player:hasItem(xi.item.EGG_LANTERN) and
                    not player:hasItem(xi.item.PRINSEGGSTARTA)
                then
                    return xi.item.PRINSEGGSTARTA

                -- Repeat Reward (If enabled)
                elseif
                    settings.MINOR_REWARDS
                then
                    return minorReward()

                -- Return nothing
                else
                    return
                end
            end
        end
    end
end

local elementNames =
{
    { xi.events.eggHunt.stringToEggs('FIRE'),    xi.item.RED_DROP    },
    { xi.events.eggHunt.stringToEggs('ICE'),     xi.item.CLEAR_DROP  },
    { xi.events.eggHunt.stringToEggs('AIR'),     xi.item.GREEN_DROP  },
    { xi.events.eggHunt.stringToEggs('EARTH'),   xi.item.YELLOW_DROP },
    { xi.events.eggHunt.stringToEggs('THUNDER'), xi.item.PURPLE_DROP },
    { xi.events.eggHunt.stringToEggs('WATER'),   xi.item.BLUE_DROP   },
    { xi.events.eggHunt.stringToEggs('LIGHT'),   xi.item.WHITE_DROP  },
    { xi.events.eggHunt.stringToEggs('DARK'),    xi.item.BLACK_DROP  },
}

local weekDay = function(player, npc, trade)
    -- Ignore if not era or first three not completed
    if (not settings.ERA_2006) or (not hasFirstThree(player)) then
        return
    end

    local elementDay = elementNames[VanadielDayElement()]

    if npcUtil.tradeHasExactly(trade, elementDay[1]) then
        if player:hasItem(xi.item.ORPHIC_EGG) then
            return elementDay[2] -- Colored Drop
        else
            return xi.item.ORPHIC_EGG
        end
    end
end

local eraCombo =
{
    ELEVEN   = { xi.events.eggHunt.stringToEggs('ELEVEN'),   xi.item.HATCHLING_SHIELD     },
    LEAFKIN  = { xi.events.eggHunt.stringToEggs('LEAFKIN'),  xi.item.PIECE_OF_COPSE_CANDY },
    VANADIEL = { xi.events.eggHunt.stringToEggs('VANADIEL'), xi.item.CRACKER              },
    HARE     = { xi.events.eggHunt.stringToEggs('HARE'),     xi.item.RABBIT_CAP           },
    BUNNY    = { xi.events.eggHunt.stringToEggs('BUNNY'),    xi.item.RABBIT_CAP           },
    RABBIT   = { xi.events.eggHunt.stringToEggs('RABBIT'),   xi.item.RABBIT_CAP           },
}

local testEraCombo = function(player, npc, trade, combo, rewardQty)
    if npcUtil.tradeHasExactly(trade, combo[1]) then
        if rewardQty then
            local qty = math.random(rewardQty[1], rewardQty[2])
            return { { combo[2], qty } }
        else
            return combo[2]
        end
    end
end

local era2014 = function(player, npc, trade)
    local testEleven = testEraCombo(player, npc, trade, eraCombo.ELEVEN)
    if testEleven then
        return testEleven
    end

    local testLeafkin = testEraCombo(player, npc, trade, eraCombo.LEAFKIN, { 5, 10 })
    if testLeafkin then
        return testLeafkin
    end

    local testVanadiel = testEraCombo(player, npc, trade, eraCombo.VANADIEL, { 5, 10 })
    if testVanadiel then
        return testVanadiel
    end
end

local era2015 = function(player, npc, trade)
    return testEraCombo(player, npc, trade, eraCombo.HARE)
end

-- There is no evidence of these combinations before 2018
local era2018 = function(player, npc, trade)
    local testBunny = testEraCombo(player, npc, trade, eraCombo.BUNNY)
    if testBunny then
        return testBunny
    end

    local testRabbit = testEraCombo(player, npc, trade, eraCombo.RABBIT)
    if testRabbit then
        return testRabbit
    end
end

local getSecondInitial = function(player, option)
    local party = player:getParty()

    for _, member in pairs(party) do
        if
            member ~= nil and                          -- Player exists
            player:getName() ~= member:getName() and   -- Different player
            player:getZoneID() == member:getZoneID()   -- Same zone
        then
            local playerName   = member:getName()
            local initial      = string.sub(playerName, 1, 1)
            local firstLetter  = string.byte(string.lower(initial)) - 97
            local second       = string.sub(playerName, 2, 2)
            local secondLetter = string.byte(string.lower(second)) - 97

            if
                firstLetter == (option - 3) and
                member:getEquipID(xi.slot.HEAD) == xi.item.EGG_HELM
            then
                return xi.item.A_EGG + secondLetter
            end
        end
    end

    return 0
end

xi.events.eggHunt.combos =
{
    { check = firstThree,    message = messageOffset.REWARD1 },
    { check = sevenKind,     message = messageOffset.REWARD2 },
    { check = straightEight, message = messageOffset.REWARD2 },
    { check = regionControl, message = messageOffset.REWARD2 },
    { check = weekDay,       message = messageOffset.REWARD2 },
}

if settings.ERA_2014 then
    table.insert(xi.events.eggHunt.combos, { check = era2014, message = messageOffset.REWARD2 })
end

if settings.ERA_2015 then
    table.insert(xi.events.eggHunt.combos, { check = era2015, message = messageOffset.REWARD2 })
end

if settings.ERA_2018 then
    table.insert(xi.events.eggHunt.combos, { check = era2018, message = messageOffset.REWARD2 })
end

for bonusWord, rewardItem in pairs(settings.BONUS_WORDS) do
    local customEggs = xi.events.eggHunt.stringToEggs(bonusWord)

    table.insert(xi.events.eggHunt.combos,
    {
        check = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, customEggs) then
                return rewardItem
            end
        end,

        message = messageOffset.REWARD2,
    })
end

-----------------------------------
-- HELM event handler
-----------------------------------
xi.events.eggHunt.helmResult = function(player, itemID)
    if
        xi.events.eggHunt.enabledCheck() and
        player:getCharVar(settings.VAR.DAILY_HELM) < VanadielUniqueDay()
    then
        player:timer(3000, function(playerArg)
            if npcUtil.giveItem(playerArg, math.random(xi.item.A_EGG, xi.item.Z_EGG)) then
                playerArg:setCharVar(settings.VAR.DAILY_HELM, VanadielUniqueDay())
            end
        end)
    end
end

-----------------------------------
-- Moogle event handlers
-----------------------------------

xi.events.eggHunt.onTrigger = function(player, npc)
    local zoneID = player:getZoneID()

    npc:facePlayer(player, true)

    if player:getCharVar(settings.VAR.DAILY_EGG) >= VanadielUniqueDay() then
        player:messageText(npc, zones[zoneID].text.EGG_HUNT_OFFSET + messageOffset.HINTING)
    else
        local party = player:getParty()
        local options = -1

        for _, member in pairs(party) do
            if
                member ~= nil and                        -- Player exists
                player:getName() ~= member:getName() and -- Different player
                player:getZoneID() == member:getZoneID() -- Same zone
            then
                local initial = string.sub(member:getName(), 1, 1)
                local letter = string.byte(string.lower(initial)) - 97
                options = utils.mask.setBit(options, letter, 0)
            end
        end

        if options ~= -1 then
            options = utils.mask.setBit(options, 26, 0)
            player:startEvent(xi.events.eggHunt.data[zoneID].cs, 3, options)
        else
            player:startEvent(xi.events.eggHunt.data[zoneID].cs, 1)
        end
    end
end

xi.events.eggHunt.onEventFinish = function(player, csid, option, npc)
    -- 'Forget it.' or out of range
    if option > 28 then
        return

    -- Selected party member initial
    elseif option >= 3 then
        local eggsGiven = { xi.item.A_EGG + option - 3 }
        local second = getSecondInitial(player, option)

        -- Give second letter if selected player has Egg Helm equipped
        if second > 0 then
            table.insert(eggsGiven, second)
        end

        if npcUtil.giveItem(player, eggsGiven) then
            player:setVar(settings.VAR.DAILY_EGG, VanadielUniqueDay())
        end

    -- Random daily letter
    else
        if npcUtil.giveItem(player, math.random(xi.item.A_EGG, xi.item.Z_EGG)) then
            player:setVar(settings.VAR.DAILY_EGG, VanadielUniqueDay())
        end
    end
end

xi.events.eggHunt.onTrade = function(player, npc, trade)
    local zoneID = player:getZoneID()

    npc:facePlayer(player, true)

    if tradeIn(player, npc, trade, zoneID) then
        return
    end

    for _, v in pairs(xi.events.eggHunt.combos) do
        local reward = v.check(player, npc, trade)
        if reward then
            -- If reward already received today, send message and finish event
            if
                player:getCharVar(settings.VAR.DAILY_REWARD) >= VanadielUniqueDay()
            then
                player:messageText(npc, zones[zoneID].text.EGG_HUNT_OFFSET + messageOffset.WAITING)
                return
            end

            -- If reward message is a message ID, attempt to use messageText, if not use custom text
            if v.message ~= nil then
                if type(v.message) == 'number' then
                    player:messageText(npc, zones[zoneID].text.EGG_HUNT_OFFSET + v.message)
                else
                    player:printToPlayer(string.format('Moogle : %s', v.message), xi.msg.channel.NS_SAY, 'Moogle')
                end
            end

            -- Attempt to give item
            if npcUtil.giveItem(player, reward) then
                player:confirmTrade()

                -- One reward per day
                player:setVar(settings.VAR.DAILY_REWARD, VanadielUniqueDay())

                -- Call 'after' function if it exists
                if v.after then
                    v.after(player, npc, trade)
                end
            end

            return
        end
    end
end

-----------------------------------
-- Show/hide Moogles and decorations
-----------------------------------

local function insertNpc(zone, entry)
    local rot  = entry[1]
    local x    = entry[2]
    local y    = entry[3]
    local z    = entry[4]
    local look = entry[5]

    local npc = zone:insertDynamicEntity({
        objtype     = xi.objType.NPC,
        name        = '     ',
        look        = look,
        x           = x,
        y           = y,
        z           = z,
        rotation    = rot,
        widescan    = 0,
        entityFlags = 2075,
        namevis     = 64,
        releaseIdOnDisappear = true,
    })

    table.insert(xi.events.eggHunt.entities, npc:getID())
end

local function insertMoogle(zone, pos)
    local npc = zone:insertDynamicEntity({
        objtype       = xi.objType.NPC,
        name          = 'Egg_Hunt_Moogle',
        packetName    = 'Moogle',
        look          = 82,
        x             = pos[2],
        y             = pos[3],
        z             = pos[4],
        rotation      = pos[1],
        onTrigger     = xi.events.eggHunt.onTrigger,
        onEventFinish = xi.events.eggHunt.onEventFinish,
        onTrade       = xi.events.eggHunt.onTrade,
        releaseIdOnDisappear = true,
    })

    table.insert(xi.events.eggHunt.entities, npc:getID())
end

xi.events.eggHunt.generateEntities = function()
    for zoneID, data in pairs(xi.events.eggHunt.data) do
        local zone = GetZone(zoneID)
        if zone then
            insertMoogle(zone, data.moogle)

            for _, entry in pairs(data.decorations) do
                insertNpc(zone, entry)
            end

            -- Helpers wearing the Rabbit Cap
            if settings.ERA_2015 then
                for _, entry in pairs(data.helpers) do
                    insertNpc(zone, entry)
                end
            end
        end
    end
end

xi.events.eggHunt.showEntities = function(enabled)
    if enabled and #xi.events.eggHunt.entities == 0 then
        xi.events.eggHunt.generateEntities()
    end

    for _, entityID in pairs(xi.events.eggHunt.entities) do
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
        xi.events.eggHunt.entities = {}
    end
end

event:setStartFunction(function()
    xi.events.eggHunt.showEntities(true)
end)

event:setEndFunction(function()
    xi.events.eggHunt.showEntities(false)
end)

return event
