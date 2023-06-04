-----------------------------------
-- Seasonal Events Handler
-----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.handler = xi.events.handler or {}

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
        print("Starting Seasonal Event: " .. self.id)
        self:startFunc()
    end

    return self
end

function SeasonalEvent:checkEnding()
    local isEnabled = self:enableCheck()
    if not isEnabled then
        print("Ending Seasonal Event: " .. self.id)
        self:endFunc()
    end

    return self
end

-- NOTE: Since this is caching require'd tables, this system won't easily
--     : work with Lua hot-reloading (yet)!
xi.events.registeredEvents =
{
    require("scripts/globals/events/starlight_celebration"),
}

xi.events.handler.checkSeasonalEvents = function()
    print("Checking Seasonal Events")

    for _, event in pairs(xi.events.registeredEvents) do
        event:checkEnding()
    end

    for _, event in pairs(xi.events.registeredEvents) do
        event:checkStarting()
    end
end

return xi.events.handler
