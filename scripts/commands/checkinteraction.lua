-----------------------------------
-- func: !checkinteraction (handlerName)
-- desc:
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 's'
}

local typeToName = {}
for name, typeVal in pairs(Action.Type) do
    typeToName[typeVal] = name
end

local function handlerToString(handler, player, containerVarCache, varCache)
    local action = handler.handler

    local message = type(action)
    if message == 'table' then
        message = string.format('Type: %s, ID: %s, Priority: %d', typeToName[action.type], action.id, action.priority)
    end

    if handler.container then
        message = message .. ' [container: ' .. handler.container.id .. ']'
    end

    if handler.check then
        local checkArgs = { }
        if handler.container then
            if handler.container.getCheckArgs then
                checkArgs = handler.container:getCheckArgs(player)
            end

            checkArgs[#checkArgs + 1] = containerVarCache[handler.container]
            checkArgs[#checkArgs + 1] = varCache
        end

        message = message .. ' [check: ' .. (handler.check(player, unpack(checkArgs)) and 'true' or 'false') .. ']'
    end

    return message
end

commandObj.onTrigger = function(player, handlerName)
    local function cmdPrint(message, ...)
        player:printToPlayer(string.format(message, unpack({ ... }) or nil), 17)
    end

    if handlerName == nil then
        local target = player:getCursorTarget()
        if target and target:isNPC() then
            handlerName = target:getName()
        else
            cmdPrint('No valid handler targeted or handler name given.')
            return
        end
    end

    local data = InteractionGlobal.lookup.data
    if data == nil then
        cmdPrint('No data in interaction global.')
        return
    end

    local zoneData = data[player:getZoneID()]
    if zoneData == nil then
        cmdPrint('No interactions in zone.')
        return
    end

    local handlerData = zoneData[handlerName]
    if handlerData == nil then
        cmdPrint('No interactions for "%s".', handlerName)
        return
    end

    local varCache = interactionUtil.makeTableCache(function(varname)
        return player:getCharVar(varname)
    end)

    local containerVarCache = interactionUtil.makeContainerVarCache(player)

    local function gatherHandlers(category)
        local handlers = {}
        if handlerData[category] then
            for i = 1, #handlerData[category] do
                table.insert(handlers, handlerToString(handlerData[category][i], player, containerVarCache, varCache))
            end
        end

        return handlers
    end

    local onSteals = gatherHandlers('onSteal')
    local onTriggers = gatherHandlers('onTrigger')
    local onTrades = gatherHandlers('onTrade')

    if #onTriggers == 0 and #onTrades == 0 then
        cmdPrint('No interactions for "%s".', handlerName)
        return
    end

    local function printHandlers(category, handlers)
        if #handlers > 0 then
            cmdPrint(category .. ':')
            for i = 1, #handlers do
                cmdPrint('  ' .. handlers[i])
            end
        end
    end

    cmdPrint('Handlers for "%s":', handlerName)
    printHandlers('Steal', onSteals)
    printHandlers('Trigger', onTriggers)
    printHandlers('Trade', onTrades)
end

return commandObj
