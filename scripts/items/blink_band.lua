-----------------------------------
-- ID: 15170
-- Item: Blink Band
-- Item Effect: 3 shadows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if
        target:hasStatusEffect(xi.effect.COPY_IMAGE) or
        target:hasStatusEffect(xi.effect.THIRD_EYE)
    then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.BLINK, { power = 3, duration = 300, origin = user })
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.BLINK)
    end
end

return itemObject
