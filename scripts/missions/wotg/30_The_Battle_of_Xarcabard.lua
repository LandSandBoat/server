-----------------------------------
-- The Battle of Xarcabard
-- Wings of the Goddess Mission 30
-----------------------------------
-- !addmission 5 29
-- Rally Point: Red : !pos -106.071 -25.5 -52.841 137
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_BATTLE_OF_XARCABARD)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.PRELUDE_TO_A_STORM },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.XARCABARD_S] =
        {
            ['Rally_Point_Red'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        -- TODO: Compare the last parameter if the player is aligned to Bastok
                        -- or Windurst for Campaign Allegiance.  This value may change.
                        return mission:progressEvent(18, 0, 5, 0, 0, 0, 0, 0, 1)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 0 then
                        return 17
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [18] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
