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
        zone == 243 or zone == 244 or zone == 245 or zone == 246 or -- Jeuno
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

    if (zone == 241 or zone == 242 or zone == 240 or zone == 239 or zone == 238) then -- Item is used in Windurst
        target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 237 or zone == 236 or zone == 235 or zone == 234) then -- Item is used in Bastok
        target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 233 or zone == 232 or zone == 231 or zone == 230) then -- Item is used in San d'Oria
        target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 243 or zone == 245 or zone == 244 or zone == 246) then -- Item is used in Jeuno
        target:setPos(-33, -8, -71, 97, 250) -- player/s end up in Kazham
    elseif (zone == 250) then -- Item is used in Kazham
        target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 248) then -- Item is used in Selbina
        target:setPos(0, -8, 59, 62, 248) -- player/s end up at Mhaura
    elseif (zone == 249) then -- Item is used in Mhaura
        target:setPos(18, -14, 79, 62, 248) -- player/s end up in Selbina
    elseif (zone == 50) then -- Item is used in Aht Urhgan Whitegate
        target:setPos(12, -6, 31, 63, 53) -- player/s end up in Nashmau
    elseif (zone == 53) then -- Item is used in Nashmu
        target:setPos(-73, 0, 0, 252, 50) -- player/s ends up at Aht Urahgan Whitegate
    end
end

return item_object
