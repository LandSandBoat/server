-----------------------------------
-- Area: Silver Sea route to Nashmau
--   NM: Proteus
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 100)
    mob:setMod(xi.mod.ACC, 250)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('respawn', GetSystemTime() + 300) -- 5 minutes
end

return entity
