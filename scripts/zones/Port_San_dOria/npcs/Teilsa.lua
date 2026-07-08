-----------------------------------
-- Area: Port San d'Oria
--  NPC: Teilsa
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scrited
-- This NPC participates in Quests and Missions
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.ADVENTURER_COUPON, 1)
    then
        player:startEvent(612)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 612 then
        player:tradeComplete()

        npcUtil.giveCurrency(player, 'gil', 50)
    end
end

return entity
