-----------------------------------
--
-- Zone: Hall_of_Transference
--
-----------------------------------
local ID = require("scripts/zones/Hall_of_Transference/IDs")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -281, -5, 277, -276, 0, 284)      -- Holla
    zone:registerRegion(2, 276, -84, -82, 283, -80, -75)     -- Mea
    zone:registerRegion(3, -283, -45, -283, -276, -40, -276) -- Dem
    zone:registerRegion(4, 0, 0, 0, 0, 0, 0)

    zone:registerRegion(5, 288.847, -83.960, -40.693, 291.209, -79.960, -37.510)     -- Mea Sky Teleporter
    zone:registerRegion(6, -240.181, -3.960, 268.409, -237.671, 1.960, 271.291)      -- Holla Sky Teleporter
    zone:registerRegion(7, -240.797, -43.960, -291.552, -237.944, -39.960, -288.954) -- Dem Sky Teleporter
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(274, -82, -62 , 180)

    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.THE_MOTHERCRYSTALS then
        -- cs you got when you enter hall of transference for the last promyvion
        if player:getCharVar("cspromy3") == 1 then
            if prevZone == tpz.zone.LA_THEINE_PLATEAU then
                if player:hasKeyItem(tpz.ki.LIGHT_OF_DEM) and player:hasKeyItem(tpz.ki.LIGHT_OF_MEA) and not player:hasKeyItem(tpz.ki.LIGHT_OF_HOLLA) then
                    cs = 155
                end
            elseif prevZone == tpz.zone.KONSCHTAT_HIGHLANDS then
                if player:hasKeyItem(tpz.ki.LIGHT_OF_HOLLA) and player:hasKeyItem(tpz.ki.LIGHT_OF_MEA) and not player:hasKeyItem(tpz.ki.LIGHT_OF_DEM) then
                    cs = 155
                end
            elseif prevZone == tpz.zone.TAHRONGI_CANYON then
                if player:hasKeyItem(tpz.ki.LIGHT_OF_HOLLA) and player:hasKeyItem(tpz.ki.LIGHT_OF_DEM) and not player:hasKeyItem(tpz.ki.LIGHT_OF_MEA) then
                    cs = 155
                end
            end
        end
    end

    return cs
end

function onRegionEnter(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function (x) -- Holla
            player:setCharVar("option", 1)
            player:startEvent(103)
        end,
        [2] = function (x) -- Mea
            player:setCharVar("option", 1)
            player:startEvent(104)
        end,
        [3] = function (x) -- Dem
            player:setCharVar("option", 1)
            player:startEvent(105)
        end,
        [4] = function (x)
            player:setCharVar("option", 2)
            player:startEvent(103)
        end,
        [5] = function (x)
            if player:getCharVar("MeaChipRegistration") == 1 then
                if math.random(1, 100) <= 95 or player:getCharVar("LastSkyWarpMea") ~= tonumber(os.date("%j")) then -- 5% Chance chip breaks
                    player:startEvent(161) -- To Sky
                else
                    player:startEvent(169) -- Chip Breaks!
                end
            else
                player:startEvent(162) -- Please Register..
            end
        end,
        [6] = function (x)
            if player:getCharVar("HollaChipRegistration") == 1 then
                if math.random(1, 100) <= 95 or player:getCharVar("LastSkyWarpHolla") ~= tonumber(os.date("%j")) then -- 5% Chance chip breaks
                    player:startEvent(161) -- To Sky
                else
                    player:startEvent(170) -- Chip Breaks!
                end
            else
                player:startEvent(162) -- Please Register..
            end
        end,
        [7] = function (x)
            if player:getCharVar("DemChipRegistration") == 1 then
                if math.random(1, 100) <= 95 or player:getCharVar("LastSkyWarpDem") ~= tonumber(os.date("%j")) then -- 5% Chance chip breaks
                    player:startEvent(161) -- To Sky
                else
                    player:startEvent(171) -- Chip Breaks!
                end
            else
                player:startEvent(162) -- Please Register..
            end
        end,
    }
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 103 and option == 1 then
        player:setPos(340.082, 19.103, -59.979, 127, 102)     -- To La Theine Plateau {R}
    elseif csid == 104 and option == 1 then
        player:setPos(179.92, 35.15, 260.137, 64, 117)        -- To Tahrongi Canyon {R}
    elseif csid == 105 and option == 1 then
        player:setPos(139.974, 19.103, 219.989, 128, 108)     -- To Konschtat Highlands {R}
    elseif csid == 155 then
        player:setCharVar("cspromy3", 0)
        player:setCharVar("cslastpromy", 1)

        if not player:hasKeyItem(tpz.ki.LIGHT_OF_DEM) then
            player:setPos(185.891, 0, -52.331, 128, 18) -- To Promyvion Dem {R}
        elseif not player:hasKeyItem(tpz.ki.LIGHT_OF_HOLLA) then
            player:setPos(92.033, 0, 80.380, 255, 16) -- To Promyvion Holla {R}
        elseif not player:hasKeyItem(tpz.ki.LIGHT_OF_MEA) then
            player:setPos(-93.268, 0, 170.749, 162, 20) -- To Promyvion Mea {R}
        end
    elseif csid == 161 and option == 1 then
        local prevZone = player:getPreviousZone()

        if prevZone == tpz.zone.LA_THEINE_PLATEAU then
            player:setCharVar("LastSkyWarpHolla", tonumber(os.date("%j")))
        elseif prevZone == tpz.zone.KONSCHTAT_HIGHLANDS then
            player:setCharVar("LastSkyWarpDem", tonumber(os.date("%j")))
        elseif prevZone == tpz.zone.TAHRONGI_CANYON then
            player:setCharVar("LastSkyWarpMea", tonumber(os.date("%j")))
        end

        tpz.teleport.to(player, tpz.teleport.id.SKY)
    elseif csid == 169 and option == 1 then
        player:setCharVar("MeaChipRegistration", 0)
        tpz.teleport.to(player, tpz.teleport.id.SKY)
    elseif csid == 170 and option == 1 then
        player:setCharVar("HollaChipRegistration", 0)
        tpz.teleport.to(player, tpz.teleport.id.SKY)
    elseif csid == 171 and option == 1 then
        player:setCharVar("DemChipRegistration", 0)
        tpz.teleport.to(player, tpz.teleport.id.SKY)
    end
end
