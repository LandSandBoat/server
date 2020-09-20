-----------------------------------
-- Area: RoMaeve
--  Mob: Cursed Puppet
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 121, 1, tpz.regime.type.FIELDS)
end
