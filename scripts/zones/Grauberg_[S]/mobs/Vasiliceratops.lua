-----------------------------------
-- Area: Grauberg [S]
--   NM: Vasiliceratops
-- https://www.bg-wiki.com/ffxi/Vasiliceratops
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    mob:setSpeed(100)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    return 2099 -- Batterhorn is only TP move
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 505)
end

return entity
