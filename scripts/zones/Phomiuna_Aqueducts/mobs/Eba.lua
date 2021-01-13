-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Eba
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("fomorHateAdj", 4)
end

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours
end

return entity
