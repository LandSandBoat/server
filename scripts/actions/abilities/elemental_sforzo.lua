-----------------------------------
-- Ability: Elemental Sforzo
-- Grants immunity to all magic attacks.
-- Obtained: Rune Fencer Level 1
-- Recast Time: 1:00:00
-- Duration: 00:00:30
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.ELEMENTAL_SFORZO, 1, 0, 30)

    return xi.effect.ELEMENTAL_SFORZO
end

return abilityObject
