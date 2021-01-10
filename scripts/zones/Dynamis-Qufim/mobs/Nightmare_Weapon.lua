-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Weapon
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1452)
end

function onMobDeath(mob, player, isKiller)
end

return entity
