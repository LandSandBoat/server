-----------------------------------
-- Another World
-- Wings of the Goddess Mission 28
-----------------------------------
-- !addmission 5 27
-- Halver : !pos 2 0.1 0.1 233
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.ANOTHER_WORLD)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_HAWK_IN_REPOSE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.EAST_RONFAURE then
                        return 945
                    end
                end,
            },

            onEventFinish =
            {
                [945] = function(player, csid, option, npc)
                    mission:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Prog') == 1 then
                        -- TODO: Compare the last two parameters if the player is aligned to Bastok
                        -- or Windurst for Campaign Allegiance.  These values may change.

                        return mission:progressEvent(566, 233, 23, 1756, 0, 0, 0, 1, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [566] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
