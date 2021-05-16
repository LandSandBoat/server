-----------------------------------
-- A Timeswept Butterfly
-- Wings of the Goddess Mission 6
-----------------------------------
-- TODO:
-- !addmission 4 0
-- Cavernous Maws:
-- Batallia Downs       : !pos -48 0.1 435 105
-- Rolanberry Fields    : !pos -198 8 361 110
-- Sauromugue Champaign : !pos 369 8 -227 120
-----------------------------------
require("scripts/globals/keyitems")
require('scripts/globals/maws')
require('scripts/globals/missions')
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_TIMESWEPT_BUTTERFLY)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LA_VAULE_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.JUGNER_FOREST_S then
                        return mission:event(510)
                    end
                end,
            },

            onEventFinish =
            {
                [510] = function(player, csid, option, npc)
                    if mission:complete() then
                        return mission:event(514)
                    end
                end,
            },
        },
    },
}

return mission
