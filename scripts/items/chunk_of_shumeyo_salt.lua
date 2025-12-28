-----------------------------------
-- ID: 5267
-- Item: Chunk Of Shu'Meyo Salt
-- Effect: Adds 20 seconds to the Snoll Tzar fight
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local msg     = 0
    local offset  = target:getBattlefield():getArea() - 1
    local snollID = ID.mob.SNOLL_TZAR_OFFSET + offset

    if target:getID() ~= snollID then
        msg = xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(caster) > 10 then
        msg = xi.msg.basic.TOO_FAR_AWAY
    end

    return msg
end

itemObject.onItemUse = function(target, player)
    local currentTime = GetSystemTime()
    local changeTime = target:getLocalVar('changeTime')
    local saltTime = target:getLocalVar('saltTime')

    -- Delay next form change by 20 seconds
    target:setLocalVar('changeTime', changeTime + 20)

    if saltTime < currentTime then
        target:messageText(target, ID.text.BEGINS_TO_MELT)
        target:setLocalVar('saltTime', currentTime + 20)
        target:setLocalVar('nextSteam', currentTime + math.random(7, 10))

    -- Extend existing salt duration by 20 seconds
    else
        target:setLocalVar('saltTime', saltTime + 20)
    end
end

return itemObject
