-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Carbuncle Prime
-- Quest: Waking the Beast
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local spawnPrime = function(mob)
    local bf = mob:getBattlefield()
    local phase = bf:getLocalVar("phase")
    local bfNum = bf:getArea()

    for i = 1, phase do
        SpawnMob(ID.primes[math.random(1,6)][bfNum])
    end

    bf:setLocalVar("carbuncleHP", mob:getHP())
    mob:setHP(0)
end

entity.onMobSpawn = function(mob)
    local bf = mob:getBattlefield()

    mob:setHP(bf:getLocalVar("carbuncleHP"))
    bf:setLocalVar("primesDead", 0)
end

entity.onMobFight = function(mob, target)
    local hp = mob:getHPP()
    bf = mob:getBattlefield()

    if hp < 75 and bf:getLocalVar("hpControl1") == 0 then
        bf:setLocalVar("hpControl1", 1)
        spawnPrime(mob)
    elseif hp < 50 and bf:getLocalVar("hpControl2") == 0 then
        bf:setLocalVar("hpControl2", 1)
        spawnPrime(mob)
    elseif hp < 25 and bf:getLocalVar("hpControl3") == 0 then
        bf:setLocalVar("hpControl3", 1)
        mob:setHP(0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:getBattlefield():setLocalvar("phase", mob:getBattlefield():setLocalvar("phase") + 1)
end

return entity
