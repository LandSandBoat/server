-----------------------------------
-- Dream Shroud
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
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

return abilityObject
