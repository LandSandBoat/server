-----------------------------------
-- Azure Lore
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.AZURE_LORE, 1, 0, 45)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.AZURE_LORE
end

return mobskillObject
