-----------------------------------
-- Ability: Crooked Cards
-- Description: Increases the effects of the next phantom roll.
-- Obtained: COR Level 95
-- Recast Time: 0:10:00
-- Duration: 0:01:00(or the next roll used)
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.CROOKED_CARDS, { power = 20, duration = 60, origin = player })
end

return abilityObject
