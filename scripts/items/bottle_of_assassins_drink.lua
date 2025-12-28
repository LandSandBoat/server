-----------------------------------
-- ID: 5888
-- Item: bottle_of_assassins_drink
-- Item Effect: Magic Accuracy +25 (Unconfirmed)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.INTENSION
    local power     = 25 --MAcc
    local duration  = 90

    xi.itemUtils.addItemEffect(target, effect, power, duration)
end

return itemObject
