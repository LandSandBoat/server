-----------------------------------
-- ID: 18312, 18313, 18645, 18659, 18673, 19754, 19847, 20970, 20971, 21906
-- Item: Kikoku
-- Additional Effect: Paralysis
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) > 0.5 then
        target:addStatusEffect(tpz.effect.PARALYSIS, 17, 0, 30) -- Power needs verification/adjustment.
        return tpz.subEffect.PARALYSIS, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.PARALYSIS
    end

    return 0, 0, 0
end

return item_object
