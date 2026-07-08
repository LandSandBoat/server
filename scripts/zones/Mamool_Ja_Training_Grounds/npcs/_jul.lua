-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 183 0 -581
-----------------------------------
require('scripts/zones/Mamool_Ja_Training_Grounds/globals/zoneUtil')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.zoneUtil.ImperialAgent_PotHatch(player, npc, 184, -583, 185)
end

return entity
