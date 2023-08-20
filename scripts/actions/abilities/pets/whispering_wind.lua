-----------------------------------
-- Whispering Wind
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local base = 16 + pet:getMainLvl() * 2.5

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    target:addHP(base)
    return base
end

return abilityObject
