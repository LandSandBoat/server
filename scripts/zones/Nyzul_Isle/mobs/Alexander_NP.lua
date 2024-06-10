-----------------------------------
-- Area: Nyzul Isle (Nashmeira's Plea)
--  Mob: Alexander
-----------------------------------
mixins = { require('scripts/mixins/families/alexander') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
