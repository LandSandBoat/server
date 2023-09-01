-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 183 0 -581
-----------------------------------
require('scripts/zones/Mamool_Ja_Training_Grounds/globals/zoneUtil')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.zoneUtil.ImperialAgent_PotHatch(player, npc, 184, -583, 185)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
