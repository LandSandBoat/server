-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 221 0 -415
-----------------------------------
require('scripts/zones/Mamool_Ja_Training_Grounds/globals/zoneUtil')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.zoneUtil.ImperialAgent_PotHatch(player, npc, 220, -415, 15)
end

return entity
