-----------------------------------
-- Storm's Crescendo
-- Wings of the Goddess Mission 32
-----------------------------------
-- !addmission 5 31
-- Rally Point: Green : !pos 54.013 -23.402 -203.103 137
-----------------------------------
local pastXarcabardID = zones[xi.zone.XARCABARD_S]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.STORMS_CRESCENDO)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.INTO_THE_BEASTS_MAW },
}

-- NOTE: Instance entry at Excavated Snow is Event 28, Params 0, 31

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.XARCABARD_S] =
        {
            ['Rally_Point_Green'] =
            {
                onTrigger = function(player, npc)
                    player:messageName(pastXarcabardID.text.FEDERATION_COMPLETE, nil)

                    return mission:noAction()
                end,
            },

            ['Rally_Point_Blue'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(19, player:getCampaignAllegiance(), 23, 1756, 400, 67108863, 659255957, 4905, 0)
                    elseif missionStatus == 1 then
                        if not player:hasKeyItem(xi.ki.ALCHEMICAL_SIGNAL_FLARE) then
                            if mission:getVar(player, 'Timer') <= VanadielUniqueDay() then
                                return mission:progressEvent(26, 137, 23, 2964)
                            else
                                player:messageName(pastXarcabardID.text.BASTOKAN_OFFICER_GONE, nil)
                            end
                        else
                            player:messageName(pastXarcabardID.text.HELP_REPUBLIC_PREPARE, nil)
                        end
                    elseif missionStatus == 3 then
                        player:messageName(pastXarcabardID.text.COMPLETED_TASKS, nil)
                    end

                    return mission:noAction()
                end,
            },

            ['Rally_Point_Red'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 3 then
                        return mission:progressEvent(23, 137, 5)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 2 then
                        return 20
                    elseif missionStatus == 4 then
                        return 39
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ALCHEMICAL_SIGNAL_FLARE)
                    mission:setVar(player, 'Status', 1)
                end,

                [20] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                end,

                [23] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 4)
                    player:setPos(-105.798, -25.522, -53.499, 176, xi.zone.XARCABARD_S)
                end,

                [26] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ALCHEMICAL_SIGNAL_FLARE)
                end,

                [39] = function(player, csid, option, npc)
                    mission:complete(player)
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

                    mission:setVar(player, 'Status', 2)
                    player:setPos(138.527, -16.197, -30.414, 211, xi.zone.XARCABARD_S)
                end,
            },
        },
    },
}

return mission
