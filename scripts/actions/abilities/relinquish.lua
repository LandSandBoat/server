-----------------------------------
-- Ability: Relinquish
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- TODO: Block if being attacked
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.monstrosity.relinquishOnAbility(player, target, ability)
end

return abilityObject
