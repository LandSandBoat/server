-----------------------------------
-- Area: Den of Rancor
--  Mob: Doom Toad
-- Note: PH for Ogama
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

local ogamaPHTable =
{
    [ID.mob.OGAMA - 2] = ID.mob.OGAMA,
    [ID.mob.OGAMA + 4] = ID.mob.OGAMA,
    [ID.mob.OGAMA + 5] = ID.mob.OGAMA,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 801, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ogamaPHTable, 5, 3600) -- 1 hour
end

return entity
