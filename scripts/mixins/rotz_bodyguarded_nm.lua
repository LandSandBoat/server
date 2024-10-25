-- Mixin for behavior that is common to five RoTZ NMs that have 21-24 hour respawns
-- These mobs are Centurio XII-I, Meteormauler Zhagtegg, Coo Keja the Unseen, Meww the Turtlerider, and Bright-handed Kunberry
-- These NMs have two bodyguard mobs that spawn with them if beastmen control the region they spawn in
require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.bodyguard = function(bodyguardedNM)
    bodyguardedNM:addListener('SPAWN', 'ROTZ_BODYGUARDED_NM_SPAWN', function(mob)
        local regionID = mob:getZone():getRegionID()
        -- will spawn with body guard mobs if region is beastmen controlled
        if GetRegionOwner(regionID) == xi.nation.BEASTMEN then
            local mobID = mob:getID()
            local guardOne = GetMobByID(mobID + 1)
            local guardTwo = GetMobByID(mobID + 2)

            if guardOne and guardTwo then
                local nmSpawnPos = mob:getSpawnPos()

                guardOne:setSpawn(nmSpawnPos.x - 2, nmSpawnPos.y, nmSpawnPos.z)
                guardTwo:setSpawn(nmSpawnPos.x - 4, nmSpawnPos.y, nmSpawnPos.z)
                guardOne:spawn()
                guardTwo:spawn()
                guardOne:follow(mob, xi.followType.ROAM)
                guardTwo:follow(mob, xi.followType.ROAM)

                mob:setLocalVar('[rotzBGNM]hasBodyGuards', 1)
            end
        end
    end)

    bodyguardedNM:addListener('ENGAGE', 'ROTZ_BODYGUARDED_NM_ENGAGE', function(mob, target)
        if mob:getLocalVar('[rotzBGNM]hasBodyGuards') == 1 then
            local mobID = mob:getID()

            for i = 1, 2 do
                local guard = GetMobByID(mobID + i)

                if
                    guard and
                    guard:isAlive() and
                    guard:getCurrentAction() == xi.act.ROAMING
                then
                    guard:updateEnmity(target)
                end
            end
        end
    end)

    bodyguardedNM:addListener('DEATH', 'ROTZ_BODYGUARDED_NM_DEATH', function(mob)
        if
            mob:getLocalVar('[rotzBGNM]hasBodyGuards') == 1 and
            mob:getLocalVar('[rotzBGNM]onDeathCalled') == 0
        then
            local mobID = mob:getID()

            for i = 1, 2 do
                local guardId = mobID + i
                local guard = GetMobByID(guardId)
                if guard and guard:isSpawned() then
                    DespawnMob(guardId)
                end
            end

            mob:setLocalVar('[rotzBGNM]onDeathCalled', 1)
        end
    end)
end

return g_mixins.bodyguard
