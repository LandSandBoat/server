-----------------------------------------
-- ID: 15175
-- Item: Reviler's Helm
-- Item Effect: Provoke
-----------------------------------------
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = 0
    if target:checkDistance(player) > 18 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player, item)
    target:addEnmity(player, 0, 1800)
    target:updateClaim(player)
end

return itemObject
