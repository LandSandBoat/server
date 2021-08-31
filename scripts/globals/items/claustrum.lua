-----------------------------------
-- ID: 18330, 18331, 18648, 18662, 18676, 19757, 19850, 21135, 21136, 22060
-- Item: Claustrum
-- Additional Effect: Dispel
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 15
    if math.random(100) <= chance then
        local effect = target:dispelStatusEffect()
        if effect ~= xi.effect.NONE then
            return xi.subEffect.DISPEL, xi.msg.basic.ADD_EFFECT_DISPEL, effect
        end
    end

    return 0, 0, 0
end

return item_object
