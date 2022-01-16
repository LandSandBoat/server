-----------------------------------
-- ID: 11290
-- Item: tidal talisman
--
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 56
    local zone = target:getZoneID()
    if (zone == 238 or zone == 239 or zone == 240 or zone == 241 or zone == 242 or -- Windurst
        zone == 234 or zone == 235 or zone == 236 or zone == 237 or -- Bastok
        zone == 230 or zone == 231 or zone == 232 or zone == 233 or -- San d'Oria
        ((zone == 243 or zone == 244 or zone == 245 or zone == 246) and target:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM)) or -- Jeuno
        zone == 248 or -- Selbina
        zone == 249 or -- Mhaura
        zone == 250 or -- Kazham
        zone == 50 or -- Aht Urhgan Whitegate
        zone == 53) -- Nashmau
        then result = 0
    end
    return result
end

item_object.onItemUse = function(target)
    local zone = target:getZoneID()
    local destZone
    local pos = {}

    if zone >= 230 and zone <= 242 then -- Item is used in a starter city
        destZone = 243
        pos = {0, 3, 2, 64, 243} -- Player/s will end up at Ru'Lude Gardens
    elseif zone >= 243 and zone <= 246 then -- Item is used in Jeuno
        if target:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) then
            destZone = 250
            pos = {-33, -8, -71, 97, 250} -- player/s end up in Kazham
        end
    elseif zone == 250 then -- Item is used in Kazham
        destZone = 243
        pos = {0, 3, 2, 64, 243} -- Player/s will end up at Ru'Lude Gardens
    elseif zone == 248 then -- Item is used in Selbina
        destZone = 249 -- player/s end up at Mhaura
        pos = {0, -8, 59, 62, 249} -- player/s end up at Mhaura
    elseif zone == 249 then -- Item is used in Mhaura
        destZone = 248
        pos = {18, -14, 79, 62, 248} -- player/s end up in Selbina
    elseif zone == 50 then -- Item is used in Aht Urhgan Whitegate
        destZone = 53
        pos = {12, -6, 31, 63, 53} -- player/s end up in Nashmau
    elseif zone == 53 then -- Item is used in Nashmu
        destZone = 50
        pos = {-73, 0, 0, 252, 50} -- player/s ends up at Aht Urahgan Whitegate
    end

    if target:checkDistance(target:getXPos(), target:getYPos(), target:getZPos() <= 5) and not target:isInMogHouse() then -- I am within 5 yalms, teleport me.
        if destZone == 0 or not target:isZoneVisited(destZone) then
            return
        end

        target:setPos(pos)
    else
        return -- Do not teleport me, I am too far away.
    end
end

return item_object
