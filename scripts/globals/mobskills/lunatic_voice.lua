---------------------------------------------------
-- Lunatic Voice
---------------------------------------------
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")
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
    local typeEffect = tpz.effect.MUTE

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60))

    return typeEffect
end
