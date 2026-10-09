-----------------------------------
-- Area: Feretory (285)
--  NPC: Goblin Footprint
-- !pos -323.113 -2.718 -457.763 285
-----------------------------------
local ID = zones[xi.zone.FERETORY]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: Does retail follow this with Grumblix's story menu (event 0)?
entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.STRANGE_RASPY_VOICE)
end

return entity
