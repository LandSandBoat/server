-----------------------------------
-- Global file for Nyzul's Vending Box
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
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
    LOW_GRADE    = 100,
    MEDIUM_GRADE = 200,
    HIGH_GRADE   = 300,
}

local itemsTable =
{
    [ 8450] = { item = xi.item.BOTTLE_OF_BARBARIANS_DRINK, cost = itemCost.LOW_GRADE,    slot = 0x02      },
    [ 8451] = { item = xi.item.BOTTLE_OF_FIGHTERS_DRINK,   cost = itemCost.LOW_GRADE,    slot = 0x04      },
    [ 8452] = { item = xi.item.BOTTLE_OF_ORACLES_DRINK,    cost = itemCost.LOW_GRADE,    slot = 0x08      },
    [ 8453] = { item = xi.item.BOTTLE_OF_ASSASSINS_DRINK,  cost = itemCost.LOW_GRADE,    slot = 0x10      },
    [ 8454] = { item = xi.item.BOTTLE_OF_SPYS_DRINK,       cost = itemCost.LOW_GRADE,    slot = 0x20      },
    [ 8455] = { item = xi.item.BOTTLE_OF_GNOSTICS_DRINK,   cost = itemCost.LOW_GRADE,    slot = 0x400     },
    [ 8456] = { item = xi.item.BOTTLE_OF_SPRINTERS_DRINK,  cost = itemCost.LOW_GRADE,    slot = 0x1000    },
    [ 8457] = { item = xi.item.DUSTY_SCROLL_OF_RERAISE,    cost = itemCost.LOW_GRADE,    slot = 0x40000   },
    [ 8458] = { item = xi.item.FLASK_OF_STRANGE_MILK,      cost = itemCost.LOW_GRADE,    slot = 0x80000   },
    [ 8459] = { item = xi.item.BOTTLE_OF_STRANGE_JUICE,    cost = itemCost.LOW_GRADE,    slot = 0x100000  },
    [ 8460] = { item = xi.item.BOTTLE_OF_VICARS_DRINK,     cost = itemCost.LOW_GRADE,    slot = 0x200000  },
    [ 8461] = { item = xi.item.BOTTLE_OF_SPRINTERS_DRINK,  cost = itemCost.LOW_GRADE,    slot = 0x4000000 },

    [12546] = { item = xi.item.BOTTLE_OF_BRAVERS_DRINK,    cost = itemCost.MEDIUM_GRADE, slot = 0x40      },
    [12547] = { item = xi.item.BOTTLE_OF_SOLDIERS_DRINK,   cost = itemCost.MEDIUM_GRADE, slot = 0x80      },
    [12548] = { item = xi.item.BOTTLE_OF_CHAMPIONS_DRINK,  cost = itemCost.MEDIUM_GRADE, slot = 0x100     },
    [12549] = { item = xi.item.BOTTLE_OF_MONARCHS_DRINK,   cost = itemCost.MEDIUM_GRADE, slot = 0x200     },
    [12550] = { item = xi.item.BOTTLE_OF_CLERICS_DRINK,    cost = itemCost.MEDIUM_GRADE, slot = 0x800     },
    [12551] = { item = xi.item.DUSTY_POTION,               cost = itemCost.MEDIUM_GRADE, slot = 0x2000    },
    [12552] = { item = xi.item.DUSTY_ETHER,                cost = itemCost.MEDIUM_GRADE, slot = 0x4000    },
    [12553] = { item = xi.item.BOTTLE_OF_FANATICS_DRINK,   cost = itemCost.MEDIUM_GRADE, slot = 0x10000   },
    [12554] = { item = xi.item.BOTTLE_OF_FOOLS_DRINK,      cost = itemCost.MEDIUM_GRADE, slot = 0x20000   },
    [12555] = { item = xi.item.DUSTY_WING,                 cost = itemCost.MEDIUM_GRADE, slot = 0x400000  },
    [12556] = { item = xi.item.BOTTLE_OF_BODY_BOOST,       cost = itemCost.MEDIUM_GRADE, slot = 0x800000  },
    [12557] = { item = xi.item.BOTTLE_OF_MANA_BOOST,       cost = itemCost.MEDIUM_GRADE, slot = 0x1000000 },

    [16641] = { item = xi.item.DUSTY_ELIXIR,               cost = itemCost.HIGH_GRADE,   slot = 0x8000    },
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
            if player:getCurrency('nyzul_isle_assault_point') >= itemList.cost then
                player:addTempItem(itemList.item)
                player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, itemList.item)
                player:delCurrency('nyzul_isle_assault_point', itemList.cost)
            end
        end
    end
end

local function giveAllTemporaryItemsPrefered(player)
    -- TODO: Check if items are given 1 by 1 or in bulk, currency wise.

    local preferenceBitmask = player:getCharVar('[Nyzul]preferredItems')
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

            if itemId ~= nil then
                if not player:hasItem(itemId, xi.inventoryLocation.TEMPITEMS) then
                    player:addTempItem(itemId)
                    player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, itemId)
                    player:delCurrency('nyzul_isle_assault_point', itemsTable[option].cost)
                end
            end
        end
    end
end

xi.nyzul.vendingBoxOnTrigger = function(player)
    local playerTokens       = player:getCurrency('nyzul_isle_assault_point')
    local itemsGottenBitmask = buildTemporaryItemBitmask(player)
    local preferenceBitmask  = player:getCharVar('[Nyzul]preferredItems')

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

            if player:getCurrency('nyzul_isle_assault_point') >= vendorItems.cost then
                player:addTempItem(vendorItems.item)
                player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, vendorItems.item)
                player:delCurrency('nyzul_isle_assault_point', vendorItems.cost)
            end
        end

        -- Update the event.
        local playerTokens       = player:getCurrency('nyzul_isle_assault_point')
        local itemsGottenBitmask = buildTemporaryItemBitmask(player)
        local preferenceBitmask  = player:getCharVar('[Nyzul]preferredItems')

        player:updateEvent(0, playerTokens, itemsGottenBitmask, preferenceBitmask, itemCost.LOW_GRADE, itemCost.MEDIUM_GRADE, itemCost.HIGH_GRADE, 0)
    end
end
