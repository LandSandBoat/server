-----------------------------------
-- Ability: Relinquish
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getMainJob() ~= xi.job.MON then
        return xi.msg.basic.UNABLE_TO_USE_JA2, 0
    end

    -- TODO: Block if being attacked
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.monstrosity.relinquishOnAbility(player)
end

return abilityObject
