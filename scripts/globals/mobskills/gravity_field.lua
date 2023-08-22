-----------------------------------
-- Gravity Field
-- Entangles all targets in an area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.HASTE) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 4500, 0, math.random(240, 420)))
    end

    return xi.effect.SLOW
end

return mobskillObject
