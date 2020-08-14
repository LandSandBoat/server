---------------------------------------------
-- Sand Trap
--
-- Description: AOE Petrify and resets hate.
-- Type: Physical
-- Utsusemi/Blink absorb: Ignore
-- Range: 15' radial
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PETRIFICATION

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(12, 20)))

    -- reset everyones enmity
    mob:resetEnmity(target)

    return typeEffect
end
