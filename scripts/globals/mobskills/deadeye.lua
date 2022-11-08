-----------------------------------
-- Deadeye
-- Family: Qiqurn
-- Description: Lowers the defense and magical defense of enemies within range.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-- Notes: Used only by certain Notorious Monsters. Strong xi.effect.
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
    local defDown = false
    local mDefDown = false
    local typeEffect = nil

    defDown = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 50, 0, 120)
    mDefDown = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 50, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display defense down first, else magic defense down
    if defDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.DEFENSE_DOWN
    elseif mDefDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.MAGIC_DEF_DOWN
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskillObject
