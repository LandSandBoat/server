-----------------------------------
-- Boiling Blood
-- Description: Boiling Blood
-- Foe gains Haste +25% and Berserk +50%
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 2500, 0, 180)
    xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, 50, 0, 180)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
