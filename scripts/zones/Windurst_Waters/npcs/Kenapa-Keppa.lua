-----------------------------------
-- Area: Windurst Waters
--  NPC: Kenapa-Keppa
-- Involved in Quest: Food For Thought, Hat in Hand
-- !pos 27 -6 -199 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if math.random(1, 2) == 1 then
        player:startEvent(302) -- Standard converstation
    else
        player:startEvent(303) -- Standard converstation
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 56 then
        player:setCharVar('QuestHatInHand_var', utils.mask.setBit(player:getCharVar('QuestHatInHand_var'), 2, true))
        player:incrementCharVar('QuestHatInHand_count', 1)
    end
end

return entity
