-----------------------------------------
-- ID: 5330
-- Item: Mithra Snare
-- Item Effect: Prevents 2hr use
-----------------------------------------
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = 0
    local mobPools = { 379, 1915, 1994 }

    if target:checkDistance(player) > 10 then
        return xi.msg.basic.TOO_FAR_AWAY
    end

    for i in pairs(mobPools) do
        if target:getPool() == mobPools[i] then
            result = 1
        end
    end

    if result == 1 then
        return 0
    else
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.MEDICINE, 1, 0, 300)
end

return itemObject
