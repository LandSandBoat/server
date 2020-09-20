-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Cactuar
-- Note: Place holder for Cactuar_Cantautor
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 136, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.CACTUAR_CANTAUTOR_PH, 5, math.random(3600, 43200)) -- 1 to 12 hours
end
