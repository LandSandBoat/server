-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: Mahogany Door
-- Involved In Quest: Making Headlines
-- Involved in Mission 2-1
-- !pos -11 0 20 192
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local MakingHeadlines = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    local CurrentMission = player:getCurrentMission(WINDURST)
    local MissionStatus = player:getCharVar("MissionStatus")

    -- Check for Missions first (priority?)
    -- We should allow both missions and quests to activate
    if CurrentMission == tpz.mission.id.windurst.LOST_FOR_WORDS and MissionStatus == 4 then
        player:startEvent(46)
    elseif MakingHeadlines == QUEST_ACCEPTED then
        function testflag(set, flag)
            return (set % (2*flag) >= flag)
        end

        local prog = player:getCharVar("QuestMakingHeadlines_var")

        if not testflag(tonumber(prog), 16) and testflag(tonumber(prog), 8) then
            player:messageSpecial(7208, 1, tpz.ki.WINDURST_WOODS_SCOOP) -- Confirm Story
            player:setCharVar("QuestMakingHeadlines_var", prog+16)
        else
            player:startEvent(44) -- "The door is firmly shut"
        end
    else
        player:startEvent(44) -- "The door is firmly shut"
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 46 then
        player:setCharVar("MissionStatus", 5) -- Mark the progress
    end
end

return entity
