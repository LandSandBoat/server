-----------------------------------
-- ID: 18318, 18319, 18646, 18660, 18674, 19755, 19848, 21015, 21016, 21954
-- Item: Amanomurakumo
-- Additional Effect: 10% Attack Down
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0) > 0.5 then
        target:delStatusEffect(xi.effect.ATTACK_BOOST)
        target:addStatusEffect(xi.effect.ATTACK_DOWN, 10, 0, 60) -- Power needs verification/correction
        return xi.subEffect.ATTACK_DOWN, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.ATTACK_DOWN
    end

    return 0, 0, 0
end

return item_object
