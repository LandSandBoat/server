-----------------------------------
-- Welcome t'Norg
-- Zilart M2
-----------------------------------
-- !addmission 3 4
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS },
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
                    return mission:progressEvent(2)
                end,
            },

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(252, 0, 1, utils.MAX_UINT32 - 72454152, 66977791, 222376875, 4031, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 0 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
