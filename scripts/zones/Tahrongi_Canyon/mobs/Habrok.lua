-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Habrok
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setLocalVar('pop', GetSystemTime() + math.randomInt(1200, 7200))
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.BIND)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 258)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('pop', GetSystemTime() + math.randomInt(1200, 7200))
end

return entity
