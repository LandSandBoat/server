-----------------------------------
-- Volto Oscuro
-- Rhapsodies of Vana'diel Mission 1-17
-----------------------------------
-- !addmission 13 40
-- Oaken Door : !pos 97 -7 -12 252
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.VOLTO_OSCURO)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.RING_MY_BELL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'hasSeenEvent') == 0 then
                        return mission:event(279):setPriority(1005)
                    else
                        mission:complete(player)
                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [279] = function(player, csid, option, npc)
                    if not mission:complete(player) then
                        mission:setVar(player, 'hasSeenEvent', 1)
                    end
                end,
            },
        },
    },
}

return mission
