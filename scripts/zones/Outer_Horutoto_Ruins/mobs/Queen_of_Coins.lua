-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Queen of Coins
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setLocalVar("despawn", os.time() + 180)
end

entity.onMobRoam = function(mob)
    local now = os.time()
    local despawntime = mob:getLocalVar("despawn")
    if now > despawntime then
        DespawnMob(mob:getID())
    end
end

entity.onMobEngaged = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
