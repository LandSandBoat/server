-----------------------------------
-- ID: 5386
-- Item: bottle_of_fighters_drink
-- Item Effect: Accuracy +100
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.ACCURACY_BOOST
    local power     = 100 --Accuracy
    local duration  =  90

    xi.itemUtils.addItemEffect(target, effect, power, duration)
end

return itemObject
