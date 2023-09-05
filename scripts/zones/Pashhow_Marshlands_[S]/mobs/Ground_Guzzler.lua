-----------------------------------
--  Mob: Globster
-----------------------------------
require("scripts/globals/regimes")
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

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 16, 1, xi.regime.type.FIELDS)
    xi.voidwalker.onMobDeath(mob, player, optParams, xi.keyItem.COLORFUL_ABYSSITE)
end

return entity
