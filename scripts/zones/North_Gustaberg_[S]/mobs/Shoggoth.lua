-----------------------------------
--  Mob: Shoggoth
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    xi.voidwalker.onMobInitialize(mob)
end

entity.onMobSpawn = function(mob)
    xi.voidwalker.onMobSpawn(mob)
end

entity.onMobFight = function(mob, target)
    xi.voidwalker.onMobFight(mob, target)
end

entity.onMobDisengage = function(mob)
    xi.voidwalker.onMobDisengage(mob)
end

entity.onMobDespawn = function(mob)
    xi.voidwalker.onMobDespawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.voidwalker.onMobDeath(mob, player, optParams, xi.keyItem.ORANGE_ABYSSITE)
    xi.hunts.checkHunt(mob, player, 548)
    xi.magian.onMobDeath(mob, player, optParams, set{ 74, 288, 436 })
end

return entity
