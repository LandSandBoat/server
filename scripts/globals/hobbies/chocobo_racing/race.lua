-----------------------------------
-- Chocobo Racing: Races
-- A race's field is posted on the schedule and saved. Its result is simulated only when the race starts, so nothing can reveal it earlier.
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- Chance for a race to be rainy
local rainPercent = 42

-- Meaning unknown.
-- This reproduces observed distribution in captures.
local intro =
{
    variant        = 64,
    variantPercent = 41,
    step           = { { 3, 73 }, { 4, 22 }, { 5, 5 } },
}

-- Races read recently, by race number. Only the most recent few stay.
local cachedRaces = {}
local cacheSize   = 3

--- A posted race, or nil when it has not been posted.
---@param raceNo integer
---@return ChocoboRaceResult?
xi.chocoboRacing.getRace = function(raceNo)
    if cachedRaces[raceNo] then
        return cachedRaces[raceNo]
    end

    local race = LoadChocoboRaceResult(raceNo)

    -- Early return: not posted yet.
    if not race then
        return nil
    end

    cachedRaces[raceNo] = race

    local cached = 0
    local oldest = raceNo
    for cachedRaceNo in pairs(cachedRaces) do
        cached = cached + 1
        oldest = math.min(oldest, cachedRaceNo)
    end

    if cached > cacheSize then
        cachedRaces[oldest] = nil
    end

    return race
end

--- Draws and saves the field of a race that has not been posted yet.
---@param raceNo integer
xi.chocoboRacing.postRace = function(raceNo)
    -- Early return: already posted.
    if xi.chocoboRacing.getRace(raceNo) then
        return
    end

    local weather = xi.weather.SUNSHINE
    if math.randomInt(1, 100) <= rainPercent then
        weather = xi.weather.RAIN
    end

    SaveChocoboRaceResult({
        raceNo   = raceNo,
        runAt    = 0,
        weather  = weather,
        chocobos = xi.chocoboRacing.drawField(raceNo),
    })
end

--- Simulates a race and saves its result. Posts it first if the schedule missed it.
---@param raceNo integer
---@return ChocoboRaceResult
xi.chocoboRacing.runRace = function(raceNo)
    xi.chocoboRacing.postRace(raceNo)

    local race = assert(xi.chocoboRacing.getRace(raceNo))

    -- Early return: already run.
    if race.runAt > 0 then
        return race
    end

    xi.chocoboRacing.simulator.run(race)

    local line    = math.randomInt(0, 15)
    local variant = 0
    if math.randomInt(1, 100) <= intro.variantPercent then
        variant = intro.variant
    end

    local step = xi.chocoboRacing.rollOdds(intro.step)
    race.intro = { line + variant, (line + step) % 16 + variant }
    race.runAt = GetSystemTime()
    SaveChocoboRaceResult(race)

    return race
end
