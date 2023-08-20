-----------------------------------
-- Light of Penance
-- Description: Reduces an enemy's TP. Additional effect: Blindness and "Bind".
-- Type: Magical (Light)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local tpReduced = 0
    target:setTP(tpReduced)

    xi.mobskills.mobGazeMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120)

    xi.mobskills.mobGazeMove(mob, target, xi.effect.BIND, 1, 0, 30)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end

return mobskillObject
