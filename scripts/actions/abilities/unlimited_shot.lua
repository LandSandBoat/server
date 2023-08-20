-----------------------------------
-- Ability: Unlimited Shot
-- Allows you to perform your next ranged attack without using ammunition.
-- Obtained: Ranger Level 51
-- Recast Time: 3:00
-- Duration: 1:00 or One Successful Ranged Attack.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.UNLIMITED_SHOT, 1, 0, 60)
end

return abilityObject
