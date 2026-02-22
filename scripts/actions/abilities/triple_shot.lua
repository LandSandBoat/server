-----------------------------------
-- Ability: Triple Shot
-- Description: Occasionally uses three units of ammunition to deal extra damage.
-- Obtained: COR Level 87
-- Recast Time: 00:05:00
-- Duration: 0:01:30
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.TRIPLE_SHOT, { power = 40, duration = 90, origin = player })

    return xi.effect.TRIPLE_SHOT
end

return abilityObject
