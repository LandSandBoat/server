-----------------------------------
-- ID: 16431
-- Item: Stun Claws
-- Additional Effect: Stun
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 5

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHTNING, 0) > 0.5 then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 3)
        return tpz.subEffect.STUN, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.STUN
    end

    return 0, 0, 0
end

return item_object
