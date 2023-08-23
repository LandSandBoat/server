-----------------------------------
-- Area: Beaucedine Glacier (111)
--  Mob: Tundra Tiger
-- Note: PH for Nue, Kirata
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 46, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 47, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.KIRATA_PH, 7, math.random(3600, 28800)) -- 1 to 8 hours
    xi.mob.phOnDespawn(mob, ID.mob.NUE_PH, 7, math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
