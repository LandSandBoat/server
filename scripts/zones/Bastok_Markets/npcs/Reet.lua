-----------------------------------
-- Area: Bastok Markets
--  NPC: Reet
-- Adventurer's Assistant
-- !pos -237 -12 -41 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1)
    then
        player:startEvent(6)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(5)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 6 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
