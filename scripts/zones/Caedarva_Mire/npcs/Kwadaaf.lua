-----------------------------------
-- Area: Caedarva Mire
--  NPC: Kwadaaf
-- Type: Entry to Alzadaal Undersea Ruins
-- !pos -639.000 12.323 -260.000 79
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:getItemCount() == 1 and trade:hasItemQty(2185, 1) then -- Silver
        player:tradeComplete()
        player:startEvent(223)
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() < -639 then
        player:startEvent(222)
    else
        player:startEvent(224)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 223 then
        player:setPos(-235, -4, 220, 0, 72)
    end
end

return entity
