-----------------------------------
-- Crystaline Cocoon
-- Family: Aern
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 50, 0, 300))
    xi.mobskills.mobBuffMove(mob, xi.effect.SHELL, 2000, 0, 300)

    return xi.effect.PROTECT
end

return mobskillObject
