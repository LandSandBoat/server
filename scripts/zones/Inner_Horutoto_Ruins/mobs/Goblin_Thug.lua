-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Thug
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 647, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, {[ID.mob.MAGICKED_BONES_PH_CLUB] = ID.mob.MAGICKED_BONES_PH_CLUB + 2}, 50, 1)
end

return entity
