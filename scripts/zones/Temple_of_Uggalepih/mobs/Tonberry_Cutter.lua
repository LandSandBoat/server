-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Tonberry Cutter
-- Note: PH for Sozu Sarberry
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
mixins = { require("scripts/mixins/families/tonberry") }
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 790, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 791, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 792, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 793, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 794, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 795, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SOZU_SARBERRY_PH, 10, 3600) -- 1 hour
end

return entity
