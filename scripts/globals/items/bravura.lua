-----------------------------------
-- ID: 18294, 18295, 18642, 18656, 18670, 19751, 19844, 20835, 20836, 21756
-- Item: Bravura
-- Additional Effect: Impairs evasion
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, xi.magic.ele.ICE, 0) > 0.5 then
        target:delStatusEffect(xi.effect.EVASION_BOOST)
        target:addStatusEffect(xi.effect.EVASION_DOWN, 15, 0, 60)
        return xi.subEffect.EVASION_DOWN, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.EVASION_DOWN
    end

    return 0, 0, 0
end

return item_object
