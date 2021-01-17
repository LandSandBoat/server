-----------------------------------------
-- ID: 18110
-- Item: Mezraq
-- Additional Effect: Impairs evasion
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(tpz.effect.EVASION_BOOST)
        target:addStatusEffect(tpz.effect.EVASION_DOWN, 25, 0, 30)
        return tpz.subEffect.EVASION_DOWN, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.EVASION_DOWN
    end
end

return item_object
