------------------------------
-- Area: Newton Movalpolos
--   NM: Goblin Collector
------------------------------
require("scripts/globals/status")
------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.MATT, 150)
    mob:setMod(xi.mod.BINDRES, 40)
    mob:setMod(xi.mod.GRAVITYRES, 40)
end

entity.onMobFight = function(mob, target)
    -- Resets threat on every auto attack
    mob:addListener("ATTACK","COLLECTOR_ATTACK", function(mob)
        mob:resetEnmity(target)
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:removeListener("COLLECTOR_ATTACK")
end

return entity