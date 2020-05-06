---------------------------------------------
-- Entice
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    if mob:hasStatusEffect(tpz.effect.SOUL_VOICE) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = MobStatusEffectMove(mob, target, typeEffect, power, 1, 30)
    if msg == tpz.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end
    skill:setMsg(msg)

    return typeEffect
end
