-----------------------------------
-- Ability: Random Deal
-- Has the possibility of resetting the reuse time of a job ability for each party member within area of effect.
-- Obtained: Corsair Level 50
-- Recast Time: 0:20:00
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    if not caster:doRandomDeal(target) then
        ability:setMsg(xi.msg.basic.EVADES)
    end
end

return abilityObject
