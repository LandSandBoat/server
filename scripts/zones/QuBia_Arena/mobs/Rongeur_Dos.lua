-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Rongeur D'os
-- BCNM: Let Sleeping Dogs Die
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setBehavior(xi.behavior.NO_DESPAWN)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:setLocalVar('deathTime', GetSystemTime())
    end
end

return entity
