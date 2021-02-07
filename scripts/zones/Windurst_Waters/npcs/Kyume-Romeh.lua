-----------------------------------
-- Area: Windurst Waters
--  NPC: Kyume-Romeh
--  Involved In Quest: Making Headlines, Hat in Hand
-- !pos -58 -4 23 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end

    local hatstatus = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
    local MakingHeadlines = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MAKING_HEADLINES)
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")==4) then
        player:startEvent(873)
    elseif (player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 14)) then
        player:startEvent(939)
    elseif ((hatstatus == QUEST_ACCEPTED or player:getCharVar("QuestHatInHand_var2") == 1) and testflag(tonumber(player:getCharVar("QuestHatInHand_var")), 16) == false) then
        player:startEvent(60) -- Show Off Hat
    elseif (MakingHeadlines == QUEST_ACCEPTED) then
        local prog = player:getCharVar("QuestMakingHeadlines_var")
        --  Variable to track if player has talked to 4 NPCs and a door
        --  1 = Kyume
        -- 2 = Yujuju
        -- 4 = Hiwom
        -- 8 = Umumu
        -- 16 = Mahogany Door
        if (testflag(tonumber(prog), 1) == false) then
            player:startEvent(668) -- Quest progress
        else
            player:startEvent(669) -- Quest not furthered
        end
    else
        local rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(604) -- Standard Conversation
        else
            player:startEvent(393) -- Standard Conversation
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 668) then
        prog = player:getCharVar("QuestMakingHeadlines_var")
        player:addKeyItem(tpz.ki.WINDURST_WATERS_SCOOP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WINDURST_WATERS_SCOOP)
        player:setCharVar("QuestMakingHeadlines_var", prog+1)
    elseif (csid == 60) then  -- Show Off Hat
        player:addCharVar("QuestHatInHand_var", 16)
        player:addCharVar("QuestHatInHand_count", 1)
    elseif (csid == 873) then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 5)
    elseif (csid == 939) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 14, true))
    end
end

return entity
