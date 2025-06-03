-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Matildie
-- Adventurer's Assistant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1)
    then
        player:startEvent(631)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 631 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
