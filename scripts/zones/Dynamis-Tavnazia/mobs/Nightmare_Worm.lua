-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Worm
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1449)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
