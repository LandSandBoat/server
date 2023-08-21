-----------------------------------
-- Prelude to a Storm
-- Wings of the Goddess Mission 31
-----------------------------------
-- !addmission 5 30
-- Rally Point: Green : !pos 54.013 -23.402 -203.103 137
-- Spell-worked Snow  : !pos 75.989 -24.249 -248.089 137
-----------------------------------
local pastXarcabardID = zones[xi.zone.XARCABARD_S]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.PRELUDE_TO_A_STORM)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.STORMS_CRESCENDO },
}

local rewardItems =
{
    xi.item.ELIXIR,
    xi.item.VILE_ELIXIR,
    xi.item.VILE_ELIXIR_P1,
}

-- NOTE: Instance is triggered at the Spell-Worked Snow behind the Green Rally point, and
-- observed Event 27, Params 0, 30

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
                    player:messageName(pastXarcabardID.text.REQUIRED_TO_DELIVER, nil)

                    return mission:noAction()
                end,
            },

            ['Rally_Point_Green'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(21, 137, 300, 200, 100, 0, 6553620, 0, 0)
                    elseif missionStatus == 1 then
                        if player:hasKeyItem(xi.ki.MAGELIGHT_SIGNAL_FLARE) then
                            player:messageName(pastXarcabardID.text.HELP_FEDERATION_PREPARE, nil)

                            return mission:noAction()
                        else
                            return mission:progressEvent(25, 137, 23, 2963)
                        end
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 22
                    end
                end,
            },

            onEventUpdate =
            {
                [22] = function(player, csid, option, npc)
                    if option == 13 then
                        player:updateEvent(0, 23, 1756, 0, 0, 0, 0, 2)
                    end
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAGELIGHT_SIGNAL_FLARE)
                    mission:setVar(player, 'Status', 1)
                end,

                [22] = function(player, csid, option, npc)
                    local rewardItemID = mission:getVar(player, 'Option')

                    if npcUtil.giveItem(player, rewardItems[rewardItemID]) then
                        mission:complete(player)
                    end
                end,

                [25] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAGELIGHT_SIGNAL_FLARE)
                end,
            },
        },

        [xi.zone.GHOYUS_REVERIE] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    -- TODO: The assumption for this mission script is to catch Event 10000 which is
                    -- sent once the battlefield has been cleared.  This needs to be verified upon
                    -- implementation of the instance.

                    -- Given time remaining in instance, will also need to set a the 'Option' var from
                    -- 1..3 in order to determine the reward.  Guess is 10min intervals to determine
                    -- highest tier reward: math.floor(minRemaining / 10) + 1

                    mission:setVar(player, 'Status', 2)
                    player:setPos(96.77, -23.943, -277.87, 253, xi.zone.XARCABARD_S)
                end,
            },
        },
    },
}

return mission
