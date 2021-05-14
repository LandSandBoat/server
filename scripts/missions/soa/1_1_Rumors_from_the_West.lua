-----------------------------------
-- Rumors from the West
-- Seekers of Adoulin M1-1
-----------------------------------
-- !addmission 12 0
-- Darcia : !pos 25 -38.617 -1.000 245
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.THE_GEOMAGNETRON },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and ENABLE_SOA == 1
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Darcia'] =
            {
                onTrigger = function(player, npc)
                    local turnOffNevermind      = 1
                    local turnOffApply          = 2
                    local turnOffSystemInfo     = 4
                    local turnOffDungeonInfo    = 8
                    local turnOffOptionToPay    = 16
                    local turnOffAskingForWork  = 32

                    return mission:progressEvent(10117, 0, turnOffDungeonInfo + turnOffAskingForWork)
                end,

                onEventUpdate = function(player, csid, option)
                    if csid == 10117 then
                        local hasEnoughGil = player:getGil() >= 1000000 and 1 or 0
                        player:updateEvent(hasEnoughGil)
                    end
                end
            },

            onEventFinish =
            {
                [10117] = function(player, csid, option, npc)
                    if mission:complete(player) then

                    end
                end,
            },
        },
    },
}

return mission
