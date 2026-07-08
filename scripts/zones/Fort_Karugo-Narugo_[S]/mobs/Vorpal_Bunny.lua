-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Vorpal Bunny
-- Note: PH for Ratatoskr
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.RATATOSKR, 10, 5400) -- 90 minutes
end

return entity
