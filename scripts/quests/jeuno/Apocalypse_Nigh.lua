-----------------------------------
-- Apocalypse Nigh
-----------------------------------
-- !addquest 3 89
-- Ru'Lude Gardens Palace Region 1
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/common')
require('scripts/globals/items')
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

quest.possibleItems =  {xi.items.STATIC_EARRING, xi.items.MAGNETIC_EARRING, xi.items.HOLLOW_EARRING, xi.items.ETHEREAL_EARRING}

local function finishProgress(player, option)
    npcUtil.completeQuest(player, quest.areaId, quest.questId, {item = quest.possibleItems[option]})
    player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
    player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
    player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_LAST_VERSE)
    player:setMissionStatus(xi.mission.log_id.ZILART, 0)
    player:setCharVar("PromathiaStatus", 0)
end

local function resetProgress(player, option)
    if option == 1 then
        player:delMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
        player:delMission(xi.mission.log_id.ZILART, xi.mission.id.cop.THE_LAST_VERSE)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
        player:setMissionStatus(xi.mission.log_id.ZILART, 3)
        player:setCharVar("PromathiaStatus", 7)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
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
            quest:getVar(player, 'Wait') <= os.time() and -- Must wait 1 game day
            not quest:getMustZone(player) -- Must have zoned since last quest
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            onRegionEnter =
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
                    print(quest:getVar(player, 'Prog'))
                    if quest:getVar(player, 'Prog') == 0 then
                        return 29
                    end
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {
            ['_iya'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:setPos(-419.995, 0, 248.483, 191, 35) -- Puts player in the Garden of Ru'Hmet
                end,
            },
        },
        
        [xi.zone.EMPYREAL_PARADOX] =
        {
            ['Transcendental_Radiance'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [32001] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
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
                    if quest:getVar(player, 'Prog') == 4 and player:getRank(player:getNation()) > 5 then
                        return quest:progressEvent(10057)
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:event(10058)
                    end
                end,
            },

            ['Sattal-Mansal'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(10061)
                    end
                end,
            },
            ['Yin_Pocanakhu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(10060)
                    end
                end,
            },

            onEventFinish =
            {
                [10057] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    quest:setVar(player, 'Wait', getVanaMidnight())
                end
            },
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 and os.time() >= quest:getVar(player, 'Wait') then
                        return quest:progressEvent(232, 252)
                    end
                    if quest:getVar(player, 'Prog') == 6 and os.time() >= quest:getVar(player, 'Wait') then
                        return quest:progressEvent(234, 252)
                    end
                end,
            },

            ['_700'] = 
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 and quest:getVar(player, 'Wait') > os.time() then
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
                    quest:setVar(player, 'Prog', 6)
                    if option >= 1 and option <= 4 then
                        quest:setVar(player, 'Prog', 7)
                        finishProgress(player, option)
                    end
                end,
                [234] = function(player, csid, option, npc)
                    if option >= 1 and option <= 4 then
                        quest:setVar(player, 'Prog', 7)
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
                    quest:event(233)
                end,
            },
        },

        [xi.zone.EMPYREAL_PARADOX] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc) 
                    if quest:getVar(player, 'Prog') == 7 then
                        for _, item in pairs(quest.possibleItems) do

                            if player:hasItem(item) then
                                return quest:messageSpecial(zones[player:getZoneID()].text.QM_TEXT)
                            end

                            return quest:progressEvent(5)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 0)
                    resetProgress(player, option)
                end,
            },
        },
    },
}

return quest
