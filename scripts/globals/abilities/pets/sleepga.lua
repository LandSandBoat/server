-----------------------------------------
-- Sleepga
-----------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local duration = 60
    local resm = applyPlayerResistance(pet, -1, target, pet:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), tpz.skill.ELEMENTAL_MAGIC, 5)
    if (resm < 0.5) then
        skill:setMsg(tpz.msg.basic.JA_MISS_2) -- resist message
        return tpz.effect.SLEEP_I
    end
    duration = duration * resm
    if (target:hasImmunity(1) or hasSleepEffects(target)) then
        --No effect
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB)

        target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, duration)
    end

    return tpz.effect.SLEEP_I
end
