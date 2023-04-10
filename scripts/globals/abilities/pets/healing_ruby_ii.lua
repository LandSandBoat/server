-----------------------------------
-- Healing Ruby II
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local base = 28 + pet:getMainLvl() * 4

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    target:addHP(base)
    return base
end

return abilityObject
