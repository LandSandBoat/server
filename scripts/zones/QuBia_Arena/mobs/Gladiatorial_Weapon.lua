-----------------------------------
-- Area: Qu'Bia Arena
-- Mob: Gladiatorial Weapon
-- BCNM: Die by the Sword
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UDMGMAGIC, -10000)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(math.random(1,3))
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() ~= 307 then
        mob:useMobAbility(307)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
