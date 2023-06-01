-----------------------------------
-- ID: 13171
-- Reraise Gorget
--  This necklace functions in the same way as the spell Reraise II.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local duration = 7200
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, 2, 0, duration)
    target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.RERAISE)
end

return itemObject
