-----------------------------------
-- The Seventh Guardian
-- Seekers of Adoulin M5-3-1
-----------------------------------
-- !addmission 12 117
-- Levil          : !pos -87.204 3.350 12.655 256
-- Yeggha_Dolashi : !pos 260 -5.768 60 258
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_SEVENTH_GUARDIAN)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.WATERY_GRAVE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 5, 0, 0, 0, 0, 4),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Yeggha_Dolashi'] = mission:progressEvent(374, 258, 3642015, 1756, 0, utils.MAX_UINT32 - 133696, utils.MAX_UINT32 - 796, 433102, 8),

            onEventUpdate =
            {
                [374] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(1, 0, 1756, 0, utils.MAX_UINT32 - 796, 433102, 8)
                    end
                end,
            },

            onEventFinish =
            {
                [374] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
