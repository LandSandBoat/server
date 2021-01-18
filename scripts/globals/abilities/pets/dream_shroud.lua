-----------------------------------
-- Dream Shroud
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill, summoner)
    local bonusTime = utils.clamp(summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 180 + bonusTime
    local hour = VanadielHour()
    local buffvalue = 0
    buffvalue = math.abs(12 - hour) + 1
    target:delStatusEffect(tpz.effect.MAGIC_ATK_BOOST)
    target:delStatusEffect(tpz.effect.MAGIC_DEF_BOOST)
    target:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, buffvalue, 0, duration)
    target:addStatusEffect(tpz.effect.MAGIC_DEF_BOOST, 14 - buffvalue, 0, duration)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end

return ability_object
