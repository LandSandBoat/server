-----------------------------------
-- Dream Shroud
--
-- Description: Enhances Magic Attack and Magic Defense.
-- Type: Enhancing
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local hour = VanadielHour()
    local buffvalue = math.abs(12 - hour) + 1

    mob:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    mob:delStatusEffect(xi.effect.MAGIC_DEF_BOOST)

    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, buffvalue, 0, 180)
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 14 - buffvalue, 0, 180)

    skill:setMsg(xi.msg.basic.SKILL_RECEIVES_MAB_MDB)

    return xi.effect.MAGIC_ATK_BOOST
end

return mobskillObject
