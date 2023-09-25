-----------------------------------
-- The Lost Avatar
-- Rhapsodies of Vana'diel Mission 1-16
-----------------------------------
-- !addmission 13 36
-- qm11 : !pos -409.553 17.356 -380.626 123
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local yuhtungaID = require("scripts/zones/Yuhtunga_Jungle/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_LOST_AVATAR)

mission.reward =
{
    keyItem     = xi.ki.RHAPSODY_IN_AZURE,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.VOLTO_OSCURO },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['qm11'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(213)
                    else
                        if npcUtil.popFromQM(player, npc, yuhtungaID.mob.SIREN, { look = true, hide = 0 }) then
                            return mission:messageSpecial(yuhtungaID.text.SENSE_OF_FOREBODING)
                        else
                            return mission:messageSpecial(yuhtungaID.text.NOW_IS_NOT_THE_TIME)
                        end
                    end
                end,
            },

            ['Siren'] =
            {
                onMobDeath = function(mob, player, optParams)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },

            onEventFinish =
            {
                [213] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
