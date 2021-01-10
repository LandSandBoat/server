-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Tabar Beak
-- Note: PH for Deadly Dodo
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 100, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DEADLY_DODO_PH, 33, 3600) -- 1 hour
end

return entity
