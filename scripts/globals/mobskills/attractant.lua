---------------------------------------------
-- Attractant
-- Family: Goobbue
-- Description: Charms all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: 15' yalm around Nant'ina
-- Notes: Only used by Nant'ina
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 30)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return typeEffect
end

return mobskillObject
