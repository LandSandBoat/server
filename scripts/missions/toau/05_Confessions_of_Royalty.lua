-----------------------------------
-- Confessions of Royalty
-- Aht Uhrgan Mission 5
-----------------------------------
-- !addmission 4 4
-- Halver : !pos 2 0.1 0.1 233
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.EASTERLY_WINDS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.RAILLEFALS_LETTER) then
                        return mission:progressEvent(564)
                    end
                end,
            },

            onEventFinish =
            {
                [564] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.RAILLEFALS_LETTER)
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
