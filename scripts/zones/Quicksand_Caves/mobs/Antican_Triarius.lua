-----------------------------------
-- Area: Quicksand Caves
--  Mob: Antican Triarius
-- Note: PH for Triarius X-XV and Hastatus XI-XII
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

local triariusPHTable =
{
    [ID.mob.TRIARIUS_X_XV + 9] = ID.mob.TRIARIUS_X_XV, -- -786.730 -0.5 -343.963
}

local hastatusPHTable =
{
    [ID.mob.HASTATUS_XI_XII - 4] = ID.mob.HASTATUS_XI_XII, -- -343.859 -0.411 751.608
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 812, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 813, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 814, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 815, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 816, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 817, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 818, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 819, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, triariusPHTable, 10, 7200) -- 2 hours
    xi.mob.phOnDespawn(mob, hastatusPHTable, 10, 3600) -- 1 hour
end

return entity
