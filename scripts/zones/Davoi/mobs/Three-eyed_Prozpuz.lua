-----------------------------------
-- Area: Davoi
--  Mob: Three-eyed Prozpuz
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEP_MEVA, 90)
    mob:addMod(xi.mod.LULLABY_MEVA, 90)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
