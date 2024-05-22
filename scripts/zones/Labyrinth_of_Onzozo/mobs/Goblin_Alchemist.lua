-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Goblin Alchemist
-- Note: Place holder Soulstealer Skullnix
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
local entity = {}

local soulstealerPHTable =
{
    [ID.mob.SOULSTEALER_SKULLNIX + 7]  = ID.mob.SOULSTEALER_SKULLNIX, -- 24.384 5.471 197.938
    [ID.mob.SOULSTEALER_SKULLNIX + 11] = ID.mob.SOULSTEALER_SKULLNIX, -- 13.729 4.814 166.295
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
