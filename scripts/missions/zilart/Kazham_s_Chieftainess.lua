-----------------------------------
-- Kazham's Chieftainess
-- Zilart M3
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS)

mission.reward =
{
    keyItem     = xi.ki.SACRIFICIAL_CHAMBER_KEY,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(7)
                end,
            },
        },

        [xi.zone.KAZHAM] = {
            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(114)
                end,
            },

            onEventFinish =
            {
                [114] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
