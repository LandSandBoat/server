local amk = {}

-- AMK06 and AMK07 - Select/lookup the digging zone
amk.getDiggingZone = function(player)
    local diggingZone = player:getCharVar("AMK6_DIGGING_ZONE")
    if diggingZone == 0 then
        -- 1 = Valkurm Dunes
        -- 2 = Jugner Forest
        -- 3 = Knoschtat Highlands
        -- 4 = Pashhow Marshlands
        -- 5 = Tahrongi Canyon
        -- 6 = Buburimu Peninsula
        -- 7 = Meriphataud Mountains
        -- 8 = The Sanctuary of Zi'tah
        -- 9 = Yuhtunga Jungle
        -- 10 = Yhoator_Jungle
        -- 11 = Western Altepa Desert
        -- 12 = Eastern Altepa Desert
        diggingZone = math.random(1, 12)
        player:setCharVar("AMK6_DIGGING_ZONE", diggingZone)
    end
    return diggingZone
end

amk.randomlyPlaceDiggingLocation = function(player)
end

amk.chocoboDig = function(zoneID, ID)
    -- 0: East
    -- 1: SouthEast
    -- 2: South
    -- 3: SouthWest
    -- 4: West
    -- 5: NorthWest
    -- 6: North
    -- 7: NorthEast
    return false
end

return amk
