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
    local typeEffect1 = xi.effect.PROTECT
    local typeEffect2 = xi.effect.SHELL
    local power1      = 50
    local power2      = 2000
    local duration    = 300

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect1, power1, 0, duration))
    xi.mobskills.mobBuffMove(mob, typeEffect2, power2, 0, duration)

    return typeEffect1
end

return mobskillObject
