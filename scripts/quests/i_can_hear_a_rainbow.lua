-----------------------------------
-- I Can Hear a Rainbow
-----------------------------------
require("scripts/globals/weather")
require("scripts/globals/common")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------

quests = quests or {}
quests.i_can_hear_a_rainbow = quests.i_can_hear_a_rainbow or {}

-------------------------------------------------
-- local data
-------------------------------------------------

local rubyData =
{
    [tpz.weather.HOT_SPELL] =
    {
        bit = 0,
        zones = set{
            tpz.zone.VALKURM_DUNES,
            tpz.zone.ROLANBERRY_FIELDS,
            tpz.zone.CAPE_TERIGGAN,
            tpz.zone.EASTERN_ALTEPA_DESERT,
            tpz.zone.MERIPHATAUD_MOUNTAINS,
            tpz.zone.YUHTUNGA_JUNGLE,
            tpz.zone.YHOATOR_JUNGLE,
            tpz.zone.WESTERN_ALTEPA_DESERT,
        },
    },
    [tpz.weather.NONE] =
    {
        bit = 1,
        zones = set{
            tpz.zone.WEST_RONFAURE,
            tpz.zone.EAST_RONFAURE,
            tpz.zone.NORTH_GUSTABERG,
            tpz.zone.SOUTH_GUSTABERG,
            tpz.zone.EASTERN_ALTEPA_DESERT,
            tpz.zone.WEST_SARUTABARUTA,
            tpz.zone.EAST_SARUTABARUTA,
            tpz.zone.BUBURIMU_PENINSULA,
            tpz.zone.YHOATOR_JUNGLE,
        },
    },
    [tpz.weather.DUST_STORM] =
    {
        bit = 2,
        zones = set{
            tpz.zone.VALKURM_DUNES,
            tpz.zone.BATALLIA_DOWNS,
            tpz.zone.KONSCHTAT_HIGHLANDS,
            tpz.zone.EASTERN_ALTEPA_DESERT,
            tpz.zone.TAHRONGI_CANYON,
            tpz.zone.MERIPHATAUD_MOUNTAINS,
            tpz.zone.SAUROMUGUE_CHAMPAIGN,
            tpz.zone.WESTERN_ALTEPA_DESERT,
        },
    },
    [tpz.weather.WIND] =
    {
        bit = 3,
        zones = set{
            tpz.zone.LA_THEINE_PLATEAU,
            tpz.zone.CAPE_TERIGGAN,
            tpz.zone.TAHRONGI_CANYON,
            tpz.zone.BUBURIMU_PENINSULA,
        },
    },
    [tpz.weather.RAIN] =
    {
        bit = 4,
        zones = set{
            tpz.zone.LA_THEINE_PLATEAU,
            tpz.zone.JUGNER_FOREST,
            tpz.zone.PASHHOW_MARSHLANDS,
            tpz.zone.ROLANBERRY_FIELDS,
            tpz.zone.BUBURIMU_PENINSULA,
            tpz.zone.THE_SANCTUARY_OF_ZITAH,
            tpz.zone.YUHTUNGA_JUNGLE,
            tpz.zone.YHOATOR_JUNGLE,
        },
    },
    [tpz.weather.SNOW] =
    {
        bit = 5,
        zones = set{
            tpz.zone.BATALLIA_DOWNS,
            tpz.zone.BEAUCEDINE_GLACIER,
            tpz.zone.XARCABARD,
        },
    },
    [tpz.weather.THUNDER] =
    {
        bit = 6,
        zones = set{
            tpz.zone.JUGNER_FOREST,
            tpz.zone.KONSCHTAT_HIGHLANDS,
            tpz.zone.PASHHOW_MARSHLANDS,
            tpz.zone.SAUROMUGUE_CHAMPAIGN,
            tpz.zone.THE_SANCTUARY_OF_ZITAH,
        },
    },
}

-------------------------------------------------
-- public functions
-------------------------------------------------

quests.i_can_hear_a_rainbow.onZoneIn = function(player)
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED and player:hasItem(1125, 0) then
        local trigger = false

        -- get data for basic weather (e.g. downgrade GALES to WIND)
        local zone = player:getZone(true)
        if not zone then return false end

        local weather = zone:getWeather()
        if not weather then return false end

        local baseWeather = (weather % 2 == 0) and weather or weather - 1
        local data = rubyData[baseWeather]

        if data and data.zones[zone:getID()] then
            local mask = player:getCharVar('I_CAN_HEAR_A_RAINBOW')
            local needsColor = bit.band(mask, 2^data.bit) == 0

            if needsColor then
                trigger = true
                player:setCharVar('I_CAN_HEAR_A_RAINBOW', bit.bor(mask, 2^data.bit))
                player:setLocalVar('[rainbow]weather', weather)
            end
        end

        return trigger
    end
end

quests.i_can_hear_a_rainbow.onEventUpdate = function(player)
    local weather = player:getLocalVar('[rainbow]weather')

    -- in some zones the light cutscene does not handle tpz.weather.SUNSHINE properly
    if weather == tpz.weather.SUNSHINE then
        weather = tpz.weather.NONE
    end

    if player:getCharVar("I_CAN_HEAR_A_RAINBOW") < 127 then
        player:updateEvent(0, 0, weather)
    else
        player:updateEvent(0, 0, weather, 6)
    end
end

-- shorthand
quests.rainbow = quests.i_can_hear_a_rainbow
