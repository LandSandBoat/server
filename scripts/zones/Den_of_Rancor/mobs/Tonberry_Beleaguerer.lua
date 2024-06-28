-----------------------------------
-- Area: Den of Rancor
--  Mob: Tonberry Beleaguerer
-- Note: PH for Bistre-hearted Malberry
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

local bistrePHTable =
{
    [ID.mob.BISTRE_HEARTED_MALBERRY - 23] = ID.mob.BISTRE_HEARTED_MALBERRY,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 798, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 799, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 800, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bistrePHTable, 10, 3600) -- 1 hour
end

return entity
