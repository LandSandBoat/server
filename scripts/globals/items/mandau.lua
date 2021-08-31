-----------------------------------
-- ID: 18270, 18271, 18638, 18652, 18666, 19747, 19840, 20555, 20556, 20583
-- Item: Mandau
-- Additional Effect: Poison
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0) > 0.5 then
        target:addStatusEffect(xi.effect.POISON, 10, 3, 30) -- Power and Duration needs verified.
        return xi.subEffect.POISON, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.POISON
    end

    return 0, 0, 0
end

return item_object
