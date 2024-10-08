-----------------------------------
-- Area: Carpenters' Landing
--   NM: Cryptonberry Executor
-- !pos 120.615 -5.457 -390.133 2
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
---@type TMobEntity
local entity = {}

local assassins = { ID.mob.CRYPTONBERRY_EXECUTOR + 1, ID.mob.CRYPTONBERRY_EXECUTOR + 2, ID.mob.CRYPTONBERRY_EXECUTOR + 3 }

local function unlockAssassinTwoHours()
    for _, assassinID in ipairs(assassins) do
        local assassin = GetMobByID(assassinID)
        if assassin then
            assassin:setLocalVar('unlockTwoHour', 1)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobFight = function(mob, target)
    -- spawn assassins when enmity is gained against Executor
    if
        mob:getLocalVar('spawnedAssassins') == 0 and
        mob:getCE(target) > 0
    then
        mob:setLocalVar('spawnedAssassins', 1)

        -- inject packet for 2hr animation when spawning
        mob:injectActionPacket(mob:getID(), 11, 439, 0, 0x18, 0, 0, 307)
        for _, assassinID in ipairs(assassins) do
            local assassin = SpawnMob(assassinID)
            if assassin then
                assassin:updateEnmity(target)
            end
        end
    end

    -- if any assassin killed before executor
    if
        mob:getLocalVar('spawnedAssassins') == 1 and
        mob:getLocalVar('assassinsKilled') > 0 and
        mob:getLocalVar('usedTwoHour') == 0
    then
    -- have executor use 2hr and unlock the 2hrs of other assassins
        mob:setLocalVar('usedTwoHour', 1)
        mob:messageText(mob, ID.text.CRYPTONBERRY_EXECUTOR_2HR)
        -- Use Mijin Gakure
        mob:useMobAbility(731)
        -- unlock the 2hrs of the assassins
        unlockAssassinTwoHours()
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar('firstOnMobDeathCall') == 0 then
        mob:setLocalVar('firstOnMobDeathCall', 1)
        mob:messageText(mob, ID.text.CRYPTONBERRY_EXECUTOR_DIE)
        -- if executor is the first mob killed
        if mob:getLocalVar('assassinsKilled') == 0 then
            -- then force one random assassin to use 2hr
            local randomAssassin = GetMobByID(assassins[math.random(1, #assassins)])
            if randomAssassin then
                randomAssassin:setLocalVar('triggerTwoHour', 1)
            end

            -- unlock the 2hrs of the other two (to use at random threshold)
            unlockAssassinTwoHours()
        end
    end
end

return entity
