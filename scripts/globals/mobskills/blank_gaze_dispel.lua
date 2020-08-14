---------------------------------------------
-- Blank Gaze
-- Gaze dispel
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
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
    local effect = 0
    if (target:isFacing(mob)) then

        effect = target:dispelStatusEffect()

        if (effect == tpz.effect.NONE) then
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
        else
            skill:setMsg(tpz.msg.basic.SKILL_ERASE)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return effect
end
