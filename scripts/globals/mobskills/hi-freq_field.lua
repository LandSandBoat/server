-----------------------------------
-- Hi-Freq Field
-- Lowers the evasion of enemies in a fan-shaped area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local evasion = target:getStat(xi.mod.EVA) * 0.25

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, evasion, 0, 180))

    return xi.effect.EVASION_DOWN
end

return mobskillObject
