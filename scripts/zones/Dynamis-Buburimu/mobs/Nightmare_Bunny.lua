-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Bunny
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1452)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
