-----------------------------------
-- Area: Quicksand Caves
--  Mob: Antican Hastatus
-- Note: PH for Antican Magister
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 812, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 813, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 814, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 815, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 816, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 817, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 818, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 819, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ANTICAN_MAGISTER_PH, 10, 3600) -- 1 hour
end

return entity
