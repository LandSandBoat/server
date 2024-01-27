-----------------------------------
-- Yggdrasil
-- Seekers of Adoulin M2-7-3
-----------------------------------
-- !addmission 12 35
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/missions/soa/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.YGGDRASIL)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.RETURN_OF_THE_EXORCIST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                onTrigger = function(player, npc)
                    if
                        xi.soa.helpers.imprimaturGate(player, 30) and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        local hasDeclined = player:getMissionStatus(mission.areaId)

                        return mission:progressEvent(129, 268, hasDeclined)
                    else
                        return mission:event(126, 238)
                    end
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                    else
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },
    },
}

return mission
