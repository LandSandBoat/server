-----------------------------------
-- Global file for Nyzul's Vending Box
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}
-----------------------------------
-- Event ID : 202
-- Parameter 1 : Unused. However, it seems to be some short of progresive count that gets reset randomly. Time-based.
-- Parameter 2 : Current tokens
-- Parameter 3 : Temp items currently held.
-- Parameter 4 : Preferred items.
-- Parameter 5 : Enables Low-Grade items.    Represents cost per item in category.
-- Parameter 6 : Enables Medium-Grade items. Represents cost per item in category.
-- Parameter 7 : Enables High-Grade items.   Represents cost per item in category.
-- Parameter 8 : Unused.
-----------------------------------

local itemCost =
{
    LOW_GRADE    = 100
    MEDIUM_GRADE = 200
    HIGH_GRADE   = 300
}

local itemsTable =
{
    [ 8450] = { item = 5385, cost = itemCost.LOW_GRADE,    slot = 0x02      }, -- Barbarian's Drink -+
    [ 8451] = { item = 5386, cost = itemCost.LOW_GRADE,    slot = 0x04      }, -- Fighter's Drink -+
    [ 8452] = { item = 5387, cost = itemCost.LOW_GRADE,    slot = 0x08      }, -- Oracle's Drink -+
    [ 8453] = { item = 5388, cost = itemCost.LOW_GRADE,    slot = 0x10      }, -- Assassin's Drink
    [ 8454] = { item = 5389, cost = itemCost.LOW_GRADE,    slot = 0x20      }, -- Spy's Dring -+
    [ 8455] = { item = 5394, cost = itemCost.LOW_GRADE,    slot = 0x400     }, -- Gnostic's Drink
    [ 8456] = { item = 5396, cost = itemCost.LOW_GRADE,    slot = 0x1000    }, -- Shepherd's Drink
    [ 8457] = { item = 5436, cost = itemCost.LOW_GRADE,    slot = 0x40000   }, -- Dusty Reraise -+
    [ 8458] = { item = 5437, cost = itemCost.LOW_GRADE,    slot = 0x80000   }, -- Strange Milk -+
    [ 8459] = { item = 5438, cost = itemCost.LOW_GRADE,    slot = 0x100000  }, -- Strange Juice -+
    [ 8460] = { item = 5439, cost = itemCost.LOW_GRADE,    slot = 0x200000  }, -- Viscer's Drink -+
    [ 8461] = { item = 5397, cost = itemCost.LOW_GRADE,    slot = 0x4000000 }, -- Sprinters Drink -+

    [12546] = { item = 5390, cost = itemCost.MEDIUM_GRADE, slot = 0x40      }, -- Braver's Drink -+
    [12547] = { item = 5391, cost = itemCost.MEDIUM_GRADE, slot = 0x80      }, -- Soldier's Drink -+
    [12548] = { item = 5392, cost = itemCost.MEDIUM_GRADE, slot = 0x100     }, -- Champion's Drink
    [12549] = { item = 5393, cost = itemCost.MEDIUM_GRADE, slot = 0x200     }, -- Monarch's Drink -+
    [12550] = { item = 5395, cost = itemCost.MEDIUM_GRADE, slot = 0x800     }, -- Cleric's Drink -+
    [12551] = { item = 5431, cost = itemCost.MEDIUM_GRADE, slot = 0x2000    }, -- Dusty Potion -+
    [12552] = { item = 5432, cost = itemCost.MEDIUM_GRADE, slot = 0x4000    }, -- Dusty Ether -+
    [12553] = { item = 5434, cost = itemCost.MEDIUM_GRADE, slot = 0x10000   }, -- Fanatic's Drink -+
    [12554] = { item = 5435, cost = itemCost.MEDIUM_GRADE, slot = 0x20000   }, -- Fool's Drink -+
    [12555] = { item = 5440, cost = itemCost.MEDIUM_GRADE, slot = 0x400000  }, -- Dusty Wing -+
    [12556] = { item = 4147, cost = itemCost.MEDIUM_GRADE, slot = 0x800000  }, -- Body Boost -+
    [12557] = { item = 4200, cost = itemCost.MEDIUM_GRADE, slot = 0x1000000 }, -- Mana Boost -+

    [16641] = { item = 5433, cost = itemCost.HIGH_GRADE,   slot = 0x8000    }, -- Dusty Elixer -+
}

local function buildTemporaryItemBitmask(player)
    local hasTempItem = 1 -- All players start with 1 temporary item in inventory. Can't be thrown. Uses bit 0.

    for _, itemList in pairs(itemsTable) do
        if player:hasItem(itemList.item, xi.inventoryLocation.TEMPITEMS) then
            hasTempItem = hasTempItem + itemList.slot
        end
    end

    return hasTempItem
end

local function giveAllTemporaryItems(player)
    -- TODO: Check if items are given 1 by 1 or in bulk, currency wise.

    for _, itemList in pairs(itemsTable) do
        if not player:hasItem(itemList.item, xi.inventoryLocation.TEMPITEMS) then
            if player:getCurrency("nyzul_isle_assault_point") >= itemList.cost then
                player:addTempItem(itemList.item)
                player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, itemList.item)
                player:delCurrency("nyzul_isle_assault_point", itemList.cost)
            end
        end
    end
end

local function giveAllTemporaryItemsPrefered(player)
    -- TODO: Check if items are given 1 by 1 or in bulk, currency wise.

    local preferenceBitmask = player:getCharVar("[Nyzul]preferredItems")
    local selection =
    {
        -- [bit] = option
        [ 1] = 8450,
        [ 2] = 8451,
        [ 3] = 8452,
        [ 4] = 8453,
        [ 5] = 8454,
        [ 6] = 12546,
        [ 7] = 12547,
        [ 8] = 12548,
        [ 9] = 12549,
        [10] = 8455,
        [11] = 12550,
        [12] = 8456,
        [13] = 12551,
        [14] = 12552,
        [15] = 16641,
        [16] = 12553,
        [17] = 12554,
        [18] = 8457,
        [19] = 8458,
        [20] = 8459,
        [21] = 8460,
        [22] = 12555,
        [23] = 12556,
        [24] = 12557,
        [25] = nil,
        [26] = 8461,
    }

    for bit = 1, 26 do
        if utils.mask.getBit(preferenceBitmask, bit) then
            local option = selection[bit]
            local itemId = itemsTable[option].item

            if itemSelected ~= nil then
                if not player:hasItem(itemId, xi.inventoryLocation.TEMPITEMS) then
                    player:addTempItem(itemId)
                    player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, itemId)
                    player:delCurrency("nyzul_isle_assault_point", itemsTable[option].cost)
                end
            end
        end
    end
end

xi.nyzul.vendingBoxOnTrigger = function(player)
    local playerTokens       = player:getCurrency("nyzul_isle_assault_point")
    local itemsGottenBitmask = buildTemporaryItemBitmask(player)
    local preferenceBitmask  = player:getCharVar("[Nyzul]preferredItems")

    player:startEvent(202, 0, playerTokens, itemsGottenBitmask, preferenceBitmask, itemCost.LOW_GRADE, itemCost.MEDIUM_GRADE, itemCost.HIGH_GRADE, 0)
end

xi.nyzul.vendingBoxOnEventUpdate = function(player, csid, option)
    if csid == 202 then
        -- Give all items not in possesion.
        if option == 20737 then
            giveAllTemporaryItems(player)

        -- Give all (Preferred) items not in possesion.
        elseif option == 4353 then
            giveAllTemporaryItemsPrefered(player)

        -- Give item selected.
        else
            if option >= 4354 and option <= 4365 then
                option = option + 4096
            elseif option >= 4366 and option <= 4377 then
                option = option + 8180
            elseif option == 4378 then
                option = option + 12263
            end

            local vendorItems = itemsTable[option]

            if player:getCurrency("nyzul_isle_assault_point") >= vendorItems.cost then
                player:addTempItem(vendorItems.item)
                player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, vendorItems.item)
                player:delCurrency("nyzul_isle_assault_point", vendorItems.cost)
            end
        end

        -- Update the event.
        local playerTokens       = player:getCurrency("nyzul_isle_assault_point")
        local itemsGottenBitmask = buildTemporaryItemBitmask(player)
        local preferenceBitmask  = player:getCharVar("[Nyzul]preferredItems")

        player:updateEvent(0, playerTokens, itemsGotten, preferenceBitmask, itemCost.LOW_GRADE, itemCost.MEDIUM_GRADE, itemCost.HIGH_GRADE, 0)
    end
end
