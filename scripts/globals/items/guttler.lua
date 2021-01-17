-----------------------------------------
-- ID: 18288, 18289, 18641, 18655, 18669, 19750, 19843, 20790, 20791, 21750
-- Item: Guttler
-- Additional Effect: Choke
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) > 0.5 then
        target:addStatusEffect(tpz.effect.CHOKE, 17, 0, 60)
        return tpz.subEffect.CHOKE, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.CHOKE
    end

    return 0, 0, 0
end

return item_object
