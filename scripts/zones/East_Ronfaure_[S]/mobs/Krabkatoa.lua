-----------------------------------
--  VNM: Krabkatoa
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/voidwalker")
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
    player:addTitle(xi.title.KRABKATOA_STEAMER)
    xi.voidwalker.onMobDeath(mob, player, isKiller, xi.keyItem.BLACK_ABYSSITE)
end

return entity
