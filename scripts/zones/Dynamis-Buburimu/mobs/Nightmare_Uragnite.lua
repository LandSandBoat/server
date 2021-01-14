-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Uragnite
-----------------------------------
mixins = {
    require("scripts/mixins/dynamis_dreamland"),
    require("scripts/mixins/families/uragnite")
}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1455)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
