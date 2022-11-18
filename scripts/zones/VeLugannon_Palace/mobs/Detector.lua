-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Detector
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

local scDetectorPaths =
{
    ISLAND1 =
    {
        a =
        {
            { x = 410, y = 16, z = -20 },
            { x = 423, y = 16, z = -20 },
            { x = 430, y = 16, z = -25 },
            { x = 446, y = 16, z = -36 },
            { x = 459, y = 16, z = -26 },
            { x = 460, y = 16, z = -6 },
            { x = 460, y = 16, z = 19 },
            { x = 414, y = 16, z = 21 },
            { x = 395, y = 16, z = 39 },
            { x = 380, y = 16, z = 26 },
            { x = 380, y = 16, z = 2 },
            { x = 380, y = 16, z = -19 },
        },
        b =
        {
            { x = 380, y = 16, z = -19 },
            { x = 380, y = 16, z = 2 },
            { x = 380, y = 16, z = 26 },
            { x = 395, y = 16, z = 39 },
            { x = 414, y = 16, z = 21 },
            { x = 460, y = 16, z = 19 },
            { x = 460, y = 16, z = -6 },
            { x = 459, y = 16, z = -26 },
            { x = 446, y = 16, z = -36 },
            { x = 430, y = 16, z = -25 },
            { x = 423, y = 16, z = -20 },
            { x = 410, y = 16, z = -20 },
            { x = 380, y = 16, z = -19 },
        },
    },
    ISLAND2 =
    {
        a =
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
        b =
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
    },
    ISLAND3 =
    {
        a =
        {
            { x = -418, y = 16, z = -20 },
            { x = -460, y = 16, z = -20 },
            { x = -460, y = 16, z = 21 },
            { x = -459, y = 16, z = 26 },
            { x = -430, y = 16, z = 56 },
            { x = -426, y = 16, z = 60 },
            { x = -390, y = 16, z = 60 },
            { x = -382, y = 16, z = 56 },
            { x = -380, y = 16, z = 50 },
            { x = -380, y = 16, z = -24 },
            { x = -391, y = 16, z = -36 },
            { x = -410, y = 16, z = -25 },
            { x = -414, y = 16, z = -20 },
        },
        b =
        {
            { x = -414, y = 16, z = -20 },
            { x = -410, y = 16, z = -25 },
            { x = -391, y = 16, z = -36 },
            { x = -380, y = 16, z = -24 },
            { x = -380, y = 16, z = 50 },
            { x = -382, y = 16, z = 56 },
            { x = -390, y = 16, z = 60 },
            { x = -426, y = 16, z = 60 },
            { x = -430, y = 16, z = 56 },
            { x = -459, y = 16, z = 26 },
            { x = -460, y = 16, z = 21 },
            { x = -460, y = 16, z = -20 },
            { x = -418, y = 16, z = -20 },
        },
    },
    ISLAND4 =
    {
        a =
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
        b =
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
        }
    }
}

local detectorPaths =
{
    ISLAND1 =
    {
        a =
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
        b =
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
    },
    ISLAND2 =
    {
        a =
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
        b =
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
    ISLAND3 =
    {
        a =
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
        b =
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
    },
    ISLAND4 =
    {
        a =
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
        b =
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
        }
    }
}

local detectors =
{
    { ID.mob.SC_DETECTORS.DET1, scDetectorPaths.ISLAND1.a },
    { ID.mob.SC_DETECTORS.DET2, scDetectorPaths.ISLAND1.b },
    { ID.mob.SC_DETECTORS.DET3, scDetectorPaths.ISLAND2.a },
    { ID.mob.SC_DETECTORS.DET4, scDetectorPaths.ISLAND2.b },
    { ID.mob.SC_DETECTORS.DET5, scDetectorPaths.ISLAND3.a },
    { ID.mob.SC_DETECTORS.DET6, scDetectorPaths.ISLAND3.b },
    { ID.mob.SC_DETECTORS.DET7, scDetectorPaths.ISLAND4.a },
    { ID.mob.SC_DETECTORS.DET8, scDetectorPaths.ISLAND4.b },
    {    ID.mob.DETECTORS.DET9,   detectorPaths.ISLAND1.a },
    {   ID.mob.DETECTORS.DET10,   detectorPaths.ISLAND1.b },
    {   ID.mob.DETECTORS.DET11,   detectorPaths.ISLAND2.a },
    {   ID.mob.DETECTORS.DET12,   detectorPaths.ISLAND2.b },
    {   ID.mob.DETECTORS.DET13,   detectorPaths.ISLAND3.a },
    {   ID.mob.DETECTORS.DET14,   detectorPaths.ISLAND3.b },
    {   ID.mob.DETECTORS.DET15,   detectorPaths.ISLAND4.a },
    {   ID.mob.DETECTORS.DET16,   detectorPaths.ISLAND4.b }
}

local canDetectorSummonSC = function(mob)
    for _,v in pairs(ID.mob.SC_DETECTORS) do
        if mob:getID() == v then
            return true
        end
    end

    return false
end

local spawnCaretaker = function(detector)
    detector:setLocalVar("summoning", 1)
    detector:entityAnimationPacket("casm")
    detector:setAutoAttackEnabled(false)
    detector:setMobAbilityEnabled(false)

    detector:timer(5000, function(mob)
        if mob:isAlive() then
            local caretaker = GetMobByID(mob:getID() + 1)
            local petCount = mob:getLocalVar("petCount")
            caretaker:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
            mob:entityAnimationPacket("shsm")
            caretaker:spawn()
            if mob:getTarget() ~= nil then
                caretaker:updateEnmity(mob:getTarget())
            else
                DespawnMob(caretaker)
            end
            mob:setLocalVar("petCount", petCount + 1)
            mob:setLocalVar("summoning", 0)
            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
        end
    end)
end

local spawnSteamCleaner = function(mob)
    local sc = GetMobByID(ID.mob.STEAM_CLEANER)
    if os.time() >= GetServerVariable("[POP]SteamCleaner") and math.random(100) < 20 then
        if not sc:isSpawned() then
            mob:setLocalVar("summoning", 1)
            mob:entityAnimationPacket("casm")
            mob:setAutoAttackEnabled(false)
            mob:setMobAbilityEnabled(false)

            mob:timer(5000, function(mobArg)
                if mobArg:isAlive() then
                    local petCount = mobArg:getLocalVar("petCount")
                    mobArg:entityAnimationPacket("shsm")
                    sc:setSpawn(mobArg:getXPos() + 1, mobArg:getYPos(), mobArg:getZPos() + 1)
                    sc:spawn()
                    sc:setLocalVar("spawner", mobArg:getID())
                    if mobArg:getTarget() ~= nil then
                        sc:updateEnmity(mobArg:getTarget())
                    end
                    mobArg:setLocalVar("iSpawnedSC", 1)
                    mobArg:setLocalVar("petCount", petCount + 1)
                    mobArg:setLocalVar("summoning", 0)
                    mobArg:setAutoAttackEnabled(true)
                    mobArg:setMobAbilityEnabled(true)
                end
            end)
            return true
        end
    end
    return false
end

entity.onMobSpawn = function(mob)
    for _, v in pairs(detectors) do
        if mob:getID() == v[1] then
            mob:pathThrough(v[2], xi.path.flag.PATROL)
        end
    end

end

entity.onMobFight = function(mob, target)
    local caretaker = GetMobByID(mob:getID() + 1)
    local petCount = mob:getLocalVar("petCount")
    local sc = GetMobByID(ID.mob.STEAM_CLEANER)

    if mob:getLocalVar("summoning") == 0 then
        if
            petCount <= 5 and
            mob:getBattleTime() % 15 < 3 and
            mob:getBattleTime() > 3 and
            not caretaker:isSpawned() and
            canDetectorSummonSC(mob)
        then
            if spawnSteamCleaner(mob) then
                return
            elseif mob:getLocalVar("iSpawnedSC") and not sc:isSpawned() then -- If this specific detector spawned SC - dont spawn caretakers until SC is dead
                spawnCaretaker(mob)
            end
        elseif
            petCount <= 5 and
            mob:getBattleTime() % 15 < 3 and
            mob:getBattleTime() > 3 and
            not caretaker:isSpawned()
        then
            spawnCaretaker(mob)
        end
    end

    -- make sure pet has a target
    if caretaker:getCurrentAction() == xi.act.ROAMING then
        caretaker:updateEnmity(target)
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
    mob:resetLocalVars()
    if canDetectorSummonSC(mob) then
        mob:setRespawnTime(1800)
    end
end

return entity
