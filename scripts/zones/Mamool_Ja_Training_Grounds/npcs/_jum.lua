-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 267 0 -582
-----------------------------------
require('scripts/zones/Mamool_Ja_Training_Grounds/globals/zoneUtil')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.zoneUtil.ImperialAgent_PotHatch(player, npc, 269, -582, 124)
end

return entity
