-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Vanguard Salvager
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Beaucedine/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HEE_MIDA_THE_METICULOUS_PH, 10, 1200) -- 20 minutes
end

return entity
