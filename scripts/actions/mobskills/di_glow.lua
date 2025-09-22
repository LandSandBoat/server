-----------------------------------
--  Glow before Wrath of Zeus or Lightning Spear
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0 -- cosmetic move only
end

return mobskillObject
