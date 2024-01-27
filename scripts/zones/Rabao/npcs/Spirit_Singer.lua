-----------------------------------
-- Area: Rabao
--  NPC: Spirit Singer
-- Type: Item Deliverer
-- !pos 140.337 7.999 80.661 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.SPIRIT_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
