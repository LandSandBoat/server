-----------------------------------
-- ID: 18288, 18289, 18641, 18655, 18669, 19750, 19843, 20790, 20791, 21750
-- Item: Guttler
-- Additional Effect: Choke
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, xi.magic.ele.ICE, 0) > 0.5 then
        target:addStatusEffect(xi.effect.CHOKE, 17, 0, 60)
        return xi.subEffect.CHOKE, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.CHOKE
    end

    return 0, 0, 0
end

return item_object
