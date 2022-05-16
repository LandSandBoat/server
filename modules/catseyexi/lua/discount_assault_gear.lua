-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("discount_assault_gear")

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Bhoy_Yhupplo.onEventFinish", function(player, csid, option)
    local items =
    {
                    [1]  = {itemid = xi.items.VELOCITY_EARRING,   price = 1500},
                    [2]  = {itemid = xi.items.GARRULOUS_RING,     price = 2500},
                    [3]  = {itemid = xi.items.GRANDIOSE_CHAIN,    price = 4000},
                    [4]  = {itemid = xi.items.HURLING_BELT,       price = 5000},
                    [5]  = {itemid = xi.items.INVIGORATING_CAPE,  price = 5000},
                    [6]  = {itemid = xi.items.IMPERIAL_KAMAN,     price = 7500},
                    [7]  = {itemid = xi.items.STORM_ZAGHNAL,      price = 7500},
                    [8]  = {itemid = xi.items.STORM_FIFE,         price = 7500},
                    [9]  = {itemid = xi.items.YIGIT_TURBAN,       price = 10000},
                    [10] = {itemid = xi.items.AMIR_DIRS,          price = 10000},
                    [11] = {itemid = xi.items.PAHLUWAN_KHAZAGAND, price = 10000},
    }

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
                player:delAssaultPoint(xi.assaultUtil.assaultArea.ILRUSI_ATOLL, choice.price)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Isdebaaq.onEventFinish", function(player, csid, option)
    local items =
    {
                    [1]  = {itemid = xi.items.ANTIVENOM_EARRING,  price = 1500},
                    [2]  = {itemid = xi.items.EBULLIENT_RING,     price = 2500},
                    [3]  = {itemid = xi.items.ENLIGHTENED_CHAIN,  price = 4000},
                    [4]  = {itemid = xi.items.SPECTRAL_BELT,      price = 5000},
                    [5]  = {itemid = xi.items.BULLSEYE_CAPE,      price = 5000},
                    [6]  = {itemid = xi.items.STORM_TULWAR,       price = 7500},
                    [7]  = {itemid = xi.items.IMPERIAL_NEZA,      price = 7500},
                    [8]  = {itemid = xi.items.STORM_TABAR,        price = 7500},
                    [9]  = {itemid = xi.items.YIGIT_GAGES,        price = 10000},
                    [10] = {itemid = xi.items.AMIR_BOOTS,         price = 10000},
                    [11] = {itemid = xi.items.PAHLUWAN_SERAWEELS, price = 10000},
    }

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
                player:delAssaultPoint(xi.assaultUtil.assaultArea.MAMOOL_JA_TRAINING_GROUNDS, choice.price)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Lageegee.onEventFinish", function(player, csid, option)
    local items =
    {
                    [1]  = {itemid = xi.items.VISION_EARRING,    price = 1500},
                    [2]  = {itemid = xi.items.UNYIELDING_RING,   price = 2500},
                    [3]  = {itemid = xi.items.FORTIFIED_CHAIN,   price = 4000},
                    [4]  = {itemid = xi.items.RESOLUTE_BELT,     price = 5000},
                    [5]  = {itemid = xi.items.BUSHIDO_CAPE,      price = 5000},
                    [6]  = {itemid = xi.items.KHANJAR,           price = 7500},
                    [7]  = {itemid = xi.items.HOTARUMARU,        price = 7500},
                    [8]  = {itemid = xi.items.IMPERIAL_GUN,      price = 7500},
                    [9]  = {itemid = xi.items.AMIR_PUGGAREE,     price = 10000},
                    [10] = {itemid = xi.items.PAHLUWAN_CRACKOWS, price = 10000},
                    [11] = {itemid = xi.items.YIGIT_GOMLEK,      price = 10000},
    }

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
                player:delAssaultPoint(xi.assaultUtil.assaultArea.PERIQIA, choice.price)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Yahsra.onEventFinish", function(player, csid, option)
    local items =
    {
                    [1]  = {itemid = xi.items.STOIC_EARRING,      price = 1500},
                    [2]  = {itemid = xi.items.UNFETTERED_RING,    price = 2500},
                    [3]  = {itemid = xi.items.TEMPERED_CHAIN,     price = 4000},
                    [4]  = {itemid = xi.items.POTENT_BELT,        price = 5000},
                    [5]  = {itemid = xi.items.MIRACULOUS_CAPE,    price = 5000},
                    [6]  = {itemid = xi.items.YIGIT_BULAWA,       price = 5000},
                    [7]  = {itemid = xi.items.IMPERIAL_BHUJ,      price = 7500},
                    [8]  = {itemid = xi.items.PAHLUWAN_PATAS,     price = 7500},
                    [9]  = {itemid = xi.items.AMIR_KOLLUKS,       price = 10000},
                    [10] = {itemid = xi.items.PAHLUWAN_QALANSUWA, price = 10000},
                    [11] = {itemid = xi.items.YIGIT_SERAWEELS,    price = 10000},
    }

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
                player:delAssaultPoint(xi.assaultUtil.assaultArea.LEUJAOAM_SANCTUM, choice.price)
            end
        end
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Famad.onEventFinish", function(player, csid, option)
    local items =
    {
                    [1]  = {itemid = xi.items.INSOMNIA_EARRING,  price = 1500},
                    [2]  = {itemid = xi.items.HALE_RING,         price = 2500},
                    [3]  = {itemid = xi.items.CHIVALROUS_CHAIN,  price = 4000},
                    [4]  = {itemid = xi.items.PRECISE_BELT,      price = 5000},
                    [5]  = {itemid = xi.items.INTENSIFYING_CAPE, price = 5000},
                    [6]  = {itemid = xi.items.IMPERIAL_POLE,     price = 7500},
                    [7]  = {itemid = xi.items.DOOMBRINGER,       price = 7500},
                    [8]  = {itemid = xi.items.SAYOSAMONJI,       price = 7500},
                    [9]  = {itemid = xi.items.PAHLUWAN_DASTANAS, price = 10000},
                    [10] = {itemid = xi.items.YIGIT_CRACKOWS,    price = 10000},
                    [11] = {itemid = xi.items.AMIR_KORAZIN,      price = 10000},
    }

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
                player:delAssaultPoint(xi.assaultUtil.assaultArea.LEBROS_CAVERN, choice.price)
            end
        end
    end
end)

return m 