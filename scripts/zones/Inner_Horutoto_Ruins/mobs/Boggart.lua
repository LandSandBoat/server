-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Boggart
-- Note: Place holder Nocuous Weapon
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

local nocuousPHTable =
{
    [ID.mob.NOCUOUS_WEAPON - 3] = ID.mob.NOCUOUS_WEAPON, -- -236.855 0.476 -51.263
    [ID.mob.NOCUOUS_WEAPON - 2] = ID.mob.NOCUOUS_WEAPON, -- -237.426 0.5 -23.412
    [ID.mob.NOCUOUS_WEAPON - 1] = ID.mob.NOCUOUS_WEAPON, -- -230.732 -0.025 -52.324
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 650, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, nocuousPHTable, 5, 3600) -- 1 hour
end

return entity
