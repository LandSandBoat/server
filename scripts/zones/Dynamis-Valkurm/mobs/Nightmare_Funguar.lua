-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Funguar
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1455)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
