-----------------------------------
-- ID: 16863
-- Item: Cruel Spear
-- Additional Effect: Impairs evasion
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.ICE, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(xi.effect.EVASION_BOOST)
        target:addStatusEffect(xi.effect.EVASION_DOWN, 12, 0, 60)
        return xi.subEffect.EVASION_DOWN, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.EVASION_DOWN
    end
end

return item_object
