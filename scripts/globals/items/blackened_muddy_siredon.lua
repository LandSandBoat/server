-----------------------------------
-- ID: 5266
-- Item: Blackened Muddy Siredone
-- Item Effect: Temporarily removes Shikaree TP moves
-----------------------------------
local ID = require('scripts/zones/Boneyard_Gully/IDs')
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = xi.msg.basic.ITEM_UNABLE_TO_USE

    if
        target:getID() >= ID.mob.SHIKAREE_HEADWIND_START and
        target:getID() <= ID.mob.SHIKAREE_HEADWIND_END
    then
        result = 0
    elseif target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    target:addStatusEffect(xi.effect.AMNESIA, 1, 0, 60)
end

return itemObject
