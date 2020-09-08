---------------------------------------------
-- Spring Water
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local base = 47 + pet:getMainLvl()*3
    local tp = skill:getTP()
    if tp < 1000 then
        tp = 1000
    end
    base = base * tp / 1000

    if (target:getHP()+base > target:getMaxHP()) then
        base = target:getMaxHP() - target:getHP() --cap it
    end
    target:delStatusEffect(tpz.effect.BLINDNESS)
    target:delStatusEffect(tpz.effect.POISON)
    target:delStatusEffect(tpz.effect.PARALYSIS)
    target:delStatusEffect(tpz.effect.DISEASE)
    target:delStatusEffect(tpz.effect.PETRIFICATION)
        target:wakeUp()
    target:delStatusEffect(tpz.effect.SILENCE)
    if math.random() > 0.5 then
        target:delStatusEffect(tpz.effect.SLOW)
    end
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    target:addHP(base)
    return base
end
