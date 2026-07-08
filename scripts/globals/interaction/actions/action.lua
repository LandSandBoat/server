-----------------------------------
----- Action base class
-----------------------------------
---@class TAction
Action = {}

---@enum Action.Priority
Action.Priority =
{
    Ignore = 1,
    Default = 10,
    ReplaceDefault = 20,
    Message = 50,
    Event = 100,
    Progress = 1000,
}

---@enum Action.Type
Action.Type =
{
    LambdaAction = 0,
    Event = 1,
    Message = 2,
    Sequence = 3,
    Face = 4,
    Wait = 5,
    Release = 6,
    KeyItem = 7,
    NoAction = 8,
}

---@param type Action.Type
---@return TAction
function Action:new(type)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.type = type
    return obj
end

---@param player CBaseEntity
---@param targetEntity CBaseEntity
---@return integer
function Action:perform(player, targetEntity)
    -- Functionality is implemented in the specific sub-classes
    return self.returnValue
end

---@param priorityArg Action.Priority|integer
---@return TAction
function Action:setPriority(priorityArg)
    self.priority = priorityArg
    return self
end

---@return TAction
function Action:progress()
    -- Set highest priority for action
    return self:setPriority(Action.Priority.Progress)
end

---@return TAction
function Action:replaceDefault()
    -- Always prefer this over falling back to default in lua file
    return self:setPriority(Action.Priority.ReplaceDefault)
end

-- Perform the action as a Progress priority, and then default back to event
---@return TAction
function Action:importantEvent()
    self.priority = Action.Priority.Progress
    self.secondaryPriority = Action.Priority.Event
    return self
end

-- After the first time the action is performed, it will have a lower priority
---@return TAction
function Action:importantOnce()
    self.priority = Action.Priority.Event
    self.secondaryPriority = Action.Priority.Default
    return self
end

-- Only do this action once per zone, unless there's nothing else to do
---@return TAction
function Action:oncePerZone()
    self.secondaryPriority = Action.Priority.Ignore
    return self
end

---@return TAction
function Action:openDoor()
    self.returnValue = -1
    return self
end

---@return TAction
function Action:open()
    return self:openDoor()
end
