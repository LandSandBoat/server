-----------------------------------
-- Area: Den of Rancor
--  NPC: Drop Gate (by Hakutaku)
-- !pos 5.044 23.590 -299.976 160
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET) -- The grating will not budge.
end

return entity
