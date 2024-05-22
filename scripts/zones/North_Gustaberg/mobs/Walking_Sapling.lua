-----------------------------------
-- Area: North Gustaberg
--  Mob: Walking Sapling
-- Note: Place Holder For Maighdean Uaine
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
local entity = {}

local maighdeanPHTable =
{
    [ID.mob.MAIGHDEAN_UAINE - 5] = ID.mob.MAIGHDEAN_UAINE, -- 164.140 1.981  740.020
    [ID.mob.MAIGHDEAN_UAINE - 4] = ID.mob.MAIGHDEAN_UAINE, -- 121.242 -0.500 654.504
    [ID.mob.MAIGHDEAN_UAINE - 3] = ID.mob.MAIGHDEAN_UAINE, -- 94.521  2.365  648.439
    [ID.mob.MAIGHDEAN_UAINE - 2] = ID.mob.MAIGHDEAN_UAINE, -- 203.606 -0.607 721.541
    [ID.mob.MAIGHDEAN_UAINE - 1] = ID.mob.MAIGHDEAN_UAINE, -- 176.458 -0.347 722.666
    [ID.mob.MAIGHDEAN_UAINE + 8] = ID.mob.MAIGHDEAN_UAINE, -- 239.992 -0.493 788.037
    [ID.mob.MAIGHDEAN_UAINE + 9] = ID.mob.MAIGHDEAN_UAINE, -- 289.709 -0.297 750.252
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 18, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, maighdeanPHTable, 5, 900) -- 15 min minimum
end

return entity
