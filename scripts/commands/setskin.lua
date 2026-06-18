-----------------------------------
-- func: setskin <slot> <id>
-- desc: Sets the visual model ID for equipment slots
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 'si',
}

-- Equipment slot constants
local equipSlots =
{
    main   = xi.slot.MAIN,
    sub    = xi.slot.SUB,
    ranged = xi.slot.RANGED,
    ammo   = xi.slot.AMMO,
    head   = xi.slot.HEAD,
    body   = xi.slot.BODY,
    hands  = xi.slot.HANDS,
    legs   = xi.slot.LEGS,
    feet   = xi.slot.FEET,
}

local maxModelId = 1422

local function printUsage(player, errorMsg)
    local message = errorMsg or ''
    player:printToPlayer(message .. 'Usage: !setskin <slot> <id>', xi.msg.channel.SYSTEM_3)
    player:printToPlayer('  Slots: set, main, sub, ranged, ammo, head, body, hands, legs, feet', xi.msg.channel.SYSTEM_3)
    player:printToPlayer('  ID: 0-' .. maxModelId, xi.msg.channel.SYSTEM_3)
end

commandObj.onTrigger = function(player, slot, modelId)
    if not slot then
        printUsage(player, 'No slot specified. ')
        return
    end

    local slotName = string.lower(slot)

    -- Handle help/usage requests
    if slotName == 'usage' or slotName == 'help' then
        printUsage(player)
        return
    end

    -- Validate model ID
    if not modelId then
        printUsage(player, 'No model ID specified. ')
        return
    end

    if modelId < 0 or modelId > maxModelId then
        printUsage(player, string.format('Model ID out of range (0-%d). ', maxModelId))
        return
    end

    -- Handle "set" command (all armor slots)
    if slotName == 'set' then
        for i = xi.slot.HEAD, xi.slot.FEET do
            player:setModelId(modelId, i)
        end

        return
    end

    -- Handle individual slot
    local slotId = equipSlots[slotName]
    if slotId then
        player:setModelId(modelId, slotId)
    else
        printUsage(player, 'Invalid slot. ')
    end
end

return commandObj
