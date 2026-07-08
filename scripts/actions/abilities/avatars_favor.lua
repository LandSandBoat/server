-----------------------------------
-- Avatars Favor - Ability
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.AVATARS_FAVOR, { power = 1, duration = 7200, origin = player, tick = 10 })
end

return abilityObject
