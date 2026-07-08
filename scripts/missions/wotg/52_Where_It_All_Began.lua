-----------------------------------
-- Where It All Began
-- Wings of the Goddess Mission 52
-----------------------------------
-- !addmission 5 51
-- Lion Springs Door : !pos 96 0 106 80
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.WHERE_IT_ALL_BEGAN)

mission.reward =
{
    keyItem     = xi.ki.WEDDING_INVITATION,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_TOKEN_OF_TROTH },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(175, 80, 72),

            onEventFinish =
            {
                [175] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
