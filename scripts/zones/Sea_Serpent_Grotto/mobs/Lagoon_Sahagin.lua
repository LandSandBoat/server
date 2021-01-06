-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Lagoon Sahagin
-- Note: PH for Yarr the Pearleyed and Novv the Whitehearted
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 806, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 807, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 808, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.YARR_THE_PEARLEYED_PH, 10, 3600) -- 1 hour
    tpz.mob.phOnDespawn(mob, ID.mob.NOVV_THE_WHITEHEARTED_PH, 10, 7200) -- 2 hours
end

return entity
