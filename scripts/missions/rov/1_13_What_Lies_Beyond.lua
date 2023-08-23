-----------------------------------
-- What Lies Beyond
-- Rhapsodies of Vana'diel Mission 1-13
-----------------------------------
-- !addmission 13 30
-- Oaken Door : !pos 97 -7 -12 252
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_TIES_THAT_BIND },
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
                    return mission:progressEvent(278, { [5] = mission:getVar(player, 'wasBlocked') }):setPriority(1005)
                end,
            },

            ['Comitiolus'] = mission:event(6),

            onEventFinish =
            {
                [278] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
