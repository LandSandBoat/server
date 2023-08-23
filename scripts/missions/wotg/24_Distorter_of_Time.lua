-----------------------------------
-- Distorter of Time
-- Wings of the Goddess Mission 24
-----------------------------------
-- !addmission 5 23
-- Regal Pawprints (9) : !pos 54.437 -41.904 104.974 136
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.DISTORTER_OF_TIME)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_WILL_OF_THE_WORLD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            ['Regal_Pawprints_1'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.UMBRA_BUG) and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        -- TODO: For future Instance implementation, on instance fail,
                        -- Timer var should be set to VanadielUniqueDay() + 1

                        return mission:progressEvent(26, 136, 23, 1756)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 19
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [26] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.UMBRA_BUG)
                end,
            },
        },

        [xi.zone.RUHOTZ_SILVERMINES] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    -- TODO: The assumption for this mission script is to catch Event 10000 which is
                    -- sent once the battlefield has been cleared.  This needs to be verified upon
                    -- implementation of the instance.

                    mission:setVar(player, 'Status', 1)
                    player:setPos(51.641, -41.230, 98.680, 0, xi.zone.BEAUCEDINE_GLACIER_S)
                end,
            },
        },
    },
}

return mission
