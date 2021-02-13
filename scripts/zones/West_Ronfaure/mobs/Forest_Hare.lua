-----------------------------------
-- Area: West Ronfaure
--  Mob: Forest Hare
-- Note: PH for Jaggedy-Eared Jack
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 2, 1, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.JAGGEDY_EARED_JACK_PH, 5, math.random(3000, 21600)) -- 50 minutes to 6 hours
end

return entity
