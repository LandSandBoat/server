-----------------------------------
-- Max Potion - Restores 500 HP.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(target, 500)
end

return mobskillObject
