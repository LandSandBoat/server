-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("discount_assault_gear")

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Bhoy_Yhupplo.onEventFinish", function(player, csid, option)
    if csid == 277 then
        local selectiontype = bit.band(option, 0xF)
        if selectiontype == 1 and npcUtil.giveKeyItem(player, xi.ki.ILRUSI_ASSAULT_ORDERS) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_ILRUSI_ATOLL)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(xi.assaultUtil.assaultArea.ILRUSI_ATOLL, choice.price / 2)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Isdebaaq.onEventFinish", function(player, csid, option)
    if (csid == 274) then
        local selectiontype = bit.band(option, 0xF)
        if selectiontype == 1 and npcUtil.giveKeyItem(player, xi.ki.MAMOOL_JA_ASSAULT_ORDERS) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_THE_TRAINING_GROUNDS)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(xi.assaultUtil.assaultArea.MAMOOL_JA_TRAINING_GROUNDS, choice.price / 2)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Lageegee.onEventFinish", function(player, csid, option)
    if csid == 276 then
        local selectiontype = bit.band(option, 0xF)
        if selectiontype == 1 and npcUtil.giveKeyItem(player, xi.ki.PERIQIA_ASSAULT_ORDERS) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_PERIQIA)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(xi.assaultUtil.assaultArea.PERIQIA, choice.price / 2)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Yahsra.onEventFinish", function(player, csid, option)
    if csid == 273 then
        local selectiontype = bit.band(option, 0xF)
        if selectiontype == 1 and npcUtil.giveKeyItem(player, xi.ki.LEUJAOAM_ASSAULT_ORDERS) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_LEUJAOAM_SANCTUM)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(xi.assaultUtil.assaultArea.LEUJAOAM_SANCTUM, choice.price / 2)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Famad.onEventFinish", function(player, csid, option)
    if csid == 275 then
        local selectiontype = bit.band(option, 0xF)
        if selectiontype == 1 and npcUtil.giveKeyItem(player, xi.ki.LEBROS_ASSAULT_ORDERS) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_LEBROS_CAVERN)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(xi.assaultUtil.assaultArea.LEBROS_CAVERN, choice.price / 2)
            end
        end
    end
end)

return m 