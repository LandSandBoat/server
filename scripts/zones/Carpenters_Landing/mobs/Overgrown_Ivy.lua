-----------------------------------
-- Area: Carpenters_Landing
--  Mob: Overgrown Ivy
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 15 then
        mob:setMod(xi.mod.REGAIN, 200)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getHPP() <= 15 then
        return 319
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
