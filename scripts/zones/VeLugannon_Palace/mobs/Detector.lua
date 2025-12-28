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

-- Individual paths for each detector
local detectorPaths =
{
    -- Steam Cleaner Placeholders
    steamCleanerPHs =
    {
        [ID.mob.STEAM_CLEANER - 26] =
        {
            { x = 380, y = 16, z = -19 },
            { x = 380, y = 16, z =   2 },
            { x = 380, y = 16, z =  26 },
            { x = 395, y = 16, z =  39 },
            { x = 414, y = 16, z =  21 },
            { x = 460, y = 16, z =  19 },
            { x = 460, y = 16, z =  -6 },
            { x = 459, y = 16, z = -26 },
            { x = 446, y = 16, z = -36 },
            { x = 430, y = 16, z = -25 },
            { x = 423, y = 16, z = -20 },
            { x = 410, y = 16, z = -20 },
            { x = 380, y = 16, z = -19 },
        },

        [ID.mob.STEAM_CLEANER - 24] =
        {
            { x = 410, y = 16, z = -20 },
            { x = 423, y = 16, z = -20 },
            { x = 430, y = 16, z = -25 },
            { x = 446, y = 16, z = -36 },
            { x = 459, y = 16, z = -26 },
            { x = 460, y = 16, z =  -6 },
            { x = 460, y = 16, z =  19 },
            { x = 414, y = 16, z =  21 },
            { x = 395, y = 16, z =  39 },
            { x = 380, y = 16, z =  26 },
            { x = 380, y = 16, z =   2 },
            { x = 380, y = 16, z = -19 },
        },

        [ID.mob.STEAM_CLEANER - 22] =
        {
            { x = -418, y = 16, z = -20 },
            { x = -460, y = 16, z = -20 },
            { x = -460, y = 16, z =  21 },
            { x = -459, y = 16, z =  26 },
            { x = -430, y = 16, z =  56 },
            { x = -426, y = 16, z =  60 },
            { x = -390, y = 16, z =  60 },
            { x = -382, y = 16, z =  56 },
            { x = -380, y = 16, z =  50 },
            { x = -380, y = 16, z = -24 },
            { x = -391, y = 16, z = -36 },
            { x = -410, y = 16, z = -25 },
            { x = -414, y = 16, z = -20 },
        },

        [ID.mob.STEAM_CLEANER - 20] =
        {
            { x = -414, y = 16, z = -20 },
            { x = -410, y = 16, z = -25 },
            { x = -391, y = 16, z = -36 },
            { x = -380, y = 16, z = -24 },
            { x = -380, y = 16, z =  50 },
            { x = -382, y = 16, z =  56 },
            { x = -390, y = 16, z =  60 },
            { x = -426, y = 16, z =  60 },
            { x = -430, y = 16, z =  56 },
            { x = -459, y = 16, z =  26 },
            { x = -460, y = 16, z =  21 },
            { x = -460, y = 16, z = -20 },
            { x = -418, y = 16, z = -20 },
        },

        [ID.mob.STEAM_CLEANER - 18] =
        {
            { x = 379, y = 16, z = 301 },
            { x = 378, y = 16, z = 339 },
            { x = 333, y = 16, z = 340 },
            { x = 322, y = 16, z = 353 },
            { x = 303, y = 16, z = 350 },
            { x = 299, y = 16, z = 336 },
            { x = 299, y = 16, z = 308 },
            { x = 307, y = 16, z = 300 },
            { x = 348, y = 16, z = 300 },
            { x = 379, y = 16, z = 301 },
        },

        [ID.mob.STEAM_CLEANER - 16] =
        {
            { x = 379, y = 16, z = 301 },
            { x = 348, y = 16, z = 300 },
            { x = 307, y = 16, z = 300 },
            { x = 299, y = 16, z = 308 },
            { x = 299, y = 16, z = 336 },
            { x = 303, y = 16, z = 350 },
            { x = 322, y = 16, z = 353 },
            { x = 333, y = 16, z = 340 },
            { x = 378, y = 16, z = 339 },
            { x = 379, y = 16, z = 301 },
        },

        [ID.mob.STEAM_CLEANER - 14] =
        {
            { x = -362, y = 16, z = 317 },
            { x = -346, y = 16, z = 300 },
            { x = -327, y = 16, z = 300 },
            { x = -306, y = 16, z = 300 },
            { x = -300, y = 16, z = 310 },
            { x = -299, y = 16, z = 339 },
            { x = -300, y = 16, z = 371 },
            { x = -309, y = 16, z = 380 },
            { x = -340, y = 16, z = 379 },
            { x = -373, y = 16, z = 379 },
            { x = -380, y = 16, z = 370 },
            { x = -379, y = 16, z = 334 },
            { x = -362, y = 16, z = 317 },
        },

        [ID.mob.STEAM_CLEANER - 12] =
        {
            { x = -362, y = 16, z = 317 },
            { x = -379, y = 16, z = 334 },
            { x = -380, y = 16, z = 370 },
            { x = -373, y = 16, z = 379 },
            { x = -340, y = 16, z = 379 },
            { x = -309, y = 16, z = 380 },
            { x = -300, y = 16, z = 371 },
            { x = -299, y = 16, z = 339 },
            { x = -300, y = 16, z = 310 },
            { x = -306, y = 16, z = 300 },
            { x = -327, y = 16, z = 300 },
            { x = -346, y = 16, z = 300 },
            { x = -362, y = 16, z = 317 },
        },
    },

    -- Regular Detectors with pathing (non-PH)
    regularDetectors =
    {
        [ID.mob.DETECTOR[53]] =
        {
            { x = 419, y = 16, z = -260 },
            { x = 420, y = 16, z = -220 },
            { x = 420, y = 16, z = -180 },
            { x = 379, y = 16, z = -179 },
            { x = 340, y = 16, z = -180 },
            { x = 340, y = 16, z = -220 },
            { x = 339, y = 16, z = -260 },
            { x = 380, y = 16, z = -259 },
            { x = 419, y = 16, z = -260 },
        },

        [ID.mob.DETECTOR[54]] =
        {
            { x = 419, y = 16, z = -260 },
            { x = 380, y = 16, z = -259 },
            { x = 339, y = 16, z = -260 },
            { x = 340, y = 16, z = -220 },
            { x = 340, y = 16, z = -180 },
            { x = 379, y = 16, z = -179 },
            { x = 420, y = 16, z = -180 },
            { x = 420, y = 16, z = -220 },
        },

        [ID.mob.DETECTOR[55]] =
        {
            { x = -419, y = 16, z = -259 },
            { x = -419, y = 16, z = -219 },
            { x = -419, y = 16, z = -179 },
            { x = -380, y = 16, z = -179 },
            { x = -339, y = 16, z = -179 },
            { x = -339, y = 16, z = -220 },
            { x = -340, y = 16, z = -259 },
            { x = -381, y = 16, z = -259 },
            { x = -419, y = 16, z = -259 },
        },

        [ID.mob.DETECTOR[56]] =
        {
            { x = -419, y = 16, z = -259 },
            { x = -381, y = 16, z = -259 },
            { x = -340, y = 16, z = -259 },
            { x = -339, y = 16, z = -220 },
            { x = -339, y = 16, z = -179 },
            { x = -380, y = 16, z = -179 },
            { x = -419, y = 16, z = -179 },
            { x = -419, y = 16, z = -219 },
            { x = -419, y = 16, z = -259 },
        },

        [ID.mob.DETECTOR[65]] =
        {
            { x = 220, y = 16, z = 420 },
            { x = 220, y = 16, z = 452 },
            { x = 212, y = 16, z = 460 },
            { x = 194, y = 16, z = 460 },
            { x = 171, y = 16, z = 460 },
            { x = 159, y = 16, z = 440 },
            { x = 132, y = 16, z = 440 },
            { x = 140, y = 16, z = 418 },
            { x = 140, y = 16, z = 380 },
            { x = 180, y = 16, z = 380 },
            { x = 210, y = 16, z = 380 },
            { x = 220, y = 16, z = 388 },
        },

        [ID.mob.DETECTOR[66]] =
        {
            { x = 220, y = 16, z = 388 },
            { x = 210, y = 16, z = 380 },
            { x = 180, y = 16, z = 380 },
            { x = 140, y = 16, z = 380 },
            { x = 140, y = 16, z = 418 },
            { x = 132, y = 16, z = 440 },
            { x = 159, y = 16, z = 440 },
            { x = 171, y = 16, z = 460 },
            { x = 194, y = 16, z = 460 },
            { x = 212, y = 16, z = 460 },
            { x = 220, y = 16, z = 452 },
            { x = 220, y = 16, z = 420 },
        },

        [ID.mob.DETECTOR[67]] =
        {
            { x = -220, y = 16, z = 420 },
            { x = -220, y = 16, z = 460 },
            { x = -176, y = 16, z = 460 },
            { x = -135, y = 16, z = 460 },
            { x = -126, y = 16, z = 450 },
            { x = -126, y = 16, z = 391 },
            { x = -133, y = 16, z = 380 },
            { x = -176, y = 16, z = 380 },
            { x = -220, y = 16, z = 380 },
        },

        [ID.mob.DETECTOR[68]] =
        {
            { x = -220, y = 16, z = 380 },
            { x = -176, y = 16, z = 380 },
            { x = -133, y = 16, z = 380 },
            { x = -126, y = 16, z = 391 },
            { x = -126, y = 16, z = 450 },
            { x = -135, y = 16, z = 460 },
            { x = -176, y = 16, z = 460 },
            { x = -220, y = 16, z = 460 },
            { x = -220, y = 16, z = 420 },
        },
    },
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

entity.onMobSpawn = function(mob)
    local mobID = mob:getID()
    local path = detectorPaths.steamCleanerPHs[mobID] or detectorPaths.regularDetectors[mobID]

    -- Check if this detector has a defined path
    if path then
        -- Start pathing along this detector's unique route
        mob:pathThrough(path, bit.bor(xi.path.flag.COORDS))
    end
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('petRespawn', GetSystemTime() + 10)
end

entity.onMobRoam = function(mob)
    local mobID = mob:getID()
    local path = detectorPaths.steamCleanerPHs[mobID] or detectorPaths.regularDetectors[mobID]

    -- Check if this detector should be pathing
    if path then
        -- If not currently pathing, resume this detector's path
        if not mob:isFollowingPath() then
            mob:pathThrough(path, bit.bor(xi.path.flag.COORDS))
        end
    end
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
        local callPetParams =
        {
            inactiveTime    = 5000,
            ignoreBusy      = true,
            persistOnDeath  = true,
        }

        if xi.mob.callPets(mob, mobToSpawn:getID(), callPetParams) then
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
    local mobID = mob:getID()
    local path = detectorPaths.steamCleanerPHs[mobID] or detectorPaths.regularDetectors[mobID]

    mob:resetLocalVars()

    if GetMobByID(caretakerId):isSpawned() then
        DespawnMob(caretakerId)
    end

    -- Resume this detector's path after combat
    if path then
        mob:pathThrough(path, bit.bor(xi.path.flag.COORDS))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local steamCleaner = GetMobByID(ID.mob.STEAM_CLEANER)

    mob:resetLocalVars()
    -- Ensure Steam Cleaner can be summoned again
    if steamCleaner then
        steamCleaner:setLocalVar('midSummon', 0)
    end
end

return entity
