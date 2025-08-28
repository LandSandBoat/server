-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Myxomycete
-- Note: PH for Noble Mold. Transforms from a particular mob who stays undisturbed _during_ rain/squall weather
--       https://www.bg-wiki.com/ffxi/Noble_Mold
-----------------------------------
local ID = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------
---@type TMobEntity
local entity = {}

local disturbMob = function(mob)
    -- based on camping this mob
    -- - a chance to transform on change to water weather
    -- - a base lockout/cooldown after the mob is disturbed.
    -- TODO see if it's possible for mob to transform earlier than this cooldown on spawn/engage
    mob:setLocalVar('nobleMoldCooldown', GetSystemTime() + 12 * 60 * 60) -- 12 hours
    -- short-circuit the spawn timer if it's currently water weather
    mob:setLocalVar('phDespawnTime', 0)
end

entity.onMobSpawn = function(mob)
    if mob:getID() ~= ID.mob.NOBLE_MOLD - 1 then
        return
    end

    disturbMob(mob)

    -- install a weather_change listener only on Noble Mold's PH
    mob:addListener('WEATHER_CHANGE', 'PRIME_NOBLE_MOLD', function(phMob, weather, element)
        -- listeners trigger on dead mobs, make sure no funny business happens
        if
            not phMob:isAlive() or
            phMob:getLocalVar('nobleMoldCooldown') > GetSystemTime()
        then
            phMob:setLocalVar('phDespawnTime', 0)
            return
        end

        phMob:setLocalVar('phDespawnTime', 0)
        local nobleMoldDelay  = 0

        -- Observed 2 spawns after 12 hours of undisturbed PH, with over 30 water weather changes
        -- with the observed weather durations, if we choose a random minute delay in [2,120], the Probability(spawn in a rain interval) ≈ 2
        -- (i.e. there's a chance to not spawn on a change to water weather if a high delay is selected, because weather will change before transform)
        if weather == xi.weather.RAIN then
            -- Noble Mold always spawns on the minute after weather change
            nobleMoldDelay  = math.random(2, 120) * 60
        elseif weather == xi.weather.SQUALL then
            -- TODO is chance actually higher for squall... Squall is a very rare weather so probably?
            nobleMoldDelay  = math.random(2, 20) * 60
        end

        if nobleMoldDelay > 0 then
            -- based on captures:
            -- Noble mold spawns exactly X minutes after weather change
            -- Noble mold spawns 3s after despawn of PH
            local phDespawnDelay = nobleMoldDelay - 3
            -- technically we will despawn on the tick after this delay passes, so we aren't getting Noble Mold in exactly "nobleMoldTimer" seconds :(
            -- offset by 1s to split that difference instead of complicating things with mob:timer()
            phMob:setLocalVar('phDespawnTime', GetSystemTime() + phDespawnDelay - 1)
        end
    end)
end

entity.onMobRoam = function(mob)
    -- Mob doesn't transform as soon as weather changes
    local spawnTime = mob:getLocalVar('phDespawnTime')
    if spawnTime == 0 or GetSystemTime() < spawnTime then
        return
    end

    -- PH has been undisturbed long enough while water weather persists
    local nobleMold = GetMobByID(ID.mob.NOBLE_MOLD)
    if not nobleMold then
        return
    end

    local p = mob:getPos()
    nobleMold:setSpawn(p.x, p.y, p.z, p.rot)
    -- Spawn Noble Mold and block PH until Noble Mold is killed
    DisallowRespawn(mob:getID(), true)
    DespawnMob(mob:getID()) -- normal 3s despawn timer

    -- Noble Mold spawns in place of PH as soon as despawn completes
    mob:addListener('DESPAWN', 'NOBLE_MOLD_TRANSFORMATION', function(mobArg)
        SpawnMob(ID.mob.NOBLE_MOLD)

        mobArg:removeListener('NOBLE_MOLD_TRANSFORMATION')
    end)
end

entity.onMobEngage = function(mob)
    disturbMob(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 115, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 116, 2, xi.regime.type.FIELDS)
end

return entity
