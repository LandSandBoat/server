-----------------------------------
-- ID: 5850
-- Item: bottle_of_swiftshot_drink
-- Item Effect: Double Shot +100
-----------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.MULTI_SHOTS
    local power     = 100 --Double Shot Rate
    local duration  =  60

    xi.itemUtils.addItemEffect(target, effect, power, duration)
end

return itemObject
