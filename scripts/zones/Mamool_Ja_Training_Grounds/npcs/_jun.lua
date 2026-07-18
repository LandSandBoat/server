-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 221 0 -415
-----------------------------------
local potHatch = require('scripts/zones/Mamool_Ja_Training_Grounds/npcs/Pot_Hatch')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    potHatch.onTrigger(player, npc, 220, -415, 15)
end

return entity
