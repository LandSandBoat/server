-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Crawler
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
