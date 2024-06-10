-----------------------------------
-- Area: Nyzul Isle (Waking the Colossus/Divine Interference)
--  Mob: Alexander
-----------------------------------
mixins = { require('scripts/mixins/families/alexander') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
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
