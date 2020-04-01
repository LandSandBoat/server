-----------------------------------
-- Area: Yhoator Jungle
--   NM: Hoar-knuckled Rimberry
-----------------------------------
mixins = {require("scripts/mixins/families/tonberry")}
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 133, 1, tpz.regime.type.FIELDS)
end
