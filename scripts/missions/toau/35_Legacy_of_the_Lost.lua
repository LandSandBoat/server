-----------------------------------
-- Legacy of the Lost
-- Aht Uhrgan Mission 35
-----------------------------------
-- !addmission 4 34
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.LEGACY_OF_THE_LOST)

mission.reward =
{
    title       = xi.title.GESSHOS_MERCY,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.GAZE_OF_THE_SABOTEUR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TALACCA_COVE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 1092 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
