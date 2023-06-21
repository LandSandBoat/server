-----------------------------------
-- ID: 15170
-- Item: Blink Band
-- Item Effect: 3 shadows
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if
        target:hasStatusEffect(xi.effect.COPY_IMAGE) or
        target:hasStatusEffect(xi.effect.THIRD_EYE)
    then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.BLINK, 3, 0, 300)
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.BLINK)
    end
end

return itemObject
