-----------------------------------
-- Area: East Ronfaure
--  NPC: Rayochindot
-- Type: Gate Guard
-- !pos 93.159 -62.999 272.601 101
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.RAYOCHINDOT_DIALOG)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
