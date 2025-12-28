-----------------------------------
-- ID: 5266
-- Item: Blackened Muddy Siredon
-- Item Effect: Temporarily removes Shikaree regain
-----------------------------------
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = xi.msg.basic.ITEM_UNABLE_TO_USE

    if
        target:getPool() == xi.mobPools.SHIKAREE_X or
        target:getPool() == xi.mobPools.SHIKAREE_Y or
        target:getPool() == xi.mobPools.SHIKAREE_Z
    then
        result = 0
    elseif target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    local pool = target:getPool()
    local siredonCount = target:getLocalVar('siredonCount')

    -- Shikaree Z rejects the second siredon
    if pool == xi.mobPools.SHIKAREE_Z and siredonCount >= 1 then
        target:messageText(target, ID.text.SHIKAREE_Z_OFFSET + 6) -- SIREDON_REJECT
        return
    end

    -- Determine which accept message to use based on pool and count
    local messageOffsets =
    {
        [xi.mobPools.SHIKAREE_X] = { ID.text.SHIKAREE_X_OFFSET + 5, ID.text.SHIKAREE_X_OFFSET + 6 },
        [xi.mobPools.SHIKAREE_Y] = { ID.text.SHIKAREE_Y_OFFSET + 5, ID.text.SHIKAREE_Y_OFFSET + 6 },
        [xi.mobPools.SHIKAREE_Z] = { ID.text.SHIKAREE_Z_OFFSET + 5 },
    }

    local messages = messageOffsets[pool]
    local messageIndex = math.min(siredonCount + 1, #messages)
    local messageOffset = messages[messageIndex]

    -- Display acceptance message
    target:messageText(target, messageOffset)

    -- Increment siredon count
    target:setLocalVar('siredonCount', siredonCount + 1)

    -- Disable regain for 60 seconds (use GetSystemTime for game timing)
    target:setLocalVar('siredonTimer', GetSystemTime() + 60)
    target:setMod(xi.mod.REGAIN, 0)
end

return itemObject
