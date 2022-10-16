-----------------------------------
-- The Decisive Heroine
-- Rhapsodies of Vana'diel Mission 2-30
-----------------------------------
-- !addmission 13 114
-- qm_rov2_30 : !pos -46.955 -40 -419.356 289
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_DECISIVE_HEROINE)

mission.reward =
{
    keyItem     = xi.ki.SIRENS_PLUME,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.FALL_FROM_GRACE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ESCHA_RUAUN] =
        {
            ['qm_rov2_30'] = mission:progressEvent(4, 289, 300, 200, 100, utils.MAX_UINT32 - 167924, utils.MAX_UINT32 - 780, 630078, 0),

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        npcUtil.giveKeyItem(player, xi.ki.RHAPSODY_IN_EMERALD)
                    end
                end,
            },
        },
    },
}

return mission
