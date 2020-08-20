---------------------------------------------
-- Rapid Molt
-- Family: Hpemde
-- Description: Erases all negative effects on the mob, and adds a Regen tpz.effect.
-- Can be dispelled: Yes (regen)
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Hpemde will generally not attempt to use this ability if no erasable effects exist on them.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)

    local dispel = target:eraseStatusEffect()

    if (dispel ~= tpz.effect.NONE) then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)

    mob:eraseAllStatusEffect()
    local typeEffect = tpz.effect.REGEN

    skill:setMsg(MobBuffMove(mob, typeEffect, 10, 3, 180))
    return typeEffect
end
