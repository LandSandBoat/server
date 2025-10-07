-----------------------------------
-- I Can Hear a Rainbow
-----------------------------------
-- Log ID: 2, Quest ID: 75
-----------------------------------
local laTheineID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW)

local validWeatherTable =
set{
    xi.weather.NONE,
    xi.weather.HOT_SPELL,
    xi.weather.HEAT_WAVE,
    xi.weather.RAIN,
    xi.weather.SQUALL,
    xi.weather.DUST_STORM,
    xi.weather.SAND_STORM,
    xi.weather.WIND,
    xi.weather.GALES,
    xi.weather.SNOW,
    xi.weather.BLIZZARDS,
    xi.weather.THUNDER,
    xi.weather.THUNDERSTORMS,
}

local zoneEventTable =
{
    [xi.zone.WEST_RONFAURE         ] = {  51 },
    [xi.zone.EAST_RONFAURE         ] = {  21 },
    [xi.zone.NORTH_GUSTABERG       ] = { 244 },
    [xi.zone.SOUTH_GUSTABERG       ] = { 901 },
    [xi.zone.WEST_SARUTABARUTA     ] = {  48 },
    [xi.zone.EAST_SARUTABARUTA     ] = {  50 },
    [xi.zone.LA_THEINE_PLATEAU     ] = { 123 },
    [xi.zone.KONSCHTAT_HIGHLANDS   ] = { 104 },
    [xi.zone.TAHRONGI_CANYON       ] = {  35 },
    [xi.zone.VALKURM_DUNES         ] = {   3 },
    [xi.zone.BUBURIMU_PENINSULA    ] = {   3 },
    [xi.zone.JUGNER_FOREST         ] = {  15 },
    [xi.zone.BATALLIA_DOWNS        ] = { 901 },
    [xi.zone.PASHHOW_MARSHLANDS    ] = {  13 },
    [xi.zone.ROLANBERRY_FIELDS     ] = {   2 },
    [xi.zone.MERIPHATAUD_MOUNTAINS ] = {  31 },
    [xi.zone.SAUROMUGUE_CHAMPAIGN  ] = {   3 },
    [xi.zone.BEAUCEDINE_GLACIER    ] = { 114 },
    [xi.zone.XARCABARD             ] = {   9 },
    [xi.zone.YUHTUNGA_JUNGLE       ] = {  11 },
    [xi.zone.YHOATOR_JUNGLE        ] = {   2 },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] = {   2 },
    [xi.zone.EASTERN_ALTEPA_DESERT ] = {   2 },
    [xi.zone.WESTERN_ALTEPA_DESERT ] = {   2 },
    [xi.zone.CAPE_TERIGGAN         ] = {   2 },
}

local function handleZoneIn(player, prevZone)
    if player:hasItem(xi.item.CARBUNCLES_RUBY, xi.inventoryLocation.INVENTORY) then
        local zone    = player:getZone(true)
        local weather = zone:getWeather()

        -- Exception: Handle Sunshine weather as weather ID 0 (NONE) for the time being.
        if weather == xi.weather.SUNSHINE then
            weather = xi.weather.NONE
        end

        -- Store weather in a local var just in case weather changes in this few seconds.
        player:setLocalVar('Weather', weather)

        -- Fetch weather element if it's a valid element.
        if validWeatherTable[weather] then
            local lightBitMask = quest:getVar(player, 'Light')
            local element      = xi.data.element.getWeatherElement(weather)
            if not utils.mask.getBit(lightBitMask, element) then
                return zoneEventTable[zone:getID()][1]
            end
        end
    end
end

local function handleEventUpdate(player, csid, option, npc)
    local weather      = player:getLocalVar('Weather')
    local lightBitMask = quest:getVar(player, 'Light')
    local lightCounter = 0

    for bit = 0, 6 do
        if utils.mask.getBit(lightBitMask, bit) then
            lightCounter = lightCounter + 1
        end
    end

    -- Note: You will only count 6 by triggering the 7th (last) light.
    -- The client expects a 6 in event update when triggering the last light.
    if lightCounter == 6 then
        quest:setVar(player, 'Prog', 1)
    end

    player:updateEvent(0, 1, weather, lightCounter)
end

local function handleEventFinish(player, csid, option, npc)
    local weather      = player:getLocalVar('Weather')
    local element      = xi.data.element.getWeatherElement(weather)
    local lightBitMask = utils.mask.setBit(quest:getVar(player, 'Light'), element, true)

    quest:setVar(player, 'Light', lightBitMask)
end

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.WINDURST,
    title    = xi.title.RAINBOW_WEAVER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL and
                player:hasItem(xi.item.CARBUNCLES_RUBY, xi.inventoryLocation.INVENTORY)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(384, 0, xi.item.CARBUNCLES_RUBY)
                end,
            },

            onEventFinish =
            {
                [384] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] = quest:event(385, 0, xi.item.CARBUNCLES_RUBY):oncePerZone(),
        },

        [xi.zone.WEST_RONFAURE] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [51] = handleEventUpdate,
            },

            onEventFinish =
            {
                [51] = handleEventFinish,
            },
        },

        [xi.zone.EAST_RONFAURE] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [21] = handleEventUpdate,
            },

            onEventFinish =
            {
                [21] = handleEventFinish,
            },
        },

        [xi.zone.NORTH_GUSTABERG] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [244] = handleEventUpdate,
            },

            onEventFinish =
            {
                [244] = handleEventFinish,
            },
        },

        [xi.zone.SOUTH_GUSTABERG] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [901] = handleEventUpdate,
            },

            onEventFinish =
            {
                [901] = handleEventFinish,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [48] = handleEventUpdate,
            },

            onEventFinish =
            {
                [48] = handleEventFinish,
            },
        },

        [xi.zone.EAST_SARUTABARUTA] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [50] = handleEventUpdate,
            },

            onEventFinish =
            {
                [50] = handleEventFinish,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [123] = handleEventUpdate,
            },

            onEventFinish =
            {
                [123] = handleEventFinish,
            },
        },

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [104] = handleEventUpdate,
            },

            onEventFinish =
            {
                [104] = handleEventFinish,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [35] = handleEventUpdate,
            },

            onEventFinish =
            {
                [35] = handleEventFinish,
            },
        },

        [xi.zone.VALKURM_DUNES] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [3] = handleEventUpdate,
            },

            onEventFinish =
            {
                [3] = handleEventFinish,
            },
        },

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [3] = handleEventUpdate,
            },

            onEventFinish =
            {
                [3] = handleEventFinish,
            },
        },

        [xi.zone.JUGNER_FOREST] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [15] = handleEventUpdate,
            },

            onEventFinish =
            {
                [15] = handleEventFinish,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [901] = handleEventUpdate,
            },

            onEventFinish =
            {
                [901] = handleEventFinish,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [13] = handleEventUpdate,
            },

            onEventFinish =
            {
                [13] = handleEventFinish,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [2] = handleEventUpdate,
            },

            onEventFinish =
            {
                [2] = handleEventFinish,
            },
        },

        [xi.zone.MERIPHATAUD_MOUNTAINS] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [31] = handleEventUpdate,
            },

            onEventFinish =
            {
                [31] = handleEventFinish,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [3] = handleEventUpdate,
            },

            onEventFinish =
            {
                [3] = handleEventFinish,
            },
        },

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [114] = handleEventUpdate,
            },

            onEventFinish =
            {
                [114] = handleEventFinish,
            },
        },

        [xi.zone.XARCABARD] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [9] = handleEventUpdate,
            },

            onEventFinish =
            {
                [9] = handleEventFinish,
            },
        },

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [11] = handleEventUpdate,
            },

            onEventFinish =
            {
                [11] = handleEventFinish,
            },
        },

        [xi.zone.YHOATOR_JUNGLE] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [2] = handleEventUpdate,
            },

            onEventFinish =
            {
                [2] = handleEventFinish,
            },
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [2] = handleEventUpdate,
            },

            onEventFinish =
            {
                [2] = handleEventFinish,
            },
        },

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [2] = handleEventUpdate,
            },

            onEventFinish =
            {
                [2] = handleEventFinish,
            },
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [2] = handleEventUpdate,
            },

            onEventFinish =
            {
                [2] = handleEventFinish,
            },
        },

        [xi.zone.CAPE_TERIGGAN] =
        {
            onZoneIn = handleZoneIn,

            onEventUpdate =
            {
                [2] = handleEventUpdate,
            },

            onEventFinish =
            {
                [2] = handleEventFinish,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CARBUNCLES_RUBY) then
                        return quest:progressEvent(124)
                    end
                end,
            },

            onEventFinish =
            {
                [124] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()

                        -- Unlock SMN job.
                        player:unlockJob(xi.job.SMN)
                        player:addSpell(xi.magic.spell.CARBUNCLE)
                        player:messageSpecial(laTheineID.text.UNLOCK_SUMMONER)
                        player:messageSpecial(laTheineID.text.UNLOCK_CARBUNCLE)

                        -- Set rainbow to appear.
                        local rainbow = GetNPCByID(laTheineID.npc.RAINBOW)
                        if rainbow then
                            rainbow:setLocalVar('setRainbow', 1)
                        end
                    end
                end,
            },
        },
    },
}

return quest
