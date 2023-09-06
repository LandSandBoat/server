-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  ZNM: Cheese Hoarder Gigiroon
-- TODO: Running around mechanic and dropping bombs
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob)
end

return entity
