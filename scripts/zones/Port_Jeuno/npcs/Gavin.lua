-----------------------------------
-- Area: Port Jeuno
--  NPC: Gavin
-- !pos -15 8 44 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.GAVIN_DIALOG, xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
