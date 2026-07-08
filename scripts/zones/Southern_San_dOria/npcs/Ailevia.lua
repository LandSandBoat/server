-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ailevia
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scripted
-- This NPC participates in Quests and Missions
-- !pos -8 1 1 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Adventurer coupon
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1)
    then
        player:startEvent(655)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(615) -- i know a thing or 2 about these streets
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 655 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
