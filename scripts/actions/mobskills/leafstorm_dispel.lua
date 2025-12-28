-----------------------------------
-- Leafstorm (Dispel Variant)
-- Description: Dispels all positive status effects (including food) Additional effect: Slow.
-- Type: Magical
-- Range : 15' AOE
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 2500, 0, 120)

    local count = target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

return mobskillObject
