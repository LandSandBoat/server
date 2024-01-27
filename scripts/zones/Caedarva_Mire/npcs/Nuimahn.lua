-----------------------------------
-- Area: Caedarva Mire
--  NPC: Nuimahn
-- Type: Alzadaal Undersea Ruins
-- !pos  -380 0 -381 79
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.IMPERIAL_SILVER_PIECE, 1)
    then
        player:tradeComplete()
        player:startEvent(203)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < -281 then
        player:startEvent(204) -- leaving
    else
        player:startEvent(202) -- entering
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 203 then
        player:setPos(-515, -6.5, 740, 0, 72)
    end
end

return entity
