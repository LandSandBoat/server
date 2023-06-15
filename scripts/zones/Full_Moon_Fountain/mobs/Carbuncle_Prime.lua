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
            local random = math.random(2, 7)

            if bf:getLocalVar(avatars[random]) == 0 then
                bf:setLocalVar(avatars[random], 1)
                local prime = ID.primes[random][bf:getArea()]

                SpawnMob(prime):updateEnmity(target)
                GetMobByID(prime):setPos(pos.x + math.random(-3, 3), pos.y, pos.z + math.random(-3, 3), pos.rot)
                control = false
            end
        end
    end

    bf:setLocalVar("carbuncleHP", mob:getHP())
    mob:setHP(0)
    mob:timer(5000, function(mobArg)
        DespawnMob(mobArg:getID())
    end)
end

entity.onMobSpawn = function(mob)
    mob:timer(1000, function(mobArg)
        local bf = mobArg:getBattlefield()

        mobArg:setHP(bf:getLocalVar("carbuncleHP"))
        bf:setLocalVar("abilityControl", 0)
        bf:setLocalVar("primesDead", 0)
        bf:setLocalVar("phaseControl", 0)
    end)
end

entity.onMobFight = function(mob, target)
    local hp = mob:getHPP()
    local bf = mob:getBattlefield()

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
            local carby = GetMobByID(ID.primes[1][bf:getArea()] + i)

            if carby:isAlive() then
                carby:useMobAbility(919)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local bf = mob:getBattlefield()
    local flag = true

    for i = 0, 4 do
        local carby = GetMobByID(ID.primes[1][bf:getArea()] + i)

        if carby:isAlive() then
            flag = false
        end
    end

    -- Only complete the battlefield if the final carbuncle is killed in phase 4
    if
        bf:getLocalVar("phase") >= 4 and
        optParams.isKiller and
        flag
    then
        bf:setLocalVar("lootSpawned", 0)
    end
end

return entity
