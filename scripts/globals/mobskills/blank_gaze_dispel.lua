-----------------------------------
-- Blank Gaze
-- Gaze dispel
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effect = 0
    if target:isFacing(mob) then

        effect = target:dispelStatusEffect()

        if effect == xi.effect.NONE then
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
        else
            skill:setMsg(xi.msg.basic.SKILL_ERASE)
        end
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return effect
end

return mobskillObject
