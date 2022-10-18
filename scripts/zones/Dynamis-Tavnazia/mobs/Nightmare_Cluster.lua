-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Cluster
-----------------------------------
mixins = { require("scripts/mixins/dynamis_dreamland") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("dynamis_currency", 1452)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
