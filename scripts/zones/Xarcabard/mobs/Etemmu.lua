-----------------------------------
-- Area: Xarcabard
--  Mob: Etemmu
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

local disturbMob = function(mob)
    -- Appears to be very similar to Noble Mold spawn conditions
    -- TODO see if it's possible for mob to transform earlier than this cooldown on spawn/engage
    mob:setLocalVar('ereshkigalCooldown', GetSystemTime() + 12 * 60 * 60) -- 12 hours
    -- short-circuit the spawn timer if it's currently dark weather
    mob:setLocalVar('phDespawnTime', 0)
end

entity.onMobSpawn = function(mob)
    if mob:getID() ~= ID.mob.ERESHKIGAL - 1 then
        return
    end

    -- everything after this happens only on PH mob
    disturbMob(mob)

    -- install a weather_change listener
    mob:addListener('WEATHER_CHANGE', 'PRIME_ERESHKIGAL', function(phMob, weather, element)
        -- listeners trigger on dead mobs, make sure no funny business happens
        if
            not phMob:isAlive() or
            phMob:getLocalVar('ereshkigalCooldown') > GetSystemTime()
        then
            phMob:setLocalVar('phDespawnTime', 0)
            return
        end

        phMob:setLocalVar('phDespawnTime', 0)
        local ereshkigalDelay  = 0

        if weather == xi.weather.GLOOM then
            -- Noble Mold always spawns on the minute after weather change
            -- Ereshkigal witnessed doing the same thing
            ereshkigalDelay  = math.random(2, 120) * 60
        elseif weather == xi.weather.DARKNESS then
            -- TODO is chance actually higher for double dark... it's a very rare weather so probably?
            ereshkigalDelay  = math.random(2, 20) * 60
        end

        if ereshkigalDelay > 0 then
            -- based on captures:
            -- spawns exactly X minutes after weather change
            -- spawns 3s after despawn of PH
            local phDespawnDelay = ereshkigalDelay - 3
            -- technically we will despawn on the tick after this delay passes, so we aren't getting NM in exactly "ereshkigalDelay" seconds :(
            -- offset by 1s to split that difference instead of complicating things with mob:timer()
            phMob:setLocalVar('phDespawnTime', GetSystemTime() + phDespawnDelay - 1)
        end
    end)

    -- ereshkigal PH wanders all along south and west part of plateau at intersection of 4 squares F/G-7/8
    -- ROAM_DISTANCE doesn't work well for this, since the NM doesn't wander in a circle, he makes a kind of letter C path
    -- so we increment spawnPosition at random intervals to make it systematically patrol up and down the corridor without strictly pathing
    -- changing spawn position adjusts the Roam positions to be chosen in a circle around that new spot
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 20)
    local phSpawnPoints =
    {
        -- known wander points of the PH
        { x =  -16.00, y = -23.20, z = -80.82 },
        { x =  -43.59, y = -24.00, z = -78.70 },
        { x =  -61.46, y = -23.73, z = -67.49 },
        { x =  -86.67, y = -23.86, z = -40.63 },
        { x = -116.43, y = -22.11, z = -25.47 },
        { x = -138.38, y = -21.12, z = -23.83 },
        { x = -104.70, y = -18.88, z = -12.55 },
        { x =  -80.23, y = -15.52, z =  12.82 },
        -- reversing the path so we never move the spawn point by too much
        { x = -104.70, y = -18.88, z = -12.55 },
        { x = -138.38, y = -21.12, z = -23.83 },
        { x = -116.43, y = -22.11, z = -25.47 },
        { x =  -86.67, y = -23.86, z = -40.63 },
        { x =  -61.46, y = -23.73, z = -67.49 },
        { x =  -43.59, y = -24.00, z = -78.70 },
    }
    -- ensure mob starts at first position
    local pos0 = phSpawnPoints[1]
    mob:setSpawn(pos0.x, pos0.y, pos0.z)
    mob:setPos(pos0)

    -- install wander randomizer
    mob:addListener('ROAM_TICK', 'ERESHKIGAL_PH_PATROL', function(mobArg)
        -- he slowly moves back and forth across the wander area, checking every 3s with this % chance gives the approximate behavior
        -- We do have to be careful that spawn position doesn't move too far away from mob's current position or it will simply despawn
        -- we ensure this by only changing spawn point when he's not following a path, and making him path to his new spot
        if
            not mobArg:isFollowingPath() and
            math.random(1, 100) <= 4
        then
            local index = (mobArg:getLocalVar('spawnPos') + 1) % #phSpawnPoints
            mobArg:setLocalVar('spawnPos', index)
            -- modulus is zero-indexed, table is 1-indexed
            local pos = phSpawnPoints[index + 1]
            mobArg:setSpawn(pos.x, pos.y, pos.z)
            mobArg:pathTo(pos.x, pos.y, pos.z, xi.pathflag.SCRIPT)
        end
    end)
end

entity.onMobRoam = function(mob)
    -- Mob doesn't transform as soon as weather changes
    local spawnTime = mob:getLocalVar('phDespawnTime')
    if spawnTime == 0 or GetSystemTime() < spawnTime then
        return
    end

    -- PH has been undisturbed long enough while weather persists
    local ereshkigal = GetMobByID(ID.mob.ERESHKIGAL)
    if not ereshkigal then
        return
    end

    local p = mob:getPos()
    ereshkigal:setSpawn(p.x, p.y, p.z, p.rot)
    -- Spawn Ereshkigal and block PH until Ereshkigal is killed
    DisallowRespawn(mob:getID(), true)
    DespawnMob(mob:getID()) -- normal 3s despawn timer

    -- Ereshkigal spawns in place of PH as soon as despawn completes
    mob:addListener('DESPAWN', 'ERESHKIGAL_TRANSFORMATION', function(mobArg)
        SpawnMob(ID.mob.ERESHKIGAL)

        mobArg:removeListener('ERESHKIGAL_TRANSFORMATION')
    end)
end

entity.onMobEngage = function(mob)
    disturbMob(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 51, 2, xi.regime.type.FIELDS)
end

return entity
