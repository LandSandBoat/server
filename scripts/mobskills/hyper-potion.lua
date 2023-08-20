-----------------------------------
-- Hyper Potion - Restores 250 HP.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(target, 250)
end

return mobskillObject
