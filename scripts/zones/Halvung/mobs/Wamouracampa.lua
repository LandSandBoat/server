-----------------------------------
-- Area: Halvung
--  Mob: Wamouracampa
-----------------------------------
mixins = { require('scripts/mixins/families/wamouracampa') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobRoam = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob)
end

return entity
