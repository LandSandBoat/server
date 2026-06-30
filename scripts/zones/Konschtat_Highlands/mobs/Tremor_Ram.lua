-----------------------------------
-- Area: Konschtat Highlands
--   NM: Tremor Ram
-- Note: PH for Rampaging Ram
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.RAMPAGING_RAM, 10, 1200) -- 20 min
end

return entity
