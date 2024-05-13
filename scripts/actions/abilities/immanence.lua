-----------------------------------
-- Ability: Immanence
-- Makes it possible for your next elemental magic spell to be used in a skillchain, but not a magic burst.
-- Obtained: Scholar Level 87
-- Duration: 1 Black Magic Spell or 60 seconds, whichever occurs first.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.IMMANENCE) then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.IMMANENCE, 1, 0, 60)

    return xi.effect.IMMANENCE
end

return abilityObject
