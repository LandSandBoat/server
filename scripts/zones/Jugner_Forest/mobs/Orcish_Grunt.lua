-----------------------------------
-- Area: Jugner Forest
--  Mob: Orcish Grunt
-- Note: PH for Supplespine Mujwuj
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SUPPLESPINE_MUJWUJ_PH, 10, 3600) -- 1 hour
end

return entity
