-----------------------------------
-- Area: Ordelle's Caves
--   NM: Necroplasm
-- Involved in Eco Warrior (San d'Oria)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getCharVar('EcoStatus') == 1 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        player:setCharVar('EcoStatus', 2)
    end
end

return entity
