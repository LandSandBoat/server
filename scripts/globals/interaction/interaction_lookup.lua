-----------------------------------
-- InteractionLookup class
-----------------------------------
require('scripts/globals/interaction/action_util')
require('scripts/globals/interaction/interaction_util')

-- The 'data' variable will contain nested tables used to lookup if a certain NPC/mob/event has any handlers connected to it that should be run.
-- The structure of it is as follows (also see illustration below):
--  * First level of tables has keys that are the zone in which the handler takes place.
--  * Second level of tables has keys that are either the name of the entity which has the handler, or special zone-wide handlers like 'onEventFinish'.
--  * Third level of tables for entities has keys that are the name of the handlers, like 'onTrigger', 'onTrade', etc.
--    For zone-wide handlers like 'onEventFinish', the third level keys are the ID of the thing that is being finished, in the case of an event it is the event ID.
--
-- Finally the actual handlers will be found in a list as the values of the third level tables.
-- These handlers have an associated "check" function, that is run to check if the player is elligible to have the corresponding handler functon performed or not.
--[[ Illustration of the structure of the data:
{
    -- First level (zone ID)
    [xi.zone.SOME_ZONE] = {

        -- Second level (entity name)
        ['Some_NPC'] = {

            -- Third level (handler name)
            ['onTrigger'] = {

                -- List of handlers in the form below
                { check = function (player) .. end, handler = function (player) .. end, container = .. },
            }
        },

        -- Second level (zone-wide handler name)
        ['onEventFinish'] = {

            -- Third level (specifier for handler, here the ID of the event)
            [123] = {

                -- List of handlers in the form below
                { check = function (player) .. end, handler = function (player) .. end, container = .. },
            }
        }
    }
}
--]]
InteractionLookup = {
}

function InteractionLookup:new(original)
    local obj = original or {}
    setmetatable(obj, self)
    self.__index = self
    obj.data = obj.data or {}
    obj.containers = obj.containers or {}
    obj.zoneDefaults = obj.zoneDefaults or {}
    return obj
end


-----------------------------------
-- Add/Remove helpers
-----------------------------------

local function addHandler(thirdLevel, thirdLevelKey, handler, metatable)
    thirdLevel[thirdLevelKey] = thirdLevel[thirdLevelKey] or {}
    table.insert(thirdLevel[thirdLevelKey], setmetatable({ handler = handler }, metatable))
end

-- Parse out handler information into a table for future lookup
-- Table structure is:
--  i.e. data[123]['Miene']['onTrigger'] =
--      { container = <container object>,
--        check = <check function for section>,
--        handler = <action definition or function to run>,
--      }
local function addHandlers(secondLevel, lookupSecondLevel, checkFunc, container)

    -- Use base table that all the handlers will reuse, to avoid creating many
    -- very similar objects in the lookup table
    local baseHandlerTable = {}
    if checkFunc then
        baseHandlerTable.check = checkFunc
    end
    if container then
        baseHandlerTable.container = container
    end
    local mt = { __index = baseHandlerTable }

    -- Loop through the given second level table, and add them to lookup as needed
    for secondLevelKey, thirdLevel in pairs(secondLevel) do
        lookupSecondLevel[secondLevelKey] = lookupSecondLevel[secondLevelKey] or {}

        -- If only given a function or an action definition as third level, that will default to be an onTrigger handler
        local onTriggerHandler = actionUtil.parseActionDef(thirdLevel)
        if onTriggerHandler then
            addHandler(lookupSecondLevel[secondLevelKey], 'onTrigger', onTriggerHandler, mt)
        else
            -- Parse out the handlers for the container
            for thirdLevelKey, handler in pairs(thirdLevel) do
                addHandler(lookupSecondLevel[secondLevelKey], thirdLevelKey, actionUtil.parseActionDef(handler), mt)
            end
        end
    end
end

local function removeHandlersMatching(secondLevel, lookupSecondLevel, condition)
    for secondLevelKey, thirdLevel in pairs(secondLevel) do
        if lookupSecondLevel[secondLevelKey] then

            -- Take care of short-hand action definitions that are made into onTrigger handlers
            local onTriggerHandler = actionUtil.parseActionDef(thirdLevel)
            if onTriggerHandler then
                thirdLevel = { ['onTrigger'] = 0 }
            end

            for thirdLevelKey, _ in pairs(thirdLevel) do
                local entries = lookupSecondLevel[secondLevelKey][thirdLevelKey]
                if entries then
                    for i = 1, #entries do
                        if entries[i] and condition(entries[i]) then
                            table.remove(entries, i)
                        end
                    end
                end
            end
        end
    end
end

-----------------------------------
-- Setup
-----------------------------------

-- Add default handlers for a given zone
function InteractionLookup:addDefaultHandlers(zoneId, handlerTable)
    self.data[zoneId] = self.data[zoneId] or {}

    if self.zoneDefaults[zoneId] then
        self:removeDefaultHandlers(zoneId)
    end

    self.zoneDefaults[zoneId] = true

    for _, actionDef in pairs(handlerTable) do
        if actionDef.prio == nil then
            actionDef.prio = Action.Priority.Default
        end
    end

    addHandlers(handlerTable, self.data[zoneId])
end

-- Remove default handlers for a given zone
function InteractionLookup:removeDefaultHandlers(zoneId)
    if self.data[zoneId] then
        removeHandlersMatching(self.data[zoneId], self.data[zoneId], function (entry) return entry.check == nil and entry.container == nil end)
    end
    self.zoneDefaults[zoneId] = false
end

-- Add the given containers to the lookup table
function InteractionLookup:addContainers(containers, zoneIds)
    local validZoneTable = nil
    if zoneIds ~= nil then
        validZoneTable = {}
        for i=1, #zoneIds do
           validZoneTable[zoneIds[i]] = true
        end
    end

    for _, container in ipairs(containers) do
        self:addContainer(container, validZoneTable)
    end
end

-- Add handlers from a container, if the handler is in a zone in the valid zone table
function InteractionLookup:addContainer(container, validZoneTable)
    if self.containers[container.id] then
        -- Container already added, need to remove it first to re-add.
        printf("Can't add a container that is already a loaded. Need to remove it first: " .. container.id);
        return
    end

    self.containers[container.id] = true

    -- Add to lookup
    for _, section in ipairs(container.sections) do
        local checkFunc = section.check
        for zoneId, secondLevel in pairs(section) do
            if zoneId ~= "check" and (validZoneTable == nil or validZoneTable[zoneId]) then
                self.data[zoneId] = self.data[zoneId] or {}
                addHandlers(secondLevel, self.data[zoneId], checkFunc, container)
            end
        end
    end
end

-- Remove handlers for a container
function InteractionLookup:removeContainer(container)
    for _, section in ipairs(container.sections) do
        for zoneid, secondLevel in pairs(section) do
            if zoneid ~= "check" and self.data[zoneid] then
                removeHandlersMatching(secondLevel, self.data[zoneid], function (entry) return entry.container == container end)
            end
        end
    end

    self.containers[container.id] = nil
end

-----------------------------------
-- Execution
-----------------------------------

-- Safely runs the handler with the given args
local function runHandler(handler, args)
    if not handler or type(handler) == 'table' then
        return handler
    end

    local ok, res = pcall(handler, unpack(args))
    if ok then
        return res
    else
        printf("Error running handler: %s", res)
    end
end


-- Use preprocessed lookup to run relevant handlers
local function runHandlersInData(data, player, secondLevelKey, thirdLevelKey, args)
    if not data then
        return { }
    end

    local secondLevelTable = data[player:getZoneID()]
    if not secondLevelTable
        or not secondLevelTable[secondLevelKey]
        or not secondLevelTable[secondLevelKey][thirdLevelKey] then
        return { }
    end

    local actions = { }
    local varCache = interactionUtil.makeTableCache(function (varname)
        return player:getVar(varname)
    end)
    local containerVarCache = interactionUtil.makeContainerVarCache(player)
    for _, entry in ipairs(secondLevelTable[secondLevelKey][thirdLevelKey]) do
        local checkArgs = { }
        if entry.container then
            if entry.container.getCheckArgs then
                checkArgs = entry.container:getCheckArgs(player)
            end
            checkArgs[#checkArgs+1] = containerVarCache[entry.container]
            checkArgs[#checkArgs+1] = varCache
        end

        local ok, res = true, true
        if entry.check then
            ok, res = pcall(entry.check, player, unpack(checkArgs))
        end

        if not ok then
            printf("Error running check: %s", res)
        elseif res then
            local resultAction = runHandler(entry.handler, args)
            if resultAction ~= nil then
                table.insert(actions, resultAction)
            end
        end
    end

    return actions
end


-- Find the current highest priority actions
local function getHighestPriorityActions(data, player, secondLevelKey, thirdLevelKey, args)
    local possibleActions = runHandlersInData(data, player, secondLevelKey, thirdLevelKey, args)

    -- If the possible actions is a number, we should always return immediately since it's CS ID from an onZoneIn
    if possibleActions and #possibleActions == 0 or type(possibleActions[1]) == 'number' then
        return possibleActions, Action.Priority.Progress
    end

    local maxPriority = Action.Priority.Default
    local highestPriorityActions = { }
    for _, action in ipairs(possibleActions) do
        if action then
            -- Use the updated the priority of the action if any, else use the default action priority
            local updatedPriority = player:getLocalVar(actionUtil.getActionVarName(secondLevelKey, thirdLevelKey, action.id))
            local priority = updatedPriority ~= 0 and updatedPriority or action.priority

            if priority == nil then
                if maxPriority == Action.Priority.Default then
                    table.insert(highestPriorityActions, action)
                end

            elseif priority == maxPriority then
                table.insert(highestPriorityActions, action)

            elseif priority > maxPriority then
                maxPriority = priority
                highestPriorityActions = { action }
            end
        end
    end

    return highestPriorityActions, maxPriority
end

-- Perform the next action of the given actions based on which have been performed before
local function performNextAction(player, containerId, handlerId, actions, targetId)
    local actionToPerform = actions[1]
    if containerId == 'onZoneIn' then -- onZoneIn returns CS IDs as numbers, so return the first one
        return actionToPerform
    end

    -- Figure out which action to perform if there's multiple
    local actionCount = #actions
    if actionCount > 1 then
        local nextIndex = 1

        -- Keep track of which action we're at in a local variable
        local actionCycleId = actionUtil.getActionVarName(containerId, handlerId)
        local previousActionId = player:getLocalVar(actionCycleId)
        if previousActionId > 0 then
            for idx, currentAction in ipairs(actions) do
                if currentAction.id == previousActionId then
                    nextIndex = idx + 1
                end
            end
        end
        if nextIndex > actionCount then
            nextIndex = 1
        end

        actionToPerform = actions[nextIndex]
        player:setLocalVar(actionCycleId, actionToPerform.id)
    end

    local didPerformAction = actionToPerform ~= nil
    local returnValue = nil
    if didPerformAction then
        returnValue = actionToPerform:perform(player, targetId and GetNPCByID(targetId) or nil) or 0
    end

    -- If the action has a secondary priorty, we set a local variable on the player,
    -- such that the next time this action is evaluated, it will use that priority instead
    if didPerformAction and actionToPerform.secondaryPriority then
        player:setLocalVar(actionUtil.getActionVarName(containerId, handlerId, actionToPerform.id), actionToPerform.secondaryPriority)
    end
    return didPerformAction and returnValue
end



-----------------------------------
-- Handlers
-----------------------------------

-- Main handler function that determines which action should be performed
local function onHandler(data, secondLevelKey, thirdLevelKey, args, fallbackHandler, defaultReturn, targetId)
    local playerArg = args.playerArg or 1
    local player = args[playerArg]
    if not player then -- if no player object is present, we can't do anything in the handler system
        return fallbackHandler(unpack(args))
    end

    local actions, priority = getHighestPriorityActions(data, player, secondLevelKey, thirdLevelKey, args)
    local fallbackVar = actionUtil.getActionVarName(secondLevelKey, thirdLevelKey, "UseFallback")

    -- Most handlers should run both the handler system and fallback if available,
    -- except those that should only perform one action at a time, like onTrigger and onTrade
    if fallbackHandler and thirdLevelKey ~= 'onTrigger' and thirdLevelKey ~= 'onTrade' then
        local result = performNextAction(player, secondLevelKey, thirdLevelKey, actions, targetId) or defaultReturn
        local fallbackResult = fallbackHandler(unpack(args))
        return result or fallbackResult
    end

    -- Prioritize important actions from the handler system if applicable
    if not fallbackHandler
        or (#actions > 0 -- only prioritize if there's actually actions to do
            and (secondLevelKey == 'onZoneIn' -- play onZoneIn cs if given
                or priority > Action.Priority.Event -- prioritize this if event is important enough
                or player:getLocalVar(fallbackVar) == 0) -- alternate between trying handler system and fallback handler
            )
    then
        player:setLocalVar(fallbackVar, 1)
        local result = performNextAction(player, secondLevelKey, thirdLevelKey, actions, targetId) or defaultReturn
        return result
    end


    -- Else we try to fallback to Lua files for the entity/zone
    player:setLocalVar(fallbackVar, 0)
    player:resetGotMessage()

    -- Fall back to side-loaded handler from other lua file
    local result = fallbackHandler(unpack(args))
    if player:isInEvent() or player:didGetMessage() -- Fallback handler triggered something
        or (result == -1 and thirdLevelKey == 'onTrigger')  -- Doors return -1 to open
        or (result ~= nil and result ~= -1 and secondLevelKey == 'onZoneIn') -- onZoneIn returns a csid if any, else -1
    then
        return result
    end

    -- If old handler didn't do anything significant,
    -- we try a lower priority action from handler system instead
    result = performNextAction(player, secondLevelKey, thirdLevelKey, actions, targetId)
    return result
end


function InteractionLookup:onTrigger(player, npc, fallbackFn)
    return onHandler(self.data, npc:getName(), 'onTrigger', { player, npc }, fallbackFn, -1, npc:getID())
end

function InteractionLookup:onTrade(player, npc, trade, fallbackFn)
    return onHandler(self.data, npc:getName(), 'onTrade', { player, npc, trade }, fallbackFn, nil, npc:getID())
end

function InteractionLookup:onMobDeath(mob, player, isKiller, firstCall, fallbackFn)
    return onHandler(self.data, mob:getName(), 'onMobDeath', { mob, player, isKiller, firstCall, playerArg = 2 }, fallbackFn)
end

function InteractionLookup:onRegionEnter(player, region, fallbackFn)
    return onHandler(self.data, 'onRegionEnter', region:GetRegionID(), { player, region }, fallbackFn)
end

function InteractionLookup:onRegionLeave(player, region, fallbackFn)
    return onHandler(self.data, 'onRegionLeave', region:GetRegionID(), { player, region }, fallbackFn)
end

function InteractionLookup:onZoneIn(player, prevZone, fallbackFn)
    return onHandler(self.data, 'onZoneIn', 1, { player, prevZone }, fallbackFn)
end

function InteractionLookup:onEventFinish(player, csid, option, npc, fallbackFn)
    return onHandler(self.data, 'onEventFinish', csid, { player, csid, option, npc }, fallbackFn)
end

function InteractionLookup:onEventUpdate(player, csid, option, npc, fallbackFn)
    return onHandler(self.data, 'onEventUpdate', csid, { player, csid, option, npc }, fallbackFn)
end
