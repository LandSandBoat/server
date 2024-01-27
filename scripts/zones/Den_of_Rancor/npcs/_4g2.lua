-----------------------------------
-- Area: Den of Rancor
--  NPC: Drop Gate (by Tonberry Decapitator)
-- !pos -139.976 3.591 -165.043 160
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
