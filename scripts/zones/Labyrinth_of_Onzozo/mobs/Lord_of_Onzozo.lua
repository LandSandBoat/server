-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Lord of Onzozo
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.rage)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 774, 1, xi.regime.type.GROUNDS)
end

return entity
