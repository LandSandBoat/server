-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Tonberry Harrier
-- Note: PH for Sozu Terberry
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
local entity = {}

local terberryPHTable =
{
    [ID.mob.SOZU_TERBERRY - 3] = ID.mob.SOZU_TERBERRY, -- -122 0.028 -13
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 790, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 791, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 792, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 793, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 794, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 795, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, terberryPHTable, 10, 3600) -- 1 hour
end

return entity
