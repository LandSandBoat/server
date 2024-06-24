-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Garm
-- Note: PH for Shii
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
local entity = {}

local shiiPHTable =
{
    [ID.mob.SHII - 38] = ID.mob.SHII, -- -65.000 -1.000 -137.000
    [ID.mob.SHII - 7]  = ID.mob.SHII, -- -57.000 0.998 -135.000
    [ID.mob.SHII - 6]  = ID.mob.SHII, -- -64.000 0.950 -132.000
    [ID.mob.SHII - 4]  = ID.mob.SHII, -- -59.000 0.941 -149.000
    [ID.mob.SHII - 3]  = ID.mob.SHII, -- -53.000 -0.500 -137.000
    [ID.mob.SHII + 19] = ID.mob.SHII, -- -64.000 -0.500 -144.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 612, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, shiiPHTable, 5, 3600) -- 1 hour
end

return entity
