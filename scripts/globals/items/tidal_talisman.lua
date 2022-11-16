-----------------------------------
-- ID: 11290
-- Item: tidal talisman
-----------------------------------
require('scripts/globals/zone')
-----------------------------------
local itemObject = {}

local teleportData =
{
    [xi.zone.CHATEAU_DORAGUILLE]   = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.NORTHERN_SAN_DORIA]   = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.SOUTHERN_SAN_DORIA]   = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.PORT_SAN_DORIA]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.BASTOK_MARKETS]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.BASTOK_MINES]         = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.METALWORKS]           = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.PORT_BASTOK]          = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.PORT_WINDURST]        = {   0,   3,   2 , 64, xi.zone.RULUDE_GARDENS },
    [xi.zone.WINDURST_WALLS]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.WINDURST_WATERS]      = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.WINDURST_WOODS]       = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.KAZHAM]               = {   0,   3,   2,  64, xi.zone.RULUDE_GARDENS },
    [xi.zone.LOWER_JEUNO]          = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.PORT_JEUNO]           = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.UPPER_JEUNO]          = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.RULUDE_GARDENS]       = { -33,  -8, -71,  97, xi.zone.KAZHAM },
    [xi.zone.MHAURA]               = {  18, -14,  79,  62, xi.zone.SELBINA },
    [xi.zone.SELBINA]              = {   0,  -8,  59,  62, xi.zone.MHAURA },
    [xi.zone.AHT_URHGAN_WHITEGATE] = {  12,  -6,  31,  63, xi.zone.NASHMAU },
    [xi.zone.NASHMAU]              = { -73,   0,   0, 252, xi.zone.AHT_URHGAN_WHITEGATE },
}

itemObject.onItemCheck = function(target)
    local zoneId = target:getZoneID()

    if
        teleportData[zoneId] and
        target:hasVisitedZone(teleportData[zoneId][5])
    then
        return 0
    end

    return 56
end

itemObject.onItemUse = function(target)
    local zone = target:getZoneID()
    local destZone
    local pos = { }

    if zone >= 230 and zone <= 242 then -- Item is used in a starter city
        destZone = 243
        pos = { 0, 3, 2, 64, 243 } -- Player/s will end up at Ru'Lude Gardens
    elseif zone >= 243 and zone <= 246 then -- Item is used in Jeuno
        if target:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) then
            destZone = 250
            pos = { -33, -8, -71, 97, 250 } -- player/s end up in Kazham
        end
    elseif zone == 250 then -- Item is used in Kazham
        destZone = 243
        pos = { 0, 3, 2, 64, 243 } -- Player/s will end up at Ru'Lude Gardens
    elseif zone == 248 then -- Item is used in Selbina
        destZone = 249 -- player/s end up at Mhaura
        pos = { 0, -8, 59, 62, 249 } -- player/s end up at Mhaura
    elseif zone == 249 then -- Item is used in Mhaura
        destZone = 248
        pos = { 18, -14, 79, 62, 248 } -- player/s end up in Selbina
    elseif zone == 50 then -- Item is used in Aht Urhgan Whitegate
        destZone = 53
        pos = { 12, -6, 31, 63, 53 } -- player/s end up in Nashmau
    elseif zone == 53 then -- Item is used in Nashmu
        destZone = 50
        pos = { -73, 0, 0, 252, 50 } -- player/s ends up at Aht Urahgan Whitegate
    end

    if target:checkDistance(target:getXPos(), target:getYPos(), target:getZPos() <= 5) and not target:isInMogHouse() then -- I am within 5 yalms, teleport me.
        if destZone == 0 or not target:hasVisitedZone(destZone) then
            return
        end

        target:setPos(pos)
    else
        return -- Do not teleport me, I am too far away.
    end
end

return itemObject
