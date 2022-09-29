local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/mixins")

g_mixins = g_mixins or {}

g_mixins.wtb_prime = function(prime)
    prime:addListener("TAKE_DAMAGE", "PRIME_TAKE_DAMAGE", function(mob, amount, attacker)
        if amount > mob:getHP() then
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

    prime:addListener("COMBAT_TICK", "PRIME_COMBAT_TICK", function(mob)
        local bf = mob:getBattlefield()

        if mob:getHPP() < 15 and bf:getLocalVar("abilityControl") == 0 then
            bf:setLocalVar("abilityControl", 1)
            for i = 2, 7 do
                prime = GetMobByID(ID.primes[i][bf:getArea()])

                if prime:isAlive() then
                    prime:useMobAbility(ID.primes[i][4])
                end
            end
        end
    end)
end

return g_mixins.wtb_prime
