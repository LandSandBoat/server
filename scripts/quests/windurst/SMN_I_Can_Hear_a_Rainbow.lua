-----------------------------------
-- I Can Hear a Rainbow
-----------------------------------
-- Log ID: 2, Quest ID: 75
-----------------------------------
local laTheineID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER)

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

local function handleZoneIn(player, eventId)
    if player:hasItem(xi.item.CARBUNCLES_RUBY, xi.inventoryLocation.INVENTORY) then
        local zone    = player:getZone()
        local weather = zone:getWeather()

        if validWeatherTable[weather] then
            local lightBitMask = player:getCharVar('Quest[2][75]Light')
            local element      = xi.combat.element.getWeatherElement(weather)
            if not utils.mask.getBit(lightBitMask, element) then
                return eventId
            end
        end
    end
end

local function handleEventUpdate(player, csid, option, npc)
    local weather      = player:getZone():getWeather()
    local lightBitMask = player:getCharVar('Quest[2][75]Light')
    local lightCounter = 0

    for bit = 0, 6 do
        if utils.mask.getBit(lightBitMask, bit) then
            lightCounter = lightCounter + 1
        end
    end

    -- If this is the last one.
    if lightCounter >= 6 then
        player:setCharVar('Quest[2][75]Prog', 1)
    end

    player:updateEvent(0, 1, weather, lightCounter)
end

local function handleEventFinish(player, csid, option, npc)
    local weather      = player:getZone():getWeather()
    local lightBitMask = player:getCharVar('Quest[2][75]Light')
    local element      = xi.combat.element.getWeatherElement(weather)

    player:setCharVar('Quest[2][75]Light', utils.mask.setBit(lightBitMask, element, true))
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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 51)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 21)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 244)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 901)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 48)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 50)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 123)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 104)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 35)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 3)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 3)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 15)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 901)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 13)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 2)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 31)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 3)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 114)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 9)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 11)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 2)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 2)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 2)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 2)
            end,

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
            onZoneIn = function(player, prevZone)
                return handleZoneIn(player, 2)
            end,

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
