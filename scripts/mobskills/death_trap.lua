-----------------------------------
-- Death Trap
--
-- Description: Attempts to stun or poison any players in a large trap. Resets hate.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 30' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON
    local duration = 60
    local power = mob:getMainLvl() / 3

    if math.random() <= 0.5 then
        -- stun
        typeEffect = xi.effect.STUN
        duration = 10
        power = 1
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    mob:resetEnmity(target)
    return typeEffect
end

return mobskillObject
