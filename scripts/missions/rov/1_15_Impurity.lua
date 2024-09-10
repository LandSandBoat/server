-----------------------------------
-- Impurity
-- Rhapsodies of Vana'diel Mission 1-15
-----------------------------------
-- !addmission 13 34
-- qm11 : !pos -409.553 17.356 -380.626 123
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.IMPURITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_LOST_AVATAR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['qm11'] = mission:progressEvent(212),

            onEventFinish =
            {
                [212] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
