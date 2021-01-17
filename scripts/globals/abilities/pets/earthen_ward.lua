---------------------------------------------
-- Earthen Ward
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    target:delStatusEffect(tpz.effect.STONESKIN)
    local amount = pet:getMainLvl()*2 + 50
    target:addStatusEffect(tpz.effect.STONESKIN, amount, 0, 900, 0, 0, 3)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    return tpz.effect.STONESKIN
end

return ability_object
