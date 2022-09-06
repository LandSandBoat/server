-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Carbuncle Prime
-- Quest: Waking the Beast
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

-- mob:addMobMod(xi.mobMod.NO_DROPS, 1)

-- This table is aligned to the appropriate avatar in IDs
local avatars =
{
    "null",
    "ifrit",
    "shiva",
    "titan",
    "ramuh",
    "garuda",
    "leviathan",
}

local spawnPrime = function(mob, target)
    local bf = mob:getBattlefield()
    local phase = bf:getLocalVar("phase")
    local pos = mob:getPos()

    for i = 1, phase do
        local control = true

        -- Assure the same avatar isn't summoned more than once
        while control do
            local random = math.random(2,7)

            if bf:getLocalVar(avatars[random]) == 0 then
                bf:setLocalVar(avatars[random], 1)
                prime = ID.primes[random][bf:getArea()]

                SpawnMob(prime):updateEnmity(target)
                GetMobByID(prime):setPos(pos.x + math.random(-3,3), pos.y, pos.z + math.random(-3, 3), pos.rot)
                control = false
            end
        end
    end

    bf:setLocalVar("carbuncleHP", mob:getHP())
    mob:setHP(0)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)

    mob:timer(1, function(mobArg)
        local bf = mobArg:getBattlefield()

        mobArg:setHP(bf:getLocalVar("carbuncleHP"))
        bf:setLocalVar("abilityControl", 0)
        bf:setLocalVar("primesDead", 0)
    end)
end

entity.onMobFight = function(mob, target)
    local hp = mob:getHPP()
    local bf = mob:getBattlefield()
    local phase = bf:getLocalVar("phase")

    if hp <= 75 and bf:getLocalVar("hpControl1") == 0 then
        bf:setLocalVar("hpControl1", 1)
        spawnPrime(mob, target)
    elseif hp <= 50 and bf:getLocalVar("hpControl2") == 0 then
        bf:setLocalVar("hpControl2", 1)
        spawnPrime(mob, target)
    elseif hp <= 25 and bf:getLocalVar("hpControl3") == 0 then
        bf:setLocalVar("hpControl3", 1)
        spawnPrime(mob, target)
    end

    if hp < 10 and bf:getLocalVar("2hrControl") == 0 then
        bf:setLocalVar("2hrControl", 1)
        for i = 0, 4 do
            local carby = GetMobByID(ID.primes[1][bf:getArea()]+i)

            if carby:isAlive() then
                carby:useMobAbility(912)
            end
        end
    end

    -- Turn on drops if last carby alive
    if phase == 4 and mob:getLocalVar("dropControl") == 0 then
        local carbyCount = 0

        for i = 0, 4 do
            local carby = GetMobByID(ID.primes[1][bf:getArea()]+i)

            if carby:isAlive() then
                carbyCount = carbyCount + 1
            end
        end

        if carbyCount == 1 then
            mob:setMobMod(xi.mobMod.NO_DROPS, 0)
            mob:setLocalVar("dropControl", 1)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
