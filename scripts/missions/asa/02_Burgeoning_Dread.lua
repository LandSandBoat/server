-----------------------------------
-- Burgeoning Dread
-- A Shantotto Ascension M2
-----------------------------------
-- !addmission 11 1
-----------------------------------
require('scripts/globals/missions')
require('scripts/settings/main')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- Zone into either East Sarutabaruta or West Sarutabaruta via one of Windurst's gates for a cutscene.
        [xi.zone.EAST_SARUTABARUTA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.WINDURST_WOODS then
                        return mission:event(71)
                    end
                end,
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.WINDURST_WATERS or
                        prevZone == xi.zone.PORT_WINDURST
                    then
                        return mission:event(510)
                    end
                end,
            },

            onEventFinish =
            {
                [514] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
