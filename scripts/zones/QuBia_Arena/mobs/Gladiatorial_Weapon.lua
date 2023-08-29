-----------------------------------
-- Area: Qu'Bia Arena
-- Mob: Gladiatorial Weapon
-- BCNM: Die by the Sword
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UDMGMAGIC, -10000)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(math.random(1,3))
    mob:useMobAbility(307)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() ~= 307 then
        mob:queue(1000, function(mobArg)
            mob:useMobAbility(307)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
