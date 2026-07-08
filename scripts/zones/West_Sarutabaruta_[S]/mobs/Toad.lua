-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Toad
-- Note: Place holder Ramponneau
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.RAMPONNEAU, 20, 5400) -- 90 minutes
end

return entity
