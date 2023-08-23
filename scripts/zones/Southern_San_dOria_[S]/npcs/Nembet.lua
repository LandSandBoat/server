-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Nembet
-- !pos 147 -3 110 80
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
