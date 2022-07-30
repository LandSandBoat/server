-----------------------------------
-- Area: Ship bound for Selbina
--  Mob: Sea Horror
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 100)
end

entity.onMobDeath = function(mob, player)

end

entity.onMobDespawn = function(mob, player)
    mob:setLocalVar("respawnTime", os.time() + 60)
end

return entity
