-----------------------------------
-- Area: Batallia Downs
--  Mob: Stalking Sapling
-- Note: PH for Tottering Toby
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 72, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 73, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TOTTERING_TOBY_PH, 20, 3600) -- 1 hour
end
