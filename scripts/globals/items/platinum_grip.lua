-----------------------------------
-- ID: 19019
-- Item: Platinum Grip
-- Additional Effect: Stun
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 5

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.LIGHTNING, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(xi.effect.STUN, 1, 0, 3)
        return xi.subEffect.STUN, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.STUN
    end
end

return item_object
