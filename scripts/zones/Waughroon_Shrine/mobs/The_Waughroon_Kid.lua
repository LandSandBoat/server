-----------------------------------
-- Area: Waughroon Shrine
--  Mob: The Waughroon Kid
-- BCNM: The Final Bout
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)
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

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT, { chance = 50, })
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 40 and mob:getLocalVar("counterstance") == 0 then
        mob:useMobAbility(1331)
        mob:setLocalVar("counterstance", 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
