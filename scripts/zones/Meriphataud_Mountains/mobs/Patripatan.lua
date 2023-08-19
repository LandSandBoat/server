-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Patripatan
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10) -- "Noted Double Attack"
    mob:addMod(xi.mod.REGAIN, 50) -- "fairly potent Regain effect"
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 269)
    xi.regime.checkRegime(player, mob, 63, 1, xi.regime.type.FIELDS)
end

return entity
