---------------------------------------------
-- Abominable Belch
-- Description: inflicts all targets in an area of effect with silence, paralysis and plague.
-- Radial
-- Ignores Shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.PLAGUE, 1, 3, 120))
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 120))
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 25, 0, 120))

    return tpz.effect.PLAGUE
end
