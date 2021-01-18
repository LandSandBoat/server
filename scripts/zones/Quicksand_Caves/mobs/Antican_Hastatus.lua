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

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 812, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 813, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 814, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 815, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 816, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 817, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 818, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 819, 2, tpz.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ANTICAN_MAGISTER_PH, 10, 3600) -- 1 hour
end

return entity
