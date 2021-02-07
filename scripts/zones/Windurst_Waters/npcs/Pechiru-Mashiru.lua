-----------------------------------
-- Area: Windurst Waters
--  NPC: Pechiru-Mashiru
-- Involved in Quests: Hat in Hand
-- !pos 162 -2 159 238
-----------------------------------
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
    if ((hatstatus == QUEST_ACCEPTED or player:getCharVar("QuestHatInHand_var2") == 1) and testflag(tonumber(player:getCharVar("QuestHatInHand_var")), 64) == false) then
        player:startEvent(54) -- Show Off Hat
    elseif player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED then
        player:startEvent(445)
    else
        player:startEvent(421) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 54) then  -- Show Off Hat
        player:addCharVar("QuestHatInHand_var", 64)
        player:addCharVar("QuestHatInHand_count", 1)
    end
end

return entity
