-----------------------------------
-- Salaheem Spirit
-- Description: Provides a bonus to base attributes for party members in area of effect. Duration varies by TP
-- Only available to Abquhbah Trust
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor(mob:getMainLvl() / 4)
    local tick = 10
    local duration = 50
    local bonusTime = math.floor(mob:getTP() / 10) + 5

    target:delStatusEffect(xi.effect.STR_BOOST)
    target:delStatusEffect(xi.effect.DEX_BOOST)
    target:delStatusEffect(xi.effect.VIT_BOOST)
    target:delStatusEffect(xi.effect.AGI_BOOST)
    target:delStatusEffect(xi.effect.INT_BOOST)
    target:delStatusEffect(xi.effect.MND_BOOST)
    target:delStatusEffect(xi.effect.CHR_BOOST)

    target:addStatusEffect(xi.effect.STR_BOOST, power, tick, duration + bonusTime)
    target:addStatusEffect(xi.effect.DEX_BOOST, power, tick, duration + bonusTime)
    target:addStatusEffect(xi.effect.VIT_BOOST, power, tick, duration + bonusTime)
    target:addStatusEffect(xi.effect.AGI_BOOST, power, tick, duration + bonusTime)
    target:addStatusEffect(xi.effect.INT_BOOST, power, tick, duration + bonusTime)
    target:addStatusEffect(xi.effect.MND_BOOST, power, tick, duration + bonusTime)
    target:addStatusEffect(xi.effect.CHR_BOOST, power, tick, duration + bonusTime)

    skill:setMsg(xi.msg.basic.STATUS_BOOST_2)

    return 0
end

return mobskillObject
