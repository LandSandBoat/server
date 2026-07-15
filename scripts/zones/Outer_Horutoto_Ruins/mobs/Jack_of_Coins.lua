-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Jack of Coins
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('popTime', GetSystemTime())
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
end

entity.onMobRoam = function(mob)
    -- If it's home.
    if mob:getMobMod(xi.mobMod.NO_MOVE) == 1 then
        if GetSystemTime() - mob:getLocalVar('popTime') > 180 then
            DespawnMob(mob:getID())
        end

        return
    end

    -- Check if at home and adjust behavior.
    local spawnPos = mob:getSpawnPos()
    local pos      = mob:getPos()

    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setRotation(spawnPos.rot)
    end
end

entity.onMobEngage = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobDisengage = function(mob)
    local spawnPos = mob:getSpawnPos()
    local pos      = mob:getPos()

    -- If not at spawn position, path back to it
    if spawnPos.x ~= pos.x or spawnPos.z ~= pos.z then
        mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
    end
end

return entity
