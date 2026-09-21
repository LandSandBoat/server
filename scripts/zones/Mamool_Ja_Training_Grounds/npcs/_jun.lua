-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Npc: Pot Hatch
-- !pos 221 0 -415
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.contents[xi.assault.mission.IMPERIAL_AGENT_RESCUE].onHatchTrigger(player, npc)
end

return entity
