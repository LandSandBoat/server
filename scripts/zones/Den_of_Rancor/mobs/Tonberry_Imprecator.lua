-----------------------------------
-- Area: Den of Rancor
--  Mob: Tonberry Imprecator
-- Note: PH for Carmine-tailed Janberry
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

local carminePHTable =
{
    [ID.mob.CARMINE_TAILED_JANBERRY + 2] = ID.mob.CARMINE_TAILED_JANBERRY,
    [ID.mob.CARMINE_TAILED_JANBERRY + 3] = ID.mob.CARMINE_TAILED_JANBERRY,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 798, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 799, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 800, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, carminePHTable, 5, 3600) -- 1 hour
end

return entity
