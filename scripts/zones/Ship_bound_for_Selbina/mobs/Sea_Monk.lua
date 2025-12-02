-----------------------------------
-- Area: Ship Bound for Mhaura
--   NM: Sea Horror
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    -- "Can spawn up to three times on the same ferry ride."
    -- TODO verify if this mob can spawn back-to-back. If so it might be in a spawn group with the sea monk
    -- a spawn group + IDLE_DESPAWN on the NM would look very much like a ph-style NM
    xi.mob.phOnDespawn(mob, ID.mob.SEA_HORROR, 50, 1)
end

return entity
