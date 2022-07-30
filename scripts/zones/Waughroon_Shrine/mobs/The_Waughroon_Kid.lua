-----------------------------------
-- Area: Waughroon Shrine
--  Mob: The Waughroon Kid
-- BCNM: The Final Bout
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setLocalVar("doubleBlow", 0)
    mob:setLocalVar("counterstance", 0)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 581 and mob:getLocalVar("doubleBlow") == 0 then
        mob:setLocalVar("doubleBlow", 1)
        mob:useMobAbility(581)

        mob:timer(5000, function(mobArg)
            mobArg:setLocalVar("doubleBlow", 0)
        end)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 40 and mob:getLocalVar("counterstance") == 0 then
        mob:useMobAbility(1331)
        mob:setLocalVar("counterstance", 1)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
