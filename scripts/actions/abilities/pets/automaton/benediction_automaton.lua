-----------------------------------
-- Benediction (Automaton)
-- TODO: Implement JP Bonuses
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    target:eraseAllStatusEffect()

    local maxHeal = target:getMaxHP() - target:getHP()

    target:addHP(maxHeal)
    target:wakeUp()

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return maxHeal
end

return abilityObject
