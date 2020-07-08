-----------------------------------
--
-- Zone: Kuftal_Tunnel (174)
--
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.GUIVRE)
    GetMobByID(ID.mob.GUIVRE):setRespawnTime(math.random(900, 10800))

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(20.37, -21.104, 275.782, 46)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onGameHour(zone)
    local phase = VanadielMoonPhase() -- 0% to 100%
    local dir = VanadielMoonDirection() -- 0 (neither) 1 (waning) or 2 (waxing)
    local boulderOpen =
    {
        [1] = {
            [ 1] = function() return (phase >= 29 and phase <= 43) end,
            [ 3] = function() return (phase >= 12 and phase <= 26) end,
            [ 5] = function() return (phase <= 10  or phase >= 95) end,
            [ 7] = function() return (phase >= 79 and phase <= 93) end,
            [ 9] = function() return (phase >= 62 and phase <= 76) end,
            [11] = function() return (phase >= 45 and phase <= 60) end,
            [13] = function() return (phase >= 29 and phase <= 43) end,
            [15] = function() return (phase >= 12 and phase <= 26) end,
            [17] = function() return (phase <= 10  or phase >= 95) end,
            [19] = function() return (phase >= 79 and phase <= 93) end,
            [21] = function() return (phase >= 62 and phase <= 76) end,
            [23] = function() return (phase >= 45 and phase <= 60) end,
        },
        [2] = {
            [ 1] = function() return (phase >= 57 and phase <= 71) end,
            [ 3] = function() return (phase >= 74 and phase <= 88) end,
            [ 5] = function() return (phase <=  5  or phase >= 90) end,
            [ 7] = function() return (phase >=  7 and phase <= 21) end,
            [ 9] = function() return (phase >= 24 and phase <= 38) end,
            [11] = function() return (phase >= 40 and phase <= 55) end,
            [13] = function() return (phase >= 57 and phase <= 71) end,
            [15] = function() return (phase >= 74 and phase <= 88) end,
            [17] = function() return (phase <=  5  or phase >= 90) end,
            [19] = function() return (phase >=  7 and phase <= 21) end,
            [21] = function() return (phase >= 24 and phase <= 38) end,
            [23] = function() return (phase >= 40 and phase <= 55) end,
        }
    }

    if dir > 0 then
        local shouldOpen = boulderOpen[dir][VanadielHour()]
        local boulder = GetNPCByID(ID.npc.DOOR_ROCK)
        if shouldOpen and shouldOpen() and boulder:getAnimation() == tpz.anim.CLOSE_DOOR then
            boulder:openDoor(144 * 6) -- one vanadiel hour is 144 earth seconds. lower boulder for 6 vanadiel hours.
        end
    end
end
