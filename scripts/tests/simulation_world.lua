-----------------------------------
-- Test: World simulation
-- Wrapper around the C++ interface CSimulation to pilot the map server.
-----------------------------------
---@class SimulationWorld
---@field simulation CSimulation
SimulationWorld = {}

---@private
SimulationWorld.__index = SimulationWorld

---@return SimulationWorld
function SimulationWorld:new(simulation)
    local obj = {}
    setmetatable(obj, self)
    obj.simulation = simulation
    return obj
end

---@class SpawnPlayerParams
---@field zone xi.zone?
---@field pos PositionRot?

---@param params SpawnPlayerParams?
---@return SimulationClient, CBaseEntity
function SimulationWorld:spawnPlayer(params)
    local zone = params and params.zone

    local client = SimulationClient:new(self.simulation:createPlayerClient(zone), self)

    -- Send log in packet
    local packet = PacketBuilder:new(0x0A)
    client.rawClient:sendPacket(packet.data)

    -- Eden code used to reuse the same underlying PChar but we recreate it on zones.
    -- The test code goes through the proxy to get the most recent PChar.
    local playerProxy = setmetatable({},
        {
            __index = function(_, key)
                local player = client:getPlayer()
                if player and player[key] then
                    if type(player[key]) == 'function' then
                        return function(_, ...) -- first arg is the proxy, don't need to pass it
                            return player[key](player, ...)
                        end
                    end

                    return player[key]
                end
            end,

            __call = function()
                return client:getPlayer()
            end,
        })

    return client, playerProxy
end

---@param times integer? Amount of times to tick in a row
function SimulationWorld:tick(times)
    for _ = 1, times or 1 do
        self.simulation:tick()
    end
end

---@param zoneId integer Zone ID to load
function SimulationWorld:loadZone(zoneId)
    self.simulation:loadZones(zoneId)
end

---@param entity CBaseEntity
function SimulationWorld:tickEntity(entity)
    self.simulation:tickEntity(entity)
end

---@class TimePeriod
---@field seconds integer?
---@field minutes integer?
---@field hours integer?
---@field days integer?

---@param time integer|TimePeriod Amount of seconds or table defining how much time to skip
function SimulationWorld:skipTime(time)
    if type(time) == 'number' then
        self.simulation:addSeconds(time)
    else
        local seconds = (time.seconds or 0) +
            60 * ((time.minutes or 0) + 60 * ((time.hours or 0) + 24 * (time.days or 0)))
        self.simulation:addSeconds(seconds)
    end
end

local function getSecondsToVanaTime(vanaHour, vanaMinute)
    local targetMinuteOfDay = vanaHour * 60 + (vanaMinute or 0)
    local currentMinuteOfDay = VanadielHour() * 60 + VanadielMinute()

    local vanaMinutesToSkip = targetMinuteOfDay - currentMinuteOfDay
    if vanaMinutesToSkip < 0 then
        vanaMinutesToSkip = vanaMinutesToSkip + 24 * 60
    end

    return vanaMinutesToSkip * 60 / 25
end

--- Skip time until the in-game hour matches the passed in one.
---@param vanaHour integer
function SimulationWorld:skipToVanaTime(vanaHour, vanaMinute)
    self:skipTime(getSecondsToVanaTime(vanaHour, vanaMinute))
end

--- Skip time until the in-game day matches the passed in one.
---@param day integer
function SimulationWorld:skipToVanaDay(day)
    self:skipTime(getSecondsToVanaTime(1))
    self:tick()

    local daysToSkip = day - VanadielDayOfTheWeek()
    if daysToSkip < 0 then
        daysToSkip = daysToSkip + 8
    end

    if daysToSkip > 0 then
        self:skipTime(daysToSkip * 3456) -- 3456 is Earth seconds per Vanadiel day
    end

    self:tick()

    assert(VanadielDayOfTheWeek() == day,
        string.format('Did not skip to correct day. Expected day %u, got %u.', day, VanadielDayOfTheWeek()))
    assert(VanadielHour() == 1,
        string.format('Did not skip to correct hour of day. Expected hour 1, got %u.', VanadielHour()))
    -- TODO: Somehow this code is warping us to 1:01 and not 1:00, so the Minute assertion fails.
end

function SimulationWorld:setSeed(seed)
    self.simulation:setSeed(seed)
end

function SimulationWorld:seed()
    self.simulation:seed()
end

return SimulationWorld
