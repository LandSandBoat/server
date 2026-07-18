-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 267 0 -582
-----------------------------------
local potHatch = require('scripts/zones/Mamool_Ja_Training_Grounds/npcs/Pot_Hatch')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    potHatch.onTrigger(player, npc, 269, -582, 124)
end

return entity
