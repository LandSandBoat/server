-----------------------------------
-- Area: Xarcabard
--  Mob: Cursed Weapon
-- Note: PH for Barbaric Weapon
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 52, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 53, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BARBARIC_WEAPON_PH, 10, 7200) -- 2 hours
end

return entity
