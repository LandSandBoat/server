-----------------------------------
-- Apocalypse Nigh
-----------------------------------
-- !addquest 3 89
-- Ru'Lude Gardens Palace Region 1
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/common')
require("scripts/globals/npc_util")
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)

quest.reward =
{
    title    = xi.title.BREAKER_OF_THE_CHAINS,
}

quest.possibleItems =
{
    xi.items.STATIC_EARRING,
    xi.items.MAGNETIC_EARRING,
    xi.items.HOLLOW_EARRING,
    xi.items.ETHEREAL_EARRING,
}

local function finishProgress(player, option)
    if npcUtil.giveItem(player, quest.possibleItems[option]) then
        if quest:complete(player) then
            player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
            player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_LAST_VERSE)
            player:setMissionStatus(xi.mission.log_id.ZILART, 0)

            quest:setVar(player, 'Status', 7)
        end
    end
end

local function resetProgress(player, option)
    if option == 1 then
        player:delMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
        player:delMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_LAST_VERSE)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
        player:setMissionStatus(xi.mission.log_id.ZILART, 3)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)

        quest:setVar(player, 'Status', 0)
    end
end

local function updateItemEvent(player, option)
    if option == 99 then
        player:updateEvent(252, quest.possibleItems[1], quest.possibleItems[2], quest.possibleItems[3], quest.possibleItems[4])
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and -- Needs to be available
            player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) and -- Requires Shadows of the Departed
            quest:getVar(player, 'Timer') <= VanadielUniqueDay() and
            not quest:getMustZone(player)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, region)
                    return quest:progressEvent(123)
                end,
            },

            onEventFinish =
            {
                [123] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SEALIONS_DEN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Status') == 0 then
                        return 29
                    end
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {
            ['_iya'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 1 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 2)
                    player:setPos(-419.995, 0, 248.483, 191, xi.zone.THE_GARDEN_OF_RUHMET) -- Puts player in the Garden of Ru'Hmet
                end,
            },
        },

        [xi.zone.EMPYREAL_PARADOX] =
        {
            ['Transcendental_Radiance'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 2 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 3)
                end,

                [32001] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Status') == 3 then
                        quest:setVar(player, 'Status', 4)
                        player:startEvent(7)
                    end
                end,

                [7] = function(player, csid, option, npc)
                    player:setPos(-0.0745, -10, -465.1132, 63, 33)
                end,
            }
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Status') == 4 and
                        player:getRank(player:getNation()) > 5
                    then
                        return quest:progressEvent(10057)
                    elseif quest:getVar(player, 'Status') == 5 then
                        return quest:event(10058)
                    end
                end,
            },

            ['Sattal-Mansal'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 5 then
                        return quest:progressEvent(10061)
                    end
                end,
            },
            ['Yin_Pocanakhu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 5 then
                        return quest:progressEvent(10060)
                    end
                end,
            },

            onEventFinish =
            {
                [10057] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 5)
                    quest:setVar(player, 'Wait', getMidnight())
                end
            },
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Status') == 5 and
                        quest:getVar(player, 'Wait') < os.time()
                    then
                        return quest:progressEvent(232, 252)
                    end

                    if
                        quest:getVar(player, 'Status') == 6 and
                        quest:getVar(player, 'Wait') < os.time()
                    then
                        return quest:progressEvent(234, 252)
                    end
                end,
            },

            ['_700'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Status') == 5 and
                        quest:getVar(player, 'Wait') > os.time()
                    then
                        return quest:event(235)
                    end
                end,
            },

            onEventUpdate =
            {
                [232] = function(player, csid, option)
                    updateItemEvent(player, option)
                end,

                [234] = function(player, csid, option)
                    updateItemEvent(player, option)
                end,
            },

            onEventFinish =
            {
                [232] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 6)
                    if option >= 1 and option <= 4 then
                        finishProgress(player, option)
                    end
                end,

                [234] = function(player, csid, option, npc)
                    if option >= 1 and option <= 4 then
                        finishProgress(player, option)
                    end
                end,

            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(233)
                end,
            },
        },

        [xi.zone.EMPYREAL_PARADOX] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 7 then
                        for _, item in pairs(quest.possibleItems) do
                            if player:hasItem(item) then
                                return quest:messageSpecial(zones[player:getZoneID()].text.QM_TEXT)
                            end
                        end

                        return quest:progressEvent(5)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    resetProgress(player, option)
                end,
            },
        },
    },
}

return quest
