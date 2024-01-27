-----------------------------------
-- ID: 5394
-- Item: bottle_of_gnostics_drink
-- Item Effect: Enmity -
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.PAX
    local power     = -10   -- Power Level unknown, using Animus Minueo Value as baseline.
    local duration  = 60

    xi.itemUtils.addItemEffect(target, effect, power, duration)
end

return itemObject
