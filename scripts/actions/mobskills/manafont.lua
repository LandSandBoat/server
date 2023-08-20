-----------------------------------
-- Manafont
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MANAFONT, 1, 0, 60)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.MANAFONT
end

return mobskillObject
