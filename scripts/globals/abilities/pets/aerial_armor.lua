-----------------------------------
-- Aerial Armor
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    target:delStatusEffect(tpz.effect.BLINK)
    target:addStatusEffect(tpz.effect.BLINK, 3, 0, 900)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    return tpz.effect.BLINK
end

return ability_object
