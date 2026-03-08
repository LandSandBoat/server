-----------------------------------
-- Super Buff
-- Raises physical attack, defense, magic attack and magic evasion
-- Used by Nidhogg at will
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    target:addStatusEffect(xi.effect.SUPER_BUFF, { power = 25, duration = 30, origin = mob, icon = 0 })
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
