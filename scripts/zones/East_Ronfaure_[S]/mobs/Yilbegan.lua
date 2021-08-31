-----------------------------------
--  VNM: Yilbegan
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/voidwalker")
require("scripts/globals/hunts")
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

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.YILBEGAN_HIDEFLAYER)
    xi.voidwalker.onMobDeath(mob, player, isKiller, nil)
    xi.hunts.checkHunt(mob, player, 559)
end

return entity
