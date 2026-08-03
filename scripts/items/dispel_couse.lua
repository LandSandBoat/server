-----------------------------------
-- ID: 18095
-- Item: Dispel Couse
-- Item Effect: Dispels one beneficial effect from the target
-- Bypasses Magical Immunity - https://www.youtube.com/watch?v=CuTyCwzQqtY
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local dispelledEffect = target:dispelStatusEffect()

    if dispelledEffect == xi.effect.NONE then
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT)
        return 0
    end

    action:messageID(target:getID(), xi.msg.basic.ITEM_EFFECT_DISAPPEARS)
    return dispelledEffect
end

return itemObject
