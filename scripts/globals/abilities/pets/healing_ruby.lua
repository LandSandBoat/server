-----------------------------------
-- Healing Ruby
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local base = 14 + target:getMainLvl() + skill:getTP() / 120
    if pet:getMainLvl() > 30 then
        base = 44 + 3 * (pet:getMainLvl() - 30) + skill:getTP() / 120 * (pet:getMainLvl() * 0.075 - 1)
    end

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    target:addHP(base)

    pet:updateEnmityFromCure(pet, base)

    return base
end

return abilityObject
