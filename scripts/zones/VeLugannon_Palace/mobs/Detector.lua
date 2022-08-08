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
            410, 16, -20,
            423, 16, -20,
            430, 16, -25,
            446, 16, -36,
            459, 16, -26,
            460, 16, -6,
            460, 16, 19,
            414, 16, 21,
            395, 16, 39,
            380, 16, 26,
            380, 16, 2,
            380, 16, -19,
        },
        b =
        {
            380, 16, -19,
            380, 16, 2,
            380, 16, 26,
            395, 16, 39,
            414, 16, 21,
            460, 16, 19,
            460, 16, -6,
            459, 16, -26,
            446, 16, -36,
            430, 16, -25,
            423, 16, -20,
            410, 16, -20,
            380, 16, -19,
        },
    },
    ISLAND2 =
    {
        a =
        {
            379, 16, 301,
            378, 16, 339,
            333, 16, 340,
            322, 16, 353,
            303, 16, 350,
            299, 16, 336,
            299, 16, 308,
            307, 16, 300,
            348, 16, 300,
            379, 16, 301,
        },
        b =
        {
            379, 16, 301,
            348, 16, 300,
            307, 16, 300,
            299, 16, 308,
            299, 16, 336,
            303, 16, 350,
            322, 16, 353,
            333, 16, 340,
            378, 16, 339,
            379, 16, 301,
        },
    },
    ISLAND3 =
    {
        a =
        {
            -418, 16, -20,
            -460, 16, -20,
            -460, 16, 21,
            -459, 16, 26,
            -430, 16, 56,
            -426, 16, 60,
            -390, 16, 60,
            -382, 16, 56,
            -380, 16, 50,
            -380, 16, -24,
            -391, 16, -36,
            -410, 16, -25,
            -414, 16, -20,
        },
        b =
        {
            -414, 16, -20,
            -410, 16, -25,
            -391, 16, -36,
            -380, 16, -24,
            -380, 16, 50,
            -382, 16, 56,
            -390, 16, 60,
            -426, 16, 60,
            -430, 16, 56,
            -459, 16, 26,
            -460, 16, 21,
            -460, 16, -20,
            -418, 16, -20,
        },
    },
    ISLAND4 =
    {
        a =
        {
            -362, 16, 317,
            -346, 16, 300,
            -327, 16, 300,
            -306, 16, 300,
            -300, 16, 310,
            -299, 16, 339,
            -300, 16, 371,
            -309, 16, 380,
            -340, 16, 379,
            -373, 16, 379,
            -380, 16, 370,
            -379, 16, 334,
            -362, 16, 317,
        },
        b =
        {
            -362, 16, 317,
            -379, 16, 334,
            -380, 16, 370,
            -373, 16, 379,
            -340, 16, 379,
            -309, 16, 380,
            -300, 16, 371,
            -299, 16, 339,
            -300, 16, 310,
            -306, 16, 300,
            -327, 16, 300,
            -346, 16, 300,
            -362, 16, 317,
        }
    }
}

local detectorPaths =
{
    ISLAND1 =
    {
        a =
        {
            220, 16, 420,
            220, 16, 452,
            212, 16, 460,
            194, 16, 460,
            171, 16, 460,
            159, 16, 440,
            132, 16, 440,
            140, 16, 418,
            140, 16, 380,
            180, 16, 380,
            210, 16, 380,
            220, 16, 388,
        },
        b =
        {
            220, 16, 388,
            210, 16, 380,
            180, 16, 380,
            140, 16, 380,
            140, 16, 418,
            132, 16, 440,
            159, 16, 440,
            171, 16, 460,
            194, 16, 460,
            212, 16, 460,
            220, 16, 452,
            220, 16, 420,
        },
    },
    ISLAND2 =
    {
        a =
        {
            -220, 16, 420,
            -220, 16, 460,
            -176, 16, 460,
            -135, 16, 460,
            -126, 16, 450,
            -126, 16, 391,
            -133, 16, 380,
            -176, 16, 380,
            -220, 16, 380,
        },
        b =
        {
            -220, 16, 380,
            -176, 16, 380,
            -133, 16, 380,
            -126, 16, 391,
            -126, 16, 450,
            -135, 16, 460,
            -176, 16, 460,
            -220, 16, 460,
            -220, 16, 420,
        },
    },
    ISLAND3 =
    {
        a =
        {
            419, 16, -260,
            420, 16, -220,
            420, 16, -180,
            379, 16, -179,
            340, 16, -180,
            340, 16, -220,
            339, 16, -260,
            380, 16, -259,
            419, 16, -260,
        },
        b =
        {
            419, 16, -260,
            380, 16, -259,
            339, 16, -260,
            340, 16, -220,
            340, 16, -180,
            379, 16, -179,
            420, 16, -180,
            420, 16, -220,
        },
    },
    ISLAND4 =
    {
        a =
        {
            -419, 16, -259,
            -381, 16, -259,
            -340, 16, -259,
            -339, 16, -220,
            -339, 16, -179,
            -380, 16, -179,
            -419, 16, -179,
            -419, 16, -219,
            -419, 16, -259,
        },
        b =
        {
            -419, 16, -259,
            -419, 16, -219,
            -419, 16, -179,
            -380, 16, -179,
            -339, 16, -179,
            -339, 16, -220,
            -340, 16, -259,
            -381, 16, -259,
            -419, 16, -259,
        }
    }
}

local detectors =
{
    { ID.mob.SC_DETECTORS.DET1, scDetectorPaths.ISLAND1.a},
    { ID.mob.SC_DETECTORS.DET2, scDetectorPaths.ISLAND1.b},
    { ID.mob.SC_DETECTORS.DET3, scDetectorPaths.ISLAND2.a},
    { ID.mob.SC_DETECTORS.DET4, scDetectorPaths.ISLAND2.b},
    { ID.mob.SC_DETECTORS.DET5, scDetectorPaths.ISLAND3.a},
    { ID.mob.SC_DETECTORS.DET6, scDetectorPaths.ISLAND3.b},
    { ID.mob.SC_DETECTORS.DET7, scDetectorPaths.ISLAND4.a},
    { ID.mob.SC_DETECTORS.DET8, scDetectorPaths.ISLAND4.b},
    {    ID.mob.DETECTORS.DET9,   detectorPaths.ISLAND1.a},
    {   ID.mob.DETECTORS.DET10,   detectorPaths.ISLAND1.b},
    {   ID.mob.DETECTORS.DET11,   detectorPaths.ISLAND2.a},
    {   ID.mob.DETECTORS.DET12,   detectorPaths.ISLAND2.b},
    {   ID.mob.DETECTORS.DET13,   detectorPaths.ISLAND3.a},
    {   ID.mob.DETECTORS.DET14,   detectorPaths.ISLAND3.b},
    {   ID.mob.DETECTORS.DET15,   detectorPaths.ISLAND4.a},
    {   ID.mob.DETECTORS.DET16,   detectorPaths.ISLAND4.b}
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
    detector:SetAutoAttackEnabled(false)
    detector:SetMobAbilityEnabled(false)

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
            mob:SetAutoAttackEnabled(true)
            mob:SetMobAbilityEnabled(true)
        end
    end)
end

local spawnSteamCleaner = function(mob)
    local sc = GetMobByID(ID.mob.STEAM_CLEANER)
    if os.time() >= GetServerVariable("[POP]SteamCleaner") and math.random(100) < 20 then
        if not sc:isSpawned() then
            mob:setLocalVar("summoning", 1)
            mob:entityAnimationPacket("casm")
            mob:SetAutoAttackEnabled(false)
            mob:SetMobAbilityEnabled(false)

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
                    mobArg:SetAutoAttackEnabled(true)
                    mobArg:SetMobAbilityEnabled(true)
                end
            end)
            return true
        end
    end
    return false
end

entity.onPath = function(mob)
    for _, v in pairs(detectors) do
        if mob:getID() == v[1] then
            xi.path.patrol(mob, v[2])
        end
    end
end

entity.onMobRoam = function(mob)
    for _, v in pairs(detectors) do
        if mob:getID() == v[1] and not mob:isFollowingPath() then
            xi.path.pathToNearest(mob, v[2])
        end
    end
end

entity.onMobFight = function(mob, target)
    local caretaker = GetMobByID(mob:getID() + 1)
    local petCount = mob:getLocalVar("petCount")
    local sc = GetMobByID(ID.mob.STEAM_CLEANER)

    if mob:getLocalVar("summoning") == 0 then
        if petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not caretaker:isSpawned() and canDetectorSummonSC(mob) then
            if spawnSteamCleaner(mob) then
                return
            elseif mob:getLocalVar("iSpawnedSC") and not sc:isSpawned() then -- If this specific detector spawned SC - dont spawn caretakers until SC is dead
                spawnCaretaker(mob)
            end
        elseif petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not caretaker:isSpawned() then
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

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
    if canDetectorSummonSC(mob) then
        mob:setRespawnTime(1800)
    end
end

return entity
