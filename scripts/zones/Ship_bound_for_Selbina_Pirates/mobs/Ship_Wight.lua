-----------------------------------
-- Area: Ship bound for Selbina (Pirates)
--  Mob: Ship Wight
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 8)
end

entity.onMobDeath = function(mob, player)
end

entity.onMobDespawn = function(mob, player)
    mob:setLocalVar("respawnTime", os.time() + 60)
end

return entity
