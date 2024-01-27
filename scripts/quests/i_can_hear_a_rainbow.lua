-----------------------------------
-- I Can Hear a Rainbow
-----------------------------------

quests = quests or {}
quests.i_can_hear_a_rainbow = quests.i_can_hear_a_rainbow or {}

-----------------------------------
-- local data
-----------------------------------

local rubyData =
{
    [xi.weather.HOT_SPELL] =
    {
        bit = 0,
        zones = set{
            xi.zone.VALKURM_DUNES,
            xi.zone.ROLANBERRY_FIELDS,
            xi.zone.CAPE_TERIGGAN,
            xi.zone.EASTERN_ALTEPA_DESERT,
            xi.zone.MERIPHATAUD_MOUNTAINS,
            xi.zone.YUHTUNGA_JUNGLE,
            xi.zone.YHOATOR_JUNGLE,
            xi.zone.WESTERN_ALTEPA_DESERT,
        },
    },
    [xi.weather.NONE] =
    {
        bit = 1,
        zones = set{
            xi.zone.WEST_RONFAURE,
            xi.zone.EAST_RONFAURE,
            xi.zone.NORTH_GUSTABERG,
            xi.zone.SOUTH_GUSTABERG,
            xi.zone.EASTERN_ALTEPA_DESERT,
            xi.zone.WEST_SARUTABARUTA,
            xi.zone.EAST_SARUTABARUTA,
            xi.zone.BUBURIMU_PENINSULA,
            xi.zone.YHOATOR_JUNGLE,
        },
    },
    [xi.weather.DUST_STORM] =
    {
        bit = 2,
        zones = set{
            xi.zone.VALKURM_DUNES,
            xi.zone.BATALLIA_DOWNS,
            xi.zone.KONSCHTAT_HIGHLANDS,
            xi.zone.EASTERN_ALTEPA_DESERT,
            xi.zone.TAHRONGI_CANYON,
            xi.zone.MERIPHATAUD_MOUNTAINS,
            xi.zone.SAUROMUGUE_CHAMPAIGN,
            xi.zone.WESTERN_ALTEPA_DESERT,
        },
    },
    [xi.weather.WIND] =
    {
        bit = 3,
        zones = set{
            xi.zone.LA_THEINE_PLATEAU,
            xi.zone.CAPE_TERIGGAN,
            xi.zone.TAHRONGI_CANYON,
            xi.zone.BUBURIMU_PENINSULA,
        },
    },
    [xi.weather.RAIN] =
    {
        bit = 4,
        zones = set{
            xi.zone.LA_THEINE_PLATEAU,
            xi.zone.JUGNER_FOREST,
            xi.zone.PASHHOW_MARSHLANDS,
            xi.zone.ROLANBERRY_FIELDS,
            xi.zone.BUBURIMU_PENINSULA,
            xi.zone.THE_SANCTUARY_OF_ZITAH,
            xi.zone.YUHTUNGA_JUNGLE,
            xi.zone.YHOATOR_JUNGLE,
        },
    },
    [xi.weather.SNOW] =
    {
        bit = 5,
        zones = set{
            xi.zone.BATALLIA_DOWNS,
            xi.zone.BEAUCEDINE_GLACIER,
            xi.zone.XARCABARD,
        },
    },
    [xi.weather.THUNDER] =
    {
        bit = 6,
        zones = set{
            xi.zone.JUGNER_FOREST,
            xi.zone.KONSCHTAT_HIGHLANDS,
            xi.zone.PASHHOW_MARSHLANDS,
            xi.zone.SAUROMUGUE_CHAMPAIGN,
            xi.zone.THE_SANCTUARY_OF_ZITAH,
        },
    },
}

-----------------------------------
-- public functions
-----------------------------------

quests.i_can_hear_a_rainbow.onZoneIn = function(player)
    if
        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED and
        player:hasItem(xi.item.CARBUNCLES_RUBY, 0)
    then
        local trigger = false

        -- get data for basic weather (e.g. downgrade GALES to WIND)
        local zone = player:getZone(true)
        if not zone then
            return false
        end

        local weather = zone:getWeather()
        if not weather then
            return false
        end

        local baseWeather = (weather % 2 == 0) and weather or weather - 1
        local data = rubyData[baseWeather]

        if data and data.zones[zone:getID()] then
            local mask = player:getCharVar('I_CAN_HEAR_A_RAINBOW')
            local hasColor = utils.mask.getBit(mask, data.bit)

            if not hasColor then
                trigger = true
                player:setCharVar('I_CAN_HEAR_A_RAINBOW', utils.mask.setBit(mask, data.bit, true))
                player:setLocalVar('[rainbow]weather', weather)
            end
        end

        return trigger
    end
end

quests.i_can_hear_a_rainbow.onEventUpdate = function(player)
    local weather = player:getLocalVar('[rainbow]weather')

    -- in some zones the light cutscene does not handle xi.weather.SUNSHINE properly
    if weather == xi.weather.SUNSHINE then
        weather = xi.weather.NONE
    end

    if utils.mask.isFull(player:getCharVar('I_CAN_HEAR_A_RAINBOW'), 7) then -- has collected all 7 colors?
        player:updateEvent(0, 0, weather, 6)
    else
        player:updateEvent(0, 0, weather)
    end
end

-- shorthand
quests.rainbow = quests.i_can_hear_a_rainbow
