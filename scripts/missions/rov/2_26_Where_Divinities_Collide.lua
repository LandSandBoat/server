-----------------------------------
-- Where Divinities Collide
-- Rhapsodies of Vana'diel Mission 2-26
-----------------------------------
-- !addmission 13 104
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.WHERE_DIVINITIES_COLLIDE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.VISIONS_OF_DREAD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HALL_OF_TRANSFERENCE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return 2
                    elseif missionStatus == 1 then
                        return 4
                    end
                end,
            },

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(1, 23, 1756, 2100)
                    end
                end,

                [4] = function(player, csid, option, npc)
                    player:updateEvent(1, 1, 1756, 2100)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)

                    local currentPos = player:getPos()
                    player:setPos(currentPos['x'], currentPos['y'], currentPos['z'], currentPos['rot'], xi.zone.HALL_OF_TRANSFERENCE)
                end,

                [4] = function(player, csid, option, npc)
                    mission:complete(player)

                    player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.VISIONS_OF_DREAD)
                    player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.VISIONS_OF_DREAD)

                    player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.TO_THE_SKIES)
                end,
            },
        },
    },
}

return mission
