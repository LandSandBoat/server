-----------------------------------
-- Sacrifice
-- Rhapsodies of Vana'diel Mission 2-17
-----------------------------------
-- !addmission 13 83
-- Ornate Door (_521) : !pos -700 -20.25 -303.398 89
-----------------------------------
local walkOfEchoesID = zones[xi.zone.WALK_OF_ECHOES]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.SACRIFICE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.SOMBER_DREAMS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WALK_OF_ECHOES] =
        {
            ['_521'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: These initial checks are intentional fallthroughs to other potential calls to allow for the message to
                    -- be displayed and still trigger other events or default action to match retail behavior.  This also implements
                    -- a non-retail behavior by displaying the proper message for "Champion of the Dawn" blocking status, in which
                    -- retail displays "A Forbidden Reunion" for both blocking quests.

                    if mission:getVar(player, 'Status') <= 1 then
                        if not xi.rhapsodies.charactersAvailable(player) then
                            player:messageSpecial(walkOfEchoesID.text.CANNOT_PROGRESS_MISSION, 0, 2)
                        elseif player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_FORBIDDEN_REUNION) == QUEST_ACCEPTED then
                            player:messageSpecial(walkOfEchoesID.text.CANNOT_PROGRESS_QUEST, 0, 1)
                        elseif player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_ACCEPTED then
                            player:messageSpecial(walkOfEchoesID.text.CANNOT_PROGRESS_QUEST, 0, 0)
                        else
                            -- NOTE: Parameter 1 changes, but no text change was noted in comparisons.  The below event call is not
                            -- modified at this time.

                            -- WotG Minimum  : 0, 0, 0
                            -- Fate in Haze  : 0, 0, 0
                            -- WotG Complete : 1, 0, 0

                            return mission:progressEvent(27, 0, 0, 0, 3000, 0, 0, 0, 0)
                        end
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    -- TODO: This event was observed with a character at minimum requirements for the mission, but not
                    -- seen while Fate in Haze was active, or WotG and additional quests completed.  This may need to be
                    -- updated over time as more data becomes available.

                    if
                        player:getCurrentMission(xi.mission.log_id.WOTG) < xi.mission.id.wotg.FATE_IN_HAZE and
                        xi.rhapsodies.charactersAvailable(player)
                    then
                        return 26
                    end
                end,
            },

            onEventFinish =
            {
                [26] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [27] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(-123.494, -8.006, 599.561, 126, xi.zone.GRAUBERG_S)
                end,
            },
        },

        [xi.zone.GRAUBERG_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 47
                    end
                end,
            },

            onEventFinish =
            {
                [47] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
