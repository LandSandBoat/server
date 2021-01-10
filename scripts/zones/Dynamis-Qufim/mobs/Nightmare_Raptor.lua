-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Raptor
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1449)
end

function onMobDeath(mob, player, isKiller)
end

return entity
