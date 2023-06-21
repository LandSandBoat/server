-----------------------------------
-- Ability: Apogee
-- Increases the MP Cost of the Next Blood Pact but makes its recast timer 0
-- Obtained: Summoner Level 70
-- Recast Time: 5 Minutes
-- Duration: 1 Blood Pact or 60 seconds, whichever occurs first.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.APOGEE) then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.APOGEE, 1, 0, 60)

    return xi.effect.APOGEE
end

return abilityObject
