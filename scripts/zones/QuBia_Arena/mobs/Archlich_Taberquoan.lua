-----------------------------------
-- Area: Qu'Bia Arena
--   NM: Archlich Taber'quoan
-- Mission 5-1 BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 32)
end

entity.onMobEngage = function(mob, player)
end

entity.onMobFight = function(mob, target)
    local battleTime = mob:getBattleTime()

    if battleTime - mob:getLocalVar('RepopWarriors') > 30 then
        local warriorsSpawned = 0

        -- Count Warriors.  This is necessary since if you are at the end
        -- of the mob list, count may not be accurate if trying to do both
        -- at the same time.
        for warrior = mob:getID() + 3, mob:getID() + 6 do
            if GetMobByID(warrior):isSpawned() then
                warriorsSpawned = warriorsSpawned + 1
            end
        end

        -- Iterate over possible warriors to find the next valid one and
        -- spawn it.  Stagger them by 5s if two are being spawned in the same loop.
        if warriorsSpawned < 2 then
            local neededSpawns = 2 - warriorsSpawned
            for warrior = mob:getID() + 3, mob:getID() + 6 do
                if not GetMobByID(warrior):isSpawned() and neededSpawns > 0 then
                    local warriorMob = SpawnMob(warrior)

                    if warriorMob then
                        warriorMob:updateEnmity(target)
                        if neededSpawns == 2 then
                            warriorMob:stun(5000)
                        end
                    end

                    neededSpawns = neededSpawns - 1
                end
            end
        end

        mob:setLocalVar('RepopWarriors', battleTime)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
