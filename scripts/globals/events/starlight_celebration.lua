------------------------------------
-- Starlight Celebration
------------------------------------
require("scripts/globals/settings")
------------------------------------
local event = SeasonalEvent:new("StarlightCelebration")

event:setEnableCheck(function()
    local month = tonumber(os.date("%m"))
    return month == 12
end)

local musicZones =
{
    xi.zone.UPPER_JEUNO,
    xi.zone.LOWER_JEUNO,
    xi.zone.PORT_JEUNO,
}

local starlightCelebrationMusic = 239
local grandDuchyOfJeunoMusic    = 110

local setMusic = function(musicId)
    for _, zoneId in pairs(musicZones) do
        local zone = GetZone(zoneId)
        if zone then
            -- Set the music of the zone, so that players zoning in will
            -- be sent it immediately
            zone:setBackgroundMusicDay(musicId)
            zone:setBackgroundMusicNight(musicId)

            -- Set the music for players already in the zone (this is wiped when
            -- they zone out)
            for _, player in pairs(zone:getPlayers()) do
                player:changeMusic(0, musicId)
                player:changeMusic(1, musicId)
            end
        end
    end
end

event:setStartFunction(function()
    setMusic(starlightCelebrationMusic)
end)

event:setEndFunction(function()
    setMusic(grandDuchyOfJeunoMusic)
end)

return event
