-----------------------------------
-- ID: 11290
-- Item: tidal talisman
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
    target:setPos(unpack(teleportData[target:getZoneID()]))
end

return itemObject
