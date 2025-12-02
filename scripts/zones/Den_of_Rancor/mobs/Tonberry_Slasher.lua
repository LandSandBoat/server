-----------------------------------
-- Area: Den of Rancor
--  Mob: Tonberry Slasher
-- Note: PH for Tawny-fingered Mugberry
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 798, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 799, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 800, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TAWNY_FINGERED_MUGBERRY, 5, 3600) -- 1 hour
end

return entity
