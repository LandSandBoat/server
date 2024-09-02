-----------------------------------
-- Area: Crawlers' Nest (197)
--  Mob: Wespe
-- Note: PH for Demonic Tiphia
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
---@type TMobEntity
local entity = {}

local tiphiaPHTable =
{
    [ID.mob.DEMONIC_TIPHIA - 7] = ID.mob.DEMONIC_TIPHIA, -- -101.000 -1.000 285.000
    [ID.mob.DEMONIC_TIPHIA - 6] = ID.mob.DEMONIC_TIPHIA, -- -103.000 -1.000 311.000
    [ID.mob.DEMONIC_TIPHIA - 3] = ID.mob.DEMONIC_TIPHIA, -- -89.000 -1.000 301.000
    [ID.mob.DEMONIC_TIPHIA - 2] = ID.mob.DEMONIC_TIPHIA, -- -75.000 -1.000 299.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 691, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, tiphiaPHTable, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
