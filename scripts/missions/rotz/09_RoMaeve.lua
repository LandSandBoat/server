-----------------------------------
-- Ro'Maeve
-- Zilart M9
-----------------------------------
-- !addmission 3 18
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-- Aldo              : !pos 20 3 -58 245
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.ROMAEVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(84)
                    else
                        return mission:event(24)
                    end
                end,
            },

            onEventFinish =
            {
                [84] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['_700'] = mission:progressEvent(3),

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if option == 0 then
                        -- NOTE: Event should move player to 99.789, -7.086, -11.999, 126 (Norg)
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
