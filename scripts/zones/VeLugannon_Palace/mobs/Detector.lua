-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Detector
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
-----------------------------------
---@type TMobEntity
local entity = {}

local detectorPHTable =
{

    ID.mob.STEAM_CLEANER - 26, -- E Lower Chamber
    ID.mob.STEAM_CLEANER - 24, -- E Lower Chamber
    ID.mob.STEAM_CLEANER - 22, -- W Lower Chamber
    ID.mob.STEAM_CLEANER - 20, -- W Lower Chamber
    ID.mob.STEAM_CLEANER - 18, -- NE Lower Chamber
    ID.mob.STEAM_CLEANER - 16, -- NE Lower Chamber
    ID.mob.STEAM_CLEANER - 14, -- NW Lower Chamber
    ID.mob.STEAM_CLEANER - 12, -- NW Lower Chamber
}

local getMobToSpawn = function(detector)
    local detectorID   = detector:getID()
    local caretaker    = GetMobByID(detectorID + 1)
    local steamCleaner = GetMobByID(ID.mob.STEAM_CLEANER)

    -- Early return: Detector isn't able to spawn Steam Cleaner.
    if not utils.contains(detectorID, detectorPHTable) then
        return caretaker
    end

    -- Early return: Steam cleaner can't spawn.
    if
        not steamCleaner or
        steamCleaner:isSpawned()
    then
        return caretaker
    end

    -- Early return: Luck check failed.
    if math.random(1, 100) <= 90 then
        return caretaker
    end

    -- Early return: Too soon to spawn Steam Cleaner.
    if GetSystemTime() < GetServerVariable('[POP]SteamCleaner') then
        return caretaker
    end

    -- Early return: Steam Cleaner is already being summoned.
    if steamCleaner:getLocalVar('midSummon') == 1 then
        return caretaker
    end

    -- From this point on, this detector can pop Steam Cleaner.
    steamCleaner:setLocalVar('midSummon', 1)

    return steamCleaner
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('petRespawn', GetSystemTime() + 10)
end

entity.onMobFight = function(mob, target)
    -- Summons a mob (Caretaker or Steam Cleaner) every 10 seconds.
    -- Detectors can also still spawn the mobToSpawns while sleeping, moving, etc.
    -- Maximum number of pets Detector can spawn is 5
    local petCount     = mob:getLocalVar('petCount')
    local petTimer     = mob:getLocalVar('petRespawn')
    local currentPetID = mob:getLocalVar('currentPet')
    local summoningPet = mob:getLocalVar('summoningPet')
    local currentPet   = nil

    -- Only get current pet if we have a valid ID stored
    if currentPetID > 0 then
        currentPet = GetMobByID(currentPetID)
    end

    -- Check if we should spawn a new pet
    local shouldSpawnPet = petCount < 5 and
                        GetSystemTime() > petTimer and
                        (not currentPet or not currentPet:isSpawned()) and
                        summoningPet == 0

    if shouldSpawnPet then
        local mobToSpawn = getMobToSpawn(mob)
        if xi.mob.callPets(mob, mobToSpawn:getID(), { inactiveTime = 5000, ignoreBusy = true }) then
            mob:setLocalVar('petCount', petCount + 1)
            mob:setLocalVar('currentPet', mobToSpawn:getID())
            mob:setLocalVar('summoningPet', 1)
            mob:timer(5000, function(mobArg)
                if mobArg then
                    mobArg:setLocalVar('summoningPet', 0)
                end
            end)
        end
    end
end

entity.onMobDisengage = function(mob)
    local caretakerId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(caretakerId):isSpawned() then
        DespawnMob(caretakerId)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local caretakerId = mob:getID() + 1
    local steamCleaner = GetMobByID(ID.mob.STEAM_CLEANER)

    mob:resetLocalVars()
    -- Ensure Steam Cleaner can be summoned again
    if steamCleaner then
        steamCleaner:setLocalVar('midSummon', 0)
    end

    if GetMobByID(caretakerId):isSpawned() then
        DespawnMob(caretakerId)
    end
end

return entity
