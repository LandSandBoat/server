-----------------------------------
-- Area: Lebros Cavern (Troll Fugitives)
--  Mob: Broken Troll Soldier
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
mixins = { require("scripts/mixins/weapon_break") }
require("scripts/globals/assault")
-----------------------------------
local entity = {}

local ability =
{
    [2] = 690,
    [4] = 691,
    [5] = 691,
    [7] = 693,
}

local newHP =
{
    0.25,
    0.35,
    0.45,
    0.55,
    0.65,
    0.75,
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob, target)
    xi.assault.adjustMobLevel(mob)
    local instance = mob:getInstance()
    local ID = mob:getID()

    if
        ID == instance:getLocalVar("troll1") or
        ID == instance:getLocalVar("troll2")
    then
        mob:setLocalVar("twoHR", math.random(40, 60))
    end

    mob:setHP(mob:getHP() * newHP[math.random(1, #newHP)])
    mob:setMobMod(xi.mobMod.NO_REST, 1)
end

entity.onMobEngage = function(mob)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("twoHR") ~= 0 then
        mob:setLocalVar("twoHR", 0)
        mob:useMobAbility(ability[mob:getMainJob()])
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        xi.assault.progressInstance(mob, 1)
    end
end

entity.onMobDespawn = function(mob, player, optParams)
end

return entity
