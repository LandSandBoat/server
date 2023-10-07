-----------------------------------
-- Dream Shroud
-- Buffs MATK and MDEF
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) or
        mob:hasStatusEffect(xi.effect.MAGIC_DEF_BOOST)
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 180
    local hour = VanadielHour()
    local buffvalue = 0
    buffvalue = math.abs(12 - hour) + 1
    target:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    target:delStatusEffect(xi.effect.MAGIC_DEF_BOOST)
    target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, buffvalue, 0, duration)
    target:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, 14 - buffvalue, 0, duration)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
