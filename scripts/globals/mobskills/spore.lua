-----------------------------------
-- Spore
-- Emits a cloud of spores that inflict paralysis.
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
-- Duration: 9:00
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
    local typeEffect = xi.effect.PARALYSIS
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 25, 0, 120))
    return typeEffect
end

return mobskillObject
