-----------------------------------
-- Area: East Ronfaure
--  NPC: Croteillard
-- Type: Gate Guard
-- !pos 87.426 -62.999 266.709 101
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.CROTEILLARD_DIALOG)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
