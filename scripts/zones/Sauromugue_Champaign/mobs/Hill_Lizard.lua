-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Hill Lizard
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 40, 1, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BASHE_PH, 10, 3600) -- 1 hour
end

return entity
