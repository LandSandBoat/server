-----------------------------------
-- Area: Abyssea - La Theine
--   NM: Piasa
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, isKiller)
	  player:addCurrency('cruor', 250)
	  player:PrintToPlayer("You obtain 250 Cruor!", 0xD)
    end

return entity
