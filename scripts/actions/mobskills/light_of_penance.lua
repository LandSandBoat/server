-----------------------------------
-- Light of Penance
-- Description: Reduces an enemy's TP. Additional effect: Blindness and "Bind".
-- Type: Magical (Light)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local tpReduced = 0
    local duration  = 60
    target:setTP(tpReduced)

    xi.mobskills.mobGazeMove(mob, target, xi.effect.BLINDNESS, 100, 0, duration)

    xi.mobskills.mobGazeMove(mob, target, xi.effect.BIND, 1, 0, duration)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end

return mobskillObject
