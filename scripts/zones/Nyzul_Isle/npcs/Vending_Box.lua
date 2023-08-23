-----------------------------------
-- Area:  Nyzul_Isle
-- NPC:   Vending Box
-- Notes: Pick Temp items for assault
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/keyitems")
require("scripts/zones/Nyzul_Isle/IDs")
-----------------------------------
local entity = {}

local items =
{
    [8450]  = { item = 5385, cost = 100, slot = 0x02      }, -- Barbarian's Drink -+
    [8451]  = { item = 5386, cost = 100, slot = 0x04      }, -- Fighter's Drink -+
    [8452]  = { item = 5387, cost = 100, slot = 0x08      }, -- Oracle's Drink -+
    [8453]  = { item = 5388, cost = 100, slot = 0x10      }, -- Assassin's Drink
    [8454]  = { item = 5389, cost = 100, slot = 0x20      }, -- Spy's Dring -+
    [8455]  = { item = 5394, cost = 100, slot = 0x400     }, -- Gnostic's Drink
    [8456]  = { item = 5396, cost = 100, slot = 0x1000    }, -- Shepherd's Drink
    [8457]  = { item = 5436, cost = 100, slot = 0x40000   }, -- Dusty Reraise -+
    [8458]  = { item = 5437, cost = 100, slot = 0x80000   }, -- Strange Milk -+
    [8459]  = { item = 5438, cost = 100, slot = 0x100000  }, -- Strange Juice -+
    [8460]  = { item = 5439, cost = 100, slot = 0x200000  }, -- Viscer's Drink -+
    [8461]  = { item = 5397, cost = 100, slot = 0x4000000 }, -- Sprinters Drink -+

    [12546] = { item = 5390, cost = 200, slot = 0x40      }, -- Braver's Drink -+
    [12547] = { item = 5391, cost = 200, slot = 0x80      }, -- Soldier's Drink -+
    [12548] = { item = 5392, cost = 200, slot = 0x100     }, -- Champion's Drink
    [12549] = { item = 5393, cost = 200, slot = 0x200     }, -- Monarch's Drink -+
    [12550] = { item = 5395, cost = 200, slot = 0x800     }, -- Cleric's Drink -+
    [12551] = { item = 5431, cost = 200, slot = 0x2000    }, -- Dusty Potion -+
    [12552] = { item = 5432, cost = 200, slot = 0x4000    }, -- Dusty Ether -+
    [12553] = { item = 5434, cost = 200, slot = 0x10000   }, -- Fanatic's Drink -+
    [12554] = { item = 5435, cost = 200, slot = 0x20000   }, -- Fool's Drink -+
    [12555] = { item = 5440, cost = 200, slot = 0x400000  }, -- Dusty Wing -+
    [12556] = { item = 4147, cost = 200, slot = 0x800000  }, -- Body Boost -+
    [12557] = { item = 4200, cost = 200, slot = 0x1000000 }, -- Mana Boost -+

    [16641] = { item = 5433, cost = 300, slot = 0x8000    }, -- Dusty Elixer -+
}

local function playerHasTempItem(player)
    local hasTempItem = 0

    for _, itemList in pairs(items) do
        if player:hasItem(itemList.item, xi.inventoryLocation.TEMPITEMS) then
            hasTempItem = hasTempItem + itemList.slot
        end
    end

    return hasTempItem + 1
end

local function giveAllItems(player)
    for _, itemList in pairs(items) do
        if not player:hasItem(itemList.item, xi.inventoryLocation.TEMPITEMS) then
            if player:getCurrency("nyzul_isle_assault_point") >= itemList.cost then
                player:addTempItem(itemList.item)
                player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, itemList.item)
                player:delCurrency("nyzul_isle_assault_point", itemList.cost)
            end
        end
    end
end

local function giveAllPrefered(player)
    local preferred = player:getVar("[Nyzul]preferredItems")
    local selection =
    {
        [1]  = 8450,
        [2]  = 8451,
        [3]  = 8452,
        [4]  = 8453,
        [5]  = 8454,
        [6]  = 12546,
        [7]  = 12547,
        [8]  = 12548,
        [9]  = 12549,
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

    for section = 1, 26 do
        if utils.mask.getBit(preferred, section) then
            local mask   = selection[section]
            local choice = items[mask].item

            if choice ~= nil then
                if not player:hasItem(choice, xi.inventoryLocation.TEMPITEMS) then
                    player:addTempItem(choice)
                    player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, choice)
                    player:delCurrency("nyzul_isle_assault_point", items[mask].cost)
                end
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local preferred = player:getVar("[Nyzul]preferredItems")
    local tokens    = player:getCurrency("nyzul_isle_assault_point")

    player:startEvent(202, 1, tokens, playerHasTempItem(player), preferred, 100, 200, 300)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 202 then
        if option == 20737 then
            giveAllItems(player)
        elseif option == 4353 then
            giveAllPrefered(player)
        else
            if option >= 4354 and option <= 4365 then
                option = option + 4096
            elseif option >= 4366 and option <= 4377 then
                option = option + 8180
            elseif option == 4378 then
                option = option + 12263
            end

            local vendorItems = items[option]

            if player:getCurrency("nyzul_isle_assault_point") >= vendorItems.cost then
                player:addTempItem(vendorItems.item)
                player:messageSpecial(ID.text.TEMP_ITEM_OBTAINED, vendorItems.item)
                player:delCurrency("nyzul_isle_assault_point", vendorItems.cost)
            end
        end

        local tokens = player:getCurrency("nyzul_isle_assault_point")
        player:updateEvent(1, tokens, playerHasTempItem(player), player:getVar("[Nyzul]preferredItems"), 100, 200, 300)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
