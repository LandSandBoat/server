-----------------------------------------
-- ID: 5329
-- Item: Tarutaru Snare
-- Item Effect: Mob hits for only 1 or 2(crit) damage for 60 seconds
-----------------------------------------
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = 0
    local mobPools = { 379, 1915, 1994 }

    if player:checkDistance(target) > 10 then
        return xi.msg.basic.TOO_FAR_AWAY
    end

    for k, v in pairs(mobPools) do
        if target:getPool() == mobPools[k] then
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
    target:setLocalVar("taruSnare", 1)
end

return itemObject
