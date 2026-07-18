-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 183 0 -581
-----------------------------------
local potHatch = require('scripts/zones/Mamool_Ja_Training_Grounds/npcs/Pot_Hatch')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    potHatch.onTrigger(player, npc, 184, -583, 185)
end

return entity
