-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Coastal Sahagin
-- Note: PH for Denn the Orcavoiced
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
    tpz.mob.phOnDespawn(mob, ID.mob.DENN_THE_ORCAVOICED_PH, 10, 7200) -- 2 hours
end

return entity
