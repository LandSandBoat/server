-----------------------------------
-- Eddies of Despair (I)
-- Rhapsodies of Vana'diel Mission 1-10
-----------------------------------
-- !addmission 13 22
-- Undulating Confluence : !pos -204.531 -20.027 75.318 126
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/teleports')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_I)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.A_LAND_AFTER_TIME },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Undulating_Confluence'] = mission:event(64):setPriority(1005),

            onEventFinish =
            {
                [64] = function(player, csid, option, npc)
                    xi.teleport.to(player, xi.teleport.id.ESCHA_ZITAH)
                end,
            },
        },

        [xi.zone.ESCHA_ZITAH] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 1
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
