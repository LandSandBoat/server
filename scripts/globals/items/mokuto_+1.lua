-----------------------------------
-- ID: 16925
-- Item: Mokuto +1
-- Additional Effect: Silence
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 15
    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.WIND, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(xi.effect.SILENCE, 10, 0, 30)
        return xi.subEffect.SILENCE, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.SILENCE
    end
end

return item_object
