-----------------------------------
-- Area: Promyvion-Dem
--  Mob: Satiator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(3600 + math.randomInt(600, 900)) -- 1 hour, plus 10 to 15 min
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(3600 + math.randomInt(600, 900)) -- 1 hour, plus 10 to 15 min
end

return entity
