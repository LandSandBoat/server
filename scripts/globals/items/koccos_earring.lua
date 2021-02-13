-----------------------------------
-- ID: 15998
-- Kocco's Earring
-- This earring functions in the same way as the spell Reraise II.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = 7200
    target:delStatusEffect(tpz.effect.RERAISE)
    target:addStatusEffect(tpz.effect.RERAISE, 2, 0, duration)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.RERAISE)
end

return item_object
