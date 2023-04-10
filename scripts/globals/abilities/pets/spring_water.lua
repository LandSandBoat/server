-----------------------------------
-- Spring Water
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
    local base = 47 + pet:getMainLvl() * 3
    local tp   = pet:getTP()

    if tp < 1000 then
        tp = 1000
    end

    base = base * tp / 1000

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    target:delStatusEffect(xi.effect.BLINDNESS)
    target:delStatusEffect(xi.effect.POISON)
    target:delStatusEffect(xi.effect.PARALYSIS)
    target:delStatusEffect(xi.effect.DISEASE)
    target:delStatusEffect(xi.effect.PETRIFICATION)
    target:wakeUp()
    target:delStatusEffect(xi.effect.SILENCE)

    if math.random() > 0.5 then
        target:delStatusEffect(xi.effect.SLOW)
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    target:addHP(base)
    return base
end

return abilityObject
