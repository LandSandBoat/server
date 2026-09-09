-----------------------------------
-- Normal BST and SMN mobs summon after 60 seconds spent standing still out of combat.
-- The timer starts when the pet dies or the owner spawns without a pet.
-- Walking pauses the timer. Losing all hate and returning to roaming resets it.
-- NMs keep their own summon rules.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
-----------------------------------

g_mixins.pet_resummon = function(mob)
    local linkedPet = mob:getPet()
    if linkedPet then
        -- Reset after the pet spawns so a cancelled summon does not erase the time already counted.
        linkedPet:addListener('SPAWN', 'PET_RESUMMON_RESET', function(petArg)
            -- Following the owner away from the summon point must not make the pet return home or despawn.
            petArg:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)

            local owner = petArg:getMaster()
            if owner then
                owner:setLocalVar('[Pet]Idle', 0)
                owner:setLocalVar('[Pet]Counting', 0)
                owner:setLocalVar('[Pet]Retry', 0)
            end
        end)
    end

    mob:addListener('SPAWN', 'PET_RESUMMON_SPAWN', function(mobArg)
        -- Call Beast and spirit spells must not bypass the idle timer or summon during combat.
        if mobArg:getMainJob() == xi.job.BST then
            mobArg:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
        elseif mobArg:getMainJob() == xi.job.SMN then
            mobArg:setSpellList(0)
        end

        mobArg:setLocalVar('[Pet]Idle', 0)
        mobArg:setLocalVar('[Pet]Counting', 0)
        mobArg:setLocalVar('[Pet]Retry', 0)
    end)

    -- Losing all hate starts the 60-second wait over.
    mob:addListener('DISENGAGE', 'PET_RESUMMON_DISENGAGE', function(mobArg)
        mobArg:setLocalVar('[Pet]Idle', 0)
        mobArg:setLocalVar('[Pet]Counting', 0)
        mobArg:setLocalVar('[Pet]Retry', 0)
    end)

    mob:addListener('TICK', 'PET_RESUMMON_TICK', function(mobArg, elapsed)
        local pet = mobArg:getPet()
        if not pet or pet:isAlive() then
            return
        end

        local retry = mobArg:getLocalVar('[Pet]Retry')
        if retry > 0 then
            retry = math.max(0, retry - elapsed)
            mobArg:setLocalVar('[Pet]Retry', retry)
            if retry > 0 then
                return
            end
        end

        if
            not mobArg:isAlive() or
            mobArg:isEngaged() or
            mobArg:getCurrentAction() ~= xi.action.category.ROAMING
        then
            return
        end

        -- Do not count the first update. It may include time from before the pet died.
        if mobArg:getLocalVar('[Pet]Counting') == 0 then
            mobArg:setLocalVar('[Pet]Counting', 1)
            return
        end

        if mobArg:isFollowingPath() or xi.combat.behavior.isEntityBusy(mobArg) then
            return
        end

        -- Count time between updates so server delays do not stretch the 60-second wait.
        local idleTime = math.min(60000, mobArg:getLocalVar('[Pet]Idle') + elapsed)
        mobArg:setLocalVar('[Pet]Idle', idleTime)
        if idleTime < 60000 then
            return
        end

        -- If a summon is blocked, keep the 60 seconds already counted and try again in three seconds.
        mobArg:setLocalVar('[Pet]Retry', 3000)
        xi.mob.callPets(mobArg, nil, { inactiveTime = 3000, keepSpawnPoint = true, requireValidPosition = true, requireIdle = true })
    end)
end

return g_mixins.pet_resummon
