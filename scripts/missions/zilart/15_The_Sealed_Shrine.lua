-----------------------------------
-- The Sealed Shrine
-- Zilart M15
-----------------------------------
-- !addmission 3 27
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-- Aldo              : !pos 20 3 -58 245
-- DM Earring        : !additem 14739
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require('scripts/globals/settings')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE)

local function getNumDMEarrings(player)
    local DMEarrings = 0
    for i = 14739, 14743 do
        if (player:hasItem(i)) then
            DMEarrings = DMEarrings + 1
        end
    end
    return DMEarrings
end

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0 and getNumDMEarrings(player) <= NUMBER_OF_DM_EARRINGS
        end,

        [xi.zone.NORG] =
        {
            ['_700'] = mission:progressEvent(172),

            onEventFinish =
            {
                [172] = function(player, csid, option, npc)
                    if bit.band(option, 0x40000000) == 0 then
                        player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:event(111),
        },

        [xi.zone.THE_SHRINE_OF_RUAVITAU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                     -- Entered through the Main Gate
                    if
                        xPos >= -45 and yPos >= -4 and zPos >= -240 and
                        xPos <= -33 and yPos <= 0 and zPos <= -226 and
                        getNumDMEarrings(player) <= NUMBER_OF_DM_EARRINGS
                    then
                        return 51
                    end
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 0)
                    mission:complete()
                end,
            },
        },
    },
}

return mission
