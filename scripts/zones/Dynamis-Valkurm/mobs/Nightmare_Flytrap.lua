-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Flytrap
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1455)
end

function onMobDeath(mob, player, isKiller)
end

return entity
