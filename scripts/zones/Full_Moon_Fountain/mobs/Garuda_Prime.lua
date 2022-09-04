-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Garuda Prime
-- Quest: Waking the Beast
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
    if isKiller then
        local bf = mob:getBattlefield()
        local phase = bf:getLocalVar("phase")

        bf:setLocalVar("primesDead", bf:getLocalVar9("primesDead") + 1)

        if bf:getLocalVar("primesDead") >= phase then
            -- Respawn Carbuncle
            SpawnMob(ID.primes[1][bf:getArea()])
        elseif phase == 3 then
            for i = 1, 4 do
                SpawnMob(ID.primes[1][bf:getArea()] + i)
            end
        end
    end
end

return entity
