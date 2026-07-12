-----------------------------------
-- Area: Ilrusi Atoll
--  NPC: Cursed Chest
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    -- Hidden by default; the Golden Salvage assault shows the one chest that
    -- holds the figurehead (see scripts/assaults/Ilrusi_Atoll/golden_salvage.lua).
    npc:setStatus(xi.status.DISAPPEAR)
end

entity.onTrigger = function(player, npc)
    xi.assault.contents[xi.assault.mission.GOLDEN_SALVAGE].onChestTrigger(player, npc)
end

return entity
