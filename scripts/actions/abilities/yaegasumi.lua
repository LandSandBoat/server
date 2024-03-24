-----------------------------------
-- Ability: Yaegasumi
-- Description: Allows you to evade special attacks. Grants a weapon skill damage bonus that varies with the number of special attacks evaded.
-- Obtained: SAM Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:45
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.YAEGASUMI, 12, 0, 45)
end

return abilityObject
