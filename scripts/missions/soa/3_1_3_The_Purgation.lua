-----------------------------------
-- The Purgation
-- Seekers of Adoulin M3-1-3
-----------------------------------
-- !addmission 12 40
-- Erminold : !pos 50.949 -40 -90.942 257
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_PURGATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_KEY },
}

local purgationKeyItems =
{
    xi.ki.ETERNAL_FLAME,
    xi.ki.VIAL_OF_UNTAINTED_HOLY_WATER,
    xi.ki.PIECE_OF_A_STONE_WALL,
    xi.ki.WEATHER_VANE_WINGS,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            -- TODO: Continue to check if Levil's dialogue changes.  This event has been
            -- repeated for several missions.

            ['Levil'] = mission:event(138),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Erminold'] = mission:event(1526):replaceDefault(),

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(1510)
                end,
            },

            onEventFinish =
            {
                [1510] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.THE_KEY, 'Timer', VanadielUniqueDay() + 1)

                        for _, keyItem in ipairs(purgationKeyItems) do
                            player:delKeyItem(keyItem)
                        end
                    end
                end,
            },
        },
    },
}

return mission
