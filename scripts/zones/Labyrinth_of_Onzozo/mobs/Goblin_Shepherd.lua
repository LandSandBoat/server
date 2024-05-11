-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Goblin Shepherd
-- Note: Place holder Soulstealer Skullnix
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
local entity = {}

local soulstealerPHTable =
{
    [ID.mob.SOULSTEALER_SKULLNIX + 20] = ID.mob.SOULSTEALER_SKULLNIX, -- 38.347 5.500 178.050
    [ID.mob.SOULSTEALER_SKULLNIX + 25] = ID.mob.SOULSTEALER_SKULLNIX, -- 41.150 5.026 204.483
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, soulstealerPHTable, 5, math.random(7200, 10800)) -- 2 to 3 hours
end

return entity
