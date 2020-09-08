-----------------------------------
--
-- Zone: PsoXja (9)
--
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/treasure")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1,  -21.469, 27,  -24.255,  -18.723, 32,  -19.877) -- 40 cap (H-8 Tower)
    zone:registerRegion(2,  337.376, 27,  -19.836,  342.340, 32,  -16.055) -- 50 cap area (J-8 Tower)
    zone:registerRegion(3,   95.659, 42, -302.390,   99.973, 48, -297.744) -- 60 cap area (H-10 Tower)
    zone:registerRegion(4, -384.452, 26,  257.961, -379.945, 32,  262.558) -- Uncapped area 1 (F-7 Tower)
    zone:registerRegion(5, -302.493, 42, -179.995, -297.386, 48, -176.078) -- Uncapped area 2 (G-9 Tower)
    zone:registerRegion(6,  299.847, 42,  257.716,  303.824, 48,  262.391) -- Uncapped area 3 (I-7 Tower)

    tpz.treasure.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-29.956, -1.903, 212.521, 188)
    end

    if (player:getXPos() == -300 and player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("PromathiaStatus") == 2) then
        cs = 1 -- COP event
    elseif (player:getXPos() == 220 and player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS and player:getCharVar("COP_Tenzen_s_Path") == 8) then
        cs = 4
    end

    return cs
end

function afterZoneIn(player)
    player:entityVisualPacket("brmp")
    player:entityVisualPacket("lirp")
    player:entityVisualPacket("kil1")
    player:entityVisualPacket("kil2")
    player:entityVisualPacket("kil3")
    player:entityVisualPacket("saa1")
    player:entityVisualPacket("saa2")
    player:entityVisualPacket("saa3")
    player:entityVisualPacket("byc1")
    player:entityVisualPacket("byc2")
    player:entityVisualPacket("byc3")
    player:entityVisualPacket("byc4")
    player:entityVisualPacket("byc5")
    player:entityVisualPacket("byc6")
    player:entityVisualPacket("byc7")
    player:entityVisualPacket("byc8")
    player:entityVisualPacket("s123")

    -- ZONE WIDE LEVEL RESTRICTION
    if (ENABLE_COP_ZONE_CAP == 1) then
        local LVLcap = player:getCharVar("PSOXJA_RESTRICTION_LVL")
        if (LVLcap > 0) then -- LV cap depends on entrance
            player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, LVLcap, 0, 0)
        end
    end
end

function onRegionEnter(player, region)
    player:startEvent(19 + region:GetRegionID())
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 1) then
        player:setCharVar("PromathiaStatus", 3)
    elseif (csid == 4) then
        player:setCharVar("COP_Tenzen_s_Path", 9)
    elseif (csid == 20 and option == 1) then
        player:setPos(-20, -60.250, -60, 63, 111)
    elseif (csid == 21 and option == 1) then
        player:setPos(260, -0.25, -20, 254, 111)
    elseif (csid == 22 and option == 1) then
        player:setPos(60, -0.250, -340.000, 190, 111)
    elseif (csid == 23 and option == 1) then
        player:setPos(-340, -100.250, 140, 63, 111)
    elseif (csid == 24 and option == 1) then
        player:setPos(-180, -40.25 , -220, 0, 111)
    elseif (csid == 25 and option == 1) then
        player:setPos(100, -20.25, 140, 64, 111)
    end
end
