-----------------------------------
-- Aerial Armor
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    target:delStatusEffect(xi.effect.BLINK)
    target:addStatusEffect(xi.effect.BLINK, 3, 0, 900)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.BLINK
end

return ability_object
