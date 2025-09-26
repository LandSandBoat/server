-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Defender
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('petRespawn', GetSystemTime() + 10)
end

entity.onMobFight = function(mob, target)
    -- Summons an Aura Gear every 10 seconds.
    local petCount = mob:getLocalVar('petCount')
    local petTimer = mob:getLocalVar('petRespawn')
    local auraGear = GetMobByID(mob:getID() + 1)
    local summoningPet = mob:getLocalVar('summoningPet')

    -- Check if we should spawn a new pet
    local shouldSpawnPet = petCount < 5 and
                        GetSystemTime() > petTimer and
                        summoningPet == 0 and
                        (not auraGear or not auraGear:isSpawned())

    if
        shouldSpawnPet and
        auraGear and
        xi.mob.callPets(mob, auraGear:getID(), { inactiveTime = 5000, ignoreBusy = true })
    then
        mob:setLocalVar('petCount', petCount + 1)
        mob:setLocalVar('summoningPet', 1)
        mob:timer(5000, function(mobArg)
            if mobArg then
                mobArg:setLocalVar('summoningPet', 0)
            end
        end)
    end
end

entity.onMobDisengage = function(mob)
    local auraGearId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(auraGearId):isSpawned() then
        DespawnMob(auraGearId)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local auraGearId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(auraGearId):isSpawned() then
        DespawnMob(auraGearId)
    end
end

return entity
