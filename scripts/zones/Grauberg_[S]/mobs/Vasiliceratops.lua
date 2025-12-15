-----------------------------------
-- Area: Grauberg [S]
--   NM: Vasiliceratops
-- https://www.bg-wiki.com/ffxi/Vasiliceratops
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  276.142, y =  25.332, z = -453.541 }
}

entity.phList =
{
    [ID.mob.VASILICERATOPS - 3] = ID.mob.VASILICERATOPS,
    [ID.mob.VASILICERATOPS - 67] = ID.mob.VASILICERATOPS,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    mob:setBaseSpeed(100)
end

entity.onMobMobskillChoose = function(mob, target)
    return 2099 -- Batterhorn is only TP move
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 505)
end

return entity
