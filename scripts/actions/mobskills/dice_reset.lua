-----------------------------------
-- Goblin Dice
-- Description: Reset recasts on abilities
-- Type: Physical (Blunt)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    target:resetRecasts()

    skill:setMsg(xi.msg.basic.ABILITIES_RECHARGED)

    return 1
end

return mobskillObject
