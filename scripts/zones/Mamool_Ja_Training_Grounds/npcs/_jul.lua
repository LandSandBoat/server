-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 183 0 -581
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.contents[xi.assault.mission.IMPERIAL_AGENT_RESCUE].onHatchTrigger(player, npc)
end

return entity
