---------------------------------------------
-- Deafening Tantara
--
-- Description: Inflicts silence in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10'
-- Notes: Doesn't use this if its horn is broken.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() == 1 and mob:getFamily() == 165) then -- Imps without horn
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))
    return typeEffect
end
