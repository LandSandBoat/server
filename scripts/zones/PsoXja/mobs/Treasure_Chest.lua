-----------------------------------
-- Area: Pso'Xja
--  Mob: Treasure Chest
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:hideName(true)
    mob:setStatus(xi.status.NORMAL)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 3)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 3)
    mob:setAnimationSub(0)
end

entity.onMobEngaged = function(mob, target)
    mob:hideName(false)
    mob:setStatus(xi.status.UPDATE)
    mob:setAnimationSub(1)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:updateClaim(target)
end

entity.onMobDisengage = function(mob)
    local spawn = mob:getSpawnPos()
    mob:setRotation(spawn.rot)
    mob:hideName(true)
    mob:setStatus(xi.status.NORMAL)
    mob:setAnimationSub(0)
end

return entity
