-----------------------------------
-- Level 5 Petrify
-- Description: AOE Petrify and on multiples of 5.
-- Type: Physical
-- Utsusemi/Blink absorb: Ignore
-- Range: 15' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:getMainLvl() % 5 == 0 then
        local power = math.random(2, 30)

        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, power))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return xi.effect.PETRIFICATION
end

return mobskillObject
