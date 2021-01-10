-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Adamantking Effigy
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    dynamis.refillStatueOnSpawn(mob)
end

function onMobDeath(mob, player, isKiller)
    dynamis.refillStatueOnDeath(mob, player, isKiller)
end

return entity
