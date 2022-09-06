-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Shiva Prime
-- Quest: Waking the Beast
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

-- This table is aligned to the appropriate avatar in IDs
local meritSkill =
{
    0,   -- Unused
    848, -- Inferno        (Ifrit)
    884, -- Diamond Dust   (Shiva)
    875, -- Aerial Blast   (Garuda)
    857, -- Earthen Fury   (Titan)
    893, -- Judgement Bolt (Ramuh)
    866, -- Tidal Wave     (Leviathan)
}

entity.onMobSpawn = function(mob)
    mob:addListener("TAKE_DAMAGE", "SHIVA_TAKE_DAMAGE", function(mobArg, amount, attacker)
        if amount > mobArg:getHP() then
            local bf = mob:getBattlefield()
            local phase = bf:getLocalVar("phase")
            local bfNum = bf:getArea()

            bf:setLocalVar("primesDead", bf:getLocalVar("primesDead") + 1)

            if bf:getLocalVar("primesDead") >= phase then
                -- Respawn Carbuncle
                SpawnMob(ID.primes[1][bfNum]):updateEnmity(attacker)
                bf:setLocalVar("phase", bf:getLocalVar("phase") + 1)

                if bf:getLocalVar("phase") >= 4 then
                    for i = 1, 4 do
                        SpawnMob(ID.primes[1][bfNum] + i):updateEnmity(attacker)
                    end
                end
            end
        end
    end)
end

entity.onMobFight = function(mob, target)
    local bf = mob:getBattlefield()

    if mob:getHPP() < 15 and bf:getLocalVar("abilityControl") == 0 then
        bf:setLocalVar("abilityControl", 1)
        for i = 2, 7 do
            prime = GetMobByID(ID.primes[i][mob:getBattlefield():getArea()])

            if prime:isAlive() then
                prime:useMobAbility(meritSkill[i])
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
