-----------------------------------
-- Ability: Mikage
-- Grants a bonus to number of main weapon attacks that varies with the number of remaining Utsusemi Shadow Images.
-- Obtained: Ninja Level 96
-- Recast Time: 1:00:00
-- Duration: 45 seconds
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.MIKAGE, 0, 0, 45)
end

return abilityObject
