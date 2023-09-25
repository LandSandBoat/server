-----------------------------------
-- Ability: Fan Dance
-- Reduces physical damage taken and increases enmity but renders Samba unusable. Physical damage reduction gradually decreases with each hit taken.
-- Obtained: Dancer Level 75 Merit Group 2
-- Recast Time: 3 minutes
-- Duration: 5 minutes
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.FAN_DANCE, 9000, 0, 300)
end

return abilityObject
