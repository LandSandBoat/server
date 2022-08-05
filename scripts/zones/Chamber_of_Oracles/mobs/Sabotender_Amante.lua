-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Sabotender Amante
-- KSNM: Cactuar Suave
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 100)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
