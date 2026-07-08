-----------------------------------
-- Area: Port Bastok
--  NPC: Dulsie
-- Adventurer's Assistant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(8)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(7)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 8 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
