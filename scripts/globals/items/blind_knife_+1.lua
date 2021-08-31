-----------------------------------
-- ID: 16490
-- Item: Blind Knife +1
-- Additional Effect: Blindness
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 15

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.DARK, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(xi.effect.BLINDNESS, 10, 0, 30)
        return xi.subEffect.BLIND, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.BLINDNESS
    end
end

return item_object
