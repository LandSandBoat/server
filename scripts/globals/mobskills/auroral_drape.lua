---------------------------------------------
-- Auroral Drape
--
-- Description: Silence and Blind Area of Effect (10.0')
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local silenced = false
    local blinded = false

    silenced = MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 60)

    blinded = MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 60, 0, 60)

    skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)

    -- display silenced first, else blind
    if (silenced == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.SILENCE
    elseif (blinded == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.BLINDNESS
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    return typeEffect
end
