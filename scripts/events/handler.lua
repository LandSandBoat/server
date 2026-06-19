-----------------------------------
-- Seasonal Events Handler
-----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.handler = xi.events.handler or {}
xi.events.scheduled = xi.events.scheduled or {}

-- Scheduled Event Type
xi.events.ScheduledEvent = {}
local scheduledEvent = xi.events.ScheduledEvent
scheduledEvent.__index = scheduledEvent
scheduledEvent.__eq = function(c1, c2)
    return c1.id == c2.id
end

function scheduledEvent:new(id)
    local obj = {}
    setmetatable(obj, self)
    obj.id = id
    obj.isEnabled = false

    obj.startFunc = function()
    end

    obj.endFunc = function()
    end

    obj.serverTickFunc = function()
    end

    obj.sections = nil

    -- Cleanup hot reload
    if xi.events.scheduled[id] and xi.events.scheduled[id].sections then
        InteractionGlobal.lookup:removeContainer(xi.events.scheduled[id])
    end

    xi.events.scheduled[id] = obj

    return obj
end

function scheduledEvent:getIsActive()
    local currentTime = GetSystemTime()
    local startTime   = GetServerVariable('[Event]' .. self.id .. 'Start')
    local endTime     = GetServerVariable('[Event]' .. self.id .. 'End')

    if startTime == 0 then
        return false
    elseif startTime > currentTime then
        return false
    elseif endTime == 0 or startTime > endTime then
        return true
    else
        return currentTime < endTime
    end
end

function scheduledEvent:getStartTime()
    return GetServerVariable('[Event]' .. self.id .. 'Start')
end

function scheduledEvent:getEndTime()
    return GetServerVariable('[Event]' .. self.id .. 'End')
end

function scheduledEvent:setStartFunction(startFunc)
    self.startFunc = startFunc
    return self
end

function scheduledEvent:setEndFunction(endFunc)
    self.endFunc = endFunc
    return self
end

function scheduledEvent:setServerTickFunction(serverTickFunc)
    self.serverTickFunc = serverTickFunc
    return self
end

function scheduledEvent:checkActive()
    local isEnabled = self.isEnabled

    self.isEnabled = scheduledEvent.getIsActive(self)

    if self.isEnabled ~= isEnabled then
        if self.isEnabled then
            print('Starting Scheduled Event: ' .. self.id)
            self:startFunc()
        else
            print('Ending Scheduled Event: ' .. self.id)
            self:endFunc()
        end
    end
end

function scheduledEvent:addInteractions(sections)
    if self.sections then
        InteractionGlobal.lookup:removeContainer(self)
    end

    self.sections = sections

    InteractionGlobal.lookup:addContainer(self)
end

-- Seasonal Event Type
SeasonalEvent = {}
SeasonalEvent.__index = SeasonalEvent
SeasonalEvent.__eq = function(c1, c2)
    return c1.id == c2.id
end

function SeasonalEvent:new(id)
    local obj = {}
    setmetatable(obj, self)
    obj.id = id
    obj.isEnabled = false
    obj.enableCheck = function()
        return false
    end

    obj.startFunc = {}
    obj.endFunc = {}
    return obj
end

function SeasonalEvent:setEnableCheck(enableCheck)
    self.enableCheck = enableCheck
    return self
end

function SeasonalEvent:setStartFunction(func)
    self.startFunc = func
    return self
end

function SeasonalEvent:setEndFunction(func)
    self.endFunc = func
    return self
end

function SeasonalEvent:checkStarting()
    local isEnabled = self.enableCheck()
    if isEnabled then
        print('Starting Seasonal Event: ' .. self.id)
        self:startFunc()
    end

    return self
end

function SeasonalEvent:checkEnding()
    local isEnabled = self:enableCheck()
    if not isEnabled then
        print('Ending Seasonal Event: ' .. self.id)
        self:endFunc()
    end

    return self
end

-- NOTE: Since this is caching require'd tables, this system won't easily
--     : work with Lua hot-reloading (yet)!
xi.events.registeredEvents =
{
    require('scripts/events/starlight_celebration'),
    require('scripts/events/egg_hunt_egg-stravaganza'),
    require('scripts/events/mog_bonanza'),
    require('scripts/events/strange_happenings'),
}

require('scripts/events/skill_up')
require('scripts/events/mob_hunt')

xi.events.handler.checkScheduledEvents = function()
    for id, event in pairs(xi.events.scheduled) do
        if type(event) == 'table' or type(event) == 'userdata' then
            if type(event.checkActive) == 'function' then
                event:checkActive()
            end

            if
                (event.isEnabled or (type(event.getIsActive) == 'function' and event:getIsActive())) and
                type(event.serverTickFunc) == 'function'
            then
                event:serverTickFunc()
            end
        else
            printf('[Events] Warning: Object in xi.events.scheduled["%s"] is not a valid event object (type: %s)', id, type(event))
        end
    end
end

xi.events.handler.checkSeasonalEvents = function()
    print('Checking Seasonal Events')

    for _, event in pairs(xi.events.registeredEvents) do
        event:checkEnding()
    end

    for _, event in pairs(xi.events.registeredEvents) do
        event:checkStarting()
    end
end

return xi.events.handler
