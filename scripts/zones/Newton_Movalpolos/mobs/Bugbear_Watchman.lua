-----------------------------------
-- Area: Newton Movalpolos
--   Mob: Bugbear Watchman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- These mobs are guards and do not roam randomly.
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.ROAM_RESET_FACING, 1)
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
end

entity.onMobRoam = function(mob)
    local spawnPos = mob:getSpawnPos()
    local pos      = mob:getPos()

    -- If not at spawn position, path back to it
    if spawnPos.x ~= pos.x or spawnPos.z ~= pos.z then
        mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
    end
end

return entity
