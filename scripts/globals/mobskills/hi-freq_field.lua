-----------------------------------
-- Hi-Freq Field
-- Lowers the evasion of enemies in a fan-shaped area of effect.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.EVASION_DOWN
    local evasion   = target:getStat(xi.mod.EVA) * 0.25

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, evasion, 0, 120))

    return typeEffect
end

return mobskillObject
