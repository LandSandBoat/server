-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Coeurl
-- Note: PH for Patripatan
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 63, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PATRIPATAN_PH, 5, math.random(3600, 10800)) -- 1 to 3 hours
end

return entity
