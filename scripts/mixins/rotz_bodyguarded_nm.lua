-- Mixin for behavior that is common to six RoTZ NMs that have 21-24 hour respawns
-- These mobs are Centurio XII-I, Meteormauler Zhagtegg, Coo Keja the Unseen, Meww the Turtlerider,
-- Bo'Who Warmonger, and Bright-handed Kunberry
-- These NMs have two bodyguard mobs that spawn with them if beastmen control the region they spawn in
-- The bodyguards just link as normal mobs and are not in a party or superlinking
require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.bodyguard = function(bodyguardedNM)
    -- function for bodyguard roaming logic
    local bodyGuardRoam = function(mob)
        -- if bodyguarded NM is missing or dead then despawn the bodyguard
        if not bodyguardedNM or (bodyguardedNM and bodyguardedNM:isDead()) then
            DespawnMob(mob:getID())
        -- else if bodyguard not following then follow NM
        elseif
            not mob:hasFollowTarget() and bodyguardedNM
        then
            mob:follow(bodyguardedNM, xi.followType.ROAM)
        end
    end

    local bodyGuardDespawn = function(mob)
        -- remove listeners on despawn as they are setup again on spawn
        mob:removeListener('ROTZ_BODYGUARD_ROAM')
        mob:removeListener('ROTZ_BODYGUARD_DESPAWN')
    end

    bodyguardedNM:addListener('SPAWN', 'ROTZ_BODYGUARDED_NM_SPAWN', function(mob)
        local regionID = mob:getZone():getRegionID()
        -- will spawn with body guard mobs if region is beastmen controlled
        if GetRegionOwner(regionID) == xi.nation.BEASTMEN then
            local nmID = mob:getID()
            local nmSpawnPos = mob:getSpawnPos()
            local guardIDs = { nmID + 1, nmID + 2 }
            local spawnPosOffset = { 2, 4 }

            for index, guardID in ipairs(guardIDs) do
                local guard = GetMobByID(guardID)

                if guard then
                    -- despawn bodyguard if they are still spawned for some reason
                    if guard:isSpawned() then
                        DespawnMob(guard:getID())
                    end

                    guard:setSpawn(nmSpawnPos.x - spawnPosOffset[index], nmSpawnPos.y, nmSpawnPos.z)
                    guard:spawn()
                    guard:follow(mob, xi.followType.ROAM)
                    guard:addListener('ROAM_TICK', 'ROTZ_BODYGUARD_ROAM', bodyGuardRoam)
                    guard:addListener('DESPAWN', 'ROTZ_BODYGUARD_DESPAWN', bodyGuardDespawn)
                    guard:setMobMod(xi.mobMod.NO_DESPAWN, 1)
                end
            end
        end
    end)
end

return g_mixins.bodyguard
