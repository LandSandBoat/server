---------------------------------------------
-- Depuration
-- Family: Aern
-- Type: Healing
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Erases all negative effects on the mob.
-- Aerns will generally not attempt to use this ability if no erasable effects exist on them.
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

    return 0
end
