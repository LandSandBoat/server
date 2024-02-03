-----------------------------------
-- Sand Trap
-- Description: AOE Petrify and resets hate.
-- Type: Physical
-- Utsusemi/Blink absorb: Ignore
-- Range: 15' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, math.random(12, 20)))

    -- reset everyones enmity
    mob:resetEnmity(target)

    return xi.effect.PETRIFICATION
end

return mobskillObject
