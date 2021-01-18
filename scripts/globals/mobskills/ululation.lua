---------------------------------------------
-- Ululation
-- Paralyzes all enemies in an area of effect.
--
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, math.random(18, 22), 0, 120))

    return typeEffect
end

return mobskill_object
