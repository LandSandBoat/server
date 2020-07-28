---------------------------------------------
-- Death Trap
--
-- Description: Attempts to stun or poison any players in a large trap. Resets hate.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 30' radial
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
    local typeEffect = tpz.effect.POISON
    local duration = 60
    local power = mob:getMainLvl() / 3

    if (math.random() <= 0.5) then
        -- stun
        typeEffect = tpz.effect.STUN
        duration = 10
        power = 1
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    mob:resetEnmity(target)
    return typeEffect
end
