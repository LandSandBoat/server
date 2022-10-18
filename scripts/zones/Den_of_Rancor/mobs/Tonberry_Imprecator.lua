-----------------------------------
-- Area: Den of Rancor
--  Mob: Tonberry Imprecator
-- Note: PH for Carmine-tailed Janberry
-----------------------------------
mixins = { require("scripts/mixins/families/tonberry") }
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 798, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 799, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 800, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CARMINE_TAILED_JANBERRY_PH, 15, 3600) -- 1 hour minimum
    xi.mob.phOnDespawn(mob, ID.mob.SOZU_BLIBERRY_PH, 15, 10800) -- 3 hour minimum
end

return entity
