-----------------------------------
-- Instance: Silver Sea Remnants
--  NPC: Armoury Crate
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    if not instance then
        return
    end

    xi.salvage.onTriggerCrate(player, npc)
end

return entity
