-----------------------------------
-- Ferry deck mobs
-- Shared by the Selbina and Mhaura boats and the four Al Zahbi routes.
-- The deck mobs are not on respawn timers.
-- Every 60 seconds the zone rolls once and boards at most one mob.
-- A boarding skips the next two rolls.
-- The lottery chance drops as more deck mobs are up.
-- Day slots fade after three to nine turns of 70 seconds.
-- Night slots only join the roll from 20:00 to 03:59 and stay until their spawn window fades them at 04:00.
-- Elementals only roll when the lottery misses and stay until their weather ends.
-- All mobs are cleared once the voyage ends, including during arrival events.
-----------------------------------
xi = xi or {}
xi.ferry = xi.ferry or {}

-- Percent chance that the lottery boards a mob, by how many deck mobs are already up.
-- Capture: 25 of 89 rolls with the deck empty, 39 of 187 with one mob up, 3 of 43 with two, 0 of 2 with three or more.
local rollChance =
{
    [0] = 30,
    [1] = 20,
    [2] = 8,
}

xi.ferry.onTransportVoyageEnd = function(zone)
    for _, mob in pairs(zone:getMobs()) do
        -- Cancel spawns scheduled by the ending ride, including mobs not yet visible.
        mob:setRespawnTime(0)

        -- Release charmed mobs before despawn so their next life has no pet links.
        if mob:isCharmed() then
            local master = mob:getMaster()
            if master then
                master:despawnPet()
            end
        end

        if mob:isSpawned() then
            DespawnMob(mob:getID())
        end
    end
end

xi.ferry.onZoneTick = function(zone, slots)
    local currentTime = GetSystemTime()
    if currentTime < zone:getLocalVar('[ferry]nextRoll') then
        return
    end

    zone:setLocalVar('[ferry]nextRoll', currentTime + 60)

    local hour       = VanadielHour()
    local weather    = zone:getWeather()
    local lottery    = {}
    local elementals = {}
    local visible    = 0

    for _, slot in ipairs(slots) do
        local mob = GetMobByID(slot.id)
        if mob and mob:isSpawned() then
            visible = visible + 1
        elseif
            mob and
            (not slot.night or hour >= 20 or hour < 4) and
            (not slot.weather or utils.contains(weather, slot.weather))
        then
            local listToUse = slot.weather and elementals or lottery
            table.insert(listToUse, slot)
        end
    end

    if #lottery > 0 and math.randomInt(1, 100) <= (rollChance[visible] or 0) then
        local slot = lottery[math.randomInt(1, #lottery)]
        SpawnMob(slot.id)

        -- Capture: 27 fades, all at 3 to 9 turns of 70 seconds.
        if not slot.night then
            DespawnMob(slot.id, 70 * math.randomInt(3, 9))
        end

        -- Capture: 47 gaps between spawns in a ride, all 180 seconds or more.
        zone:setLocalVar('[ferry]nextRoll', currentTime + 180)
        return
    end

    -- Capture: the elemental boarded on 9 of 30 lottery misses under its weather.
    for _, slot in ipairs(elementals) do
        if math.randomInt(1, 100) <= 30 then
            SpawnMob(slot.id)
            zone:setLocalVar('[ferry]nextRoll', currentTime + 180)
            return
        end
    end
end

xi.ferry.onWeatherChange = function(weather, slots)
    for _, slot in ipairs(slots) do
        local mob = GetMobByID(slot.id)
        if
            slot.weather and
            mob and
            mob:isSpawned() and
            not utils.contains(weather, slot.weather)
        then
            DespawnMob(slot.id, 1)
        end
    end
end
