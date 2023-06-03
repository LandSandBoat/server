-----------------------------------
-- Winter Breeze
-- Description: AoE Dispel (Only removes one effect) and Stun
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local DISPEL = target:dispelStatusEffect()

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 2)

    if DISPEL == xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return DISPEL
end

return mobskillObject
