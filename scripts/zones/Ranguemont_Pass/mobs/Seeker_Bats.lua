-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Seeker Bats
-- Note: PH for Gloom Eye
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 603, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GLOOM_EYE_PH, 10, 3600) -- 1 hour
end

return entity
