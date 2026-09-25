-----------------------------------
-- Area: Promyvion-Holla
--  Mob: Cerebrator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 21600))
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 21600))
end

return entity
