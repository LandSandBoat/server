-----------------------------------
-- I Can Hear a Rainbow
-----------------------------------
require("scripts/globals/weather")
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
        zones =
        {
            [tpz.zone.VALKURM_DUNES] = true,
            [tpz.zone.ROLANBERRY_FIELDS] = true,
            [tpz.zone.CAPE_TERIGGAN] = true,
            [tpz.zone.EASTERN_ALTEPA_DESERT] = true,
            [tpz.zone.MERIPHATAUD_MOUNTAINS] = true,
            [tpz.zone.YUHTUNGA_JUNGLE] = true,
            [tpz.zone.YHOATOR_JUNGLE] = true,
            [tpz.zone.WESTERN_ALTEPA_DESERT] = true,
        },
    },
    [tpz.weather.NONE] =
    {
        bit = 1,
        zones =
        {
            [tpz.zone.WEST_RONFAURE] = true,
            [tpz.zone.EAST_RONFAURE] = true,
            [tpz.zone.NORTH_GUSTABERG] = true,
            [tpz.zone.SOUTH_GUSTABERG] = true,
            [tpz.zone.EASTERN_ALTEPA_DESERT] = true,
            [tpz.zone.WEST_SARUTABARUTA] = true,
            [tpz.zone.EAST_SARUTABARUTA] = true,
            [tpz.zone.BUBURIMU_PENINSULA] = true,
            [tpz.zone.YHOATOR_JUNGLE] = true,
        },
    },
    [tpz.weather.DUST_STORM] =
    {
        bit = 2,
        zones =
        {
            [tpz.zone.VALKURM_DUNES] = true,
            [tpz.zone.BATALLIA_DOWNS] = true,
            [tpz.zone.KONSCHTAT_HIGHLANDS] = true,
            [tpz.zone.EASTERN_ALTEPA_DESERT] = true,
            [tpz.zone.TAHRONGI_CANYON] = true,
            [tpz.zone.MERIPHATAUD_MOUNTAINS] = true,
            [tpz.zone.SAUROMUGUE_CHAMPAIGN] = true,
            [tpz.zone.WESTERN_ALTEPA_DESERT] = true,
        },
    },
    [tpz.weather.WIND] =
    {
        bit = 3,
        zones =
        {
            [tpz.zone.LA_THEINE_PLATEAU] = true,
            [tpz.zone.CAPE_TERIGGAN] = true,
            [tpz.zone.TAHRONGI_CANYON] = true,
            [tpz.zone.BUBURIMU_PENINSULA] = true,
        },
    },
    [tpz.weather.RAIN] =
    {
        bit = 4,
        zones =
        {
            [tpz.zone.LA_THEINE_PLATEAU] = true,
            [tpz.zone.JUGNER_FOREST] = true,
            [tpz.zone.PASHHOW_MARSHLANDS] = true,
            [tpz.zone.ROLANBERRY_FIELDS] = true,
            [tpz.zone.BUBURIMU_PENINSULA] = true,
            [tpz.zone.THE_SANCTUARY_OF_ZITAH] = true,
            [tpz.zone.YUHTUNGA_JUNGLE] = true,
            [tpz.zone.YHOATOR_JUNGLE] = true,
        },
    },
    [tpz.weather.SNOW] =
    {
        bit = 5,
        zones =
        {
            [tpz.zone.BATALLIA_DOWNS] = true,
            [tpz.zone.BEAUCEDINE_GLACIER] = true,
            [tpz.zone.XARCABARD] = true,
        },
    },
    [tpz.weather.THUNDER] =
    {
        bit = 6,
        zones =
        {
            [tpz.zone.JUGNER_FOREST] = true,
            [tpz.zone.KONSCHTAT_HIGHLANDS] = true,
            [tpz.zone.PASHHOW_MARSHLANDS] = true,
            [tpz.zone.SAUROMUGUE_CHAMPAIGN] = true,
            [tpz.zone.THE_SANCTUARY_OF_ZITAH] = true,
        },
    },
}

-------------------------------------------------
-- public functions
-------------------------------------------------

quests.i_can_hear_a_rainbow.onZoneIn = function(player)
    if player:hasItem(1125, 0) and player:getQuestStatus(WINDURST, tpz.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED then
        local trigger = false

        -- get data for basic weather (e.g. downgrade GALES to WIND)
        local weather = player:getWeather()
        local baseWeather = (weather % 2 == 0) and weather or weather - 1
        local data = rubyData[baseWeather]

        if data and data.zones[player:getZoneID()] then
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
