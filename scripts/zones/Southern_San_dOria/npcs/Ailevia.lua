-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ailevia
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scripted
-- This NPC participates in Quests and Missions
-- !pos -8 1 1 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Adventurer coupon
    if trade:getItemCount() == 1 and trade:hasItemQty(536, 1) then
        player:startEvent(655)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(615) -- i know a thing or 2 about these streets
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 655 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
