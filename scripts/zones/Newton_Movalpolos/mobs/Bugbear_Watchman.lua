-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Bugbear Watchman
-----------------------------------
local entity = {}

-- entity.onMobSpawn = function(mob)
--     mob:setMobMod(xi.mobMod.NO_MOVE, 1)
-- end

entity.onMobEngaged = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    local spawn = mob:getSpawnPos()
    local pos = mob:getPos()

    if pos.x ~= spawn.x and pos.z ~= spawn.z then
        mob:pathTo(spawn.x, spawn.y, spawn.z, xi.path.flag.SCRIPT)
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        -- TODO: Mob face proper rotation
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
