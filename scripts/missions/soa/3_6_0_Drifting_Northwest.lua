-----------------------------------
-- Drifting Northwest
-- Seekers of Adoulin M3-6
-----------------------------------
-- !addmission 12 62
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local kamihrID = require('scripts/zones/Kamihr_Drifts/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.DRIFTING_NORTHWEST)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.KUMHAU_THE_FLASHFROST_NAAKUAL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(144),
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 29
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.TINTINNABULUM)
                        player:messageSpecial(kamihrID.text.LOST_KEYITEM, xi.ki.TINTINNABULUM)
                    end
                end,
            },
        },
    },
}

return mission
