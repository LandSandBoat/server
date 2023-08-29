-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Detector
-----------------------------------
local ID = zones[xi.zone.VELUGANNON_PALACE]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('petCount', 1)
end

local getMobToSpawn = function(detector)
    local detectorID              = detector:getID()
    local canSpawnSteamCleaner    = GetServerVariable('[POP]SteamCleaner') < os.time() and utils.contains(detectorID, ID.mob.STEAM_CLEANER_DETECTORS)
    local steamCleanerSpawnChance = 10 -- percent
    local steamCleaner            = GetMobByID(ID.mob.STEAM_CLEANER)

    if steamCleaner:isSpawned() then
        -- If this is the Detector that spawned SC, then he should continue to return SC
        if detector:getLocalVar('SpawnedSC') == 1 then
            return steamCleaner
        end

        -- else fall through to the last return at the bottom that returns Caretaker
    elseif canSpawnSteamCleaner and math.random(1, 100) <= steamCleanerSpawnChance then
        -- Set this as the Detector that spawned SC
        detector:setLocalVar('SpawnedSC', 1)
        return steamCleaner
    end

    return GetMobByID(detectorID + 1) -- return this detector's caretaker
end

entity.onMobFight = function(mob, target)
    local mobToSpawn = getMobToSpawn(mob)
    local petCount   = mob:getLocalVar('petCount')

    -- Summons a mob (Caretaker or Steam Cleaner) every 15 seconds.
    -- TODO: Casting animation for before summons. When he spawns them isn't exactly retail accurate.
    --       Should be ~10s to start cast, and another ~5 to finish.
    -- Detectors can also still spawn the mobToSpawns while sleeping, moving, etc.
    -- Maximum number of pets Detector can spawn is 5

    if
        petCount <= 5 and
        mob:getBattleTime() % 15 < 3 and
        mob:getBattleTime() > 3 and
        not mobToSpawn:isSpawned()
    then
        mobToSpawn:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
        mobToSpawn:spawn()
        mobToSpawn:updateEnmity(target)
        mob:setLocalVar('petCount', petCount + 1)
    end

    -- make sure pet has a target
    if mobToSpawn:getCurrentAction() == xi.act.ROAMING then
        mobToSpawn:updateEnmity(target)
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

    mob:resetLocalVars()

    if GetMobByID(caretakerId):isSpawned() then
        DespawnMob(caretakerId)
    end
end

return entity
