-----------------------------------
-- Era Custom Trades
-- Shared trade logic for all custom NPCs
-----------------------------------

xi = xi or {}
xi.customTrades = xi.customTrades or {}

local function matchTrade(trade, give)
    local expectedItemCount = 0
    local expectedGil       = 0

    for _, entry in ipairs(give) do
        if entry.gil then
            expectedGil       = entry.gil
            expectedItemCount = expectedItemCount + 1
        else
            if not trade:hasItemQty(entry.item, entry.qty) then
                return false
            end

            expectedItemCount = expectedItemCount + entry.qty
        end
    end

    if trade:getItemCount() ~= expectedItemCount then
        return false
    end

    if expectedGil > 0 and trade:getGil() ~= expectedGil then
        return false
    end

    return true
end

local function matchTradeSet(trade, tradeSet)
    if trade:getItemCount() ~= #tradeSet then
        return false
    end

    for _, itemId in ipairs(tradeSet) do
        if not trade:hasItemQty(itemId, 1) then
            return false
        end
    end

    return true
end

local function processTrades(player, npc, trade, trades)
    for _, entry in ipairs(trades) do
        local matched = false

        if entry.tradeSet then
            matched = matchTradeSet(trade, entry.tradeSet)
        elseif entry.give then
            matched = matchTrade(trade, entry.give)
        end

        if matched then
            if player:getFreeSlotsCount() == 0 then
                local checkItem = entry.receive and entry.receive.item or (entry.randomReceive and entry.randomReceive[1])
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, checkItem)
                return
            end

            -- randomReceive: pick a random item from the list
            if entry.randomReceive then
                local pool   = entry.randomReceive
                local itemId = pool[math.random(1, #pool)]
                player:tradeComplete(trade)
                player:addItem(itemId)
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, itemId)
                return
            end

            -- Standard receive
            player:tradeComplete(trade)
            player:addItem(entry.receive.item, entry.receive.qty)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, entry.receive.item)
            return
        end
    end
end

local function processYayaroon(player, npc, trade, items)
    local gil    = trade:getGil()
    local choice = items[gil]

    if not choice then
        return
    end

    if trade:getItemCount() ~= 1 then
        return
    end

    if player:getCurrency('imperial_standing') < choice.cost then
        player:printToPlayer('Yooo.... Yooo noooo haaaave enough poiiints.', xi.msg.channel.SAY, npc:getName())
        return
    end

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, choice.item)
        return
    end

    player:tradeComplete(trade)
    player:delCurrency('imperial_standing', choice.cost)
    player:addItem(choice.item)
    player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, choice.item)
end

local function processSealExchange(player, npc, trade, conversions)
    local zoneText        = zones[player:getZoneID()].text
    local totalOutput     = 0
    local inputQtys       = {}
    local outputItem      = conversions[1][3]
    local totalInputItems = 0

    for _, conversion in ipairs(conversions) do
        local inputItem = conversion[1]
        local inputQty  = conversion[2]
        local outputQty = conversion[4]
        local playerHas = trade:getItemQty(inputItem)
        local consumable = math.floor(playerHas / inputQty) * inputQty

        inputQtys[inputItem] = consumable
        totalOutput      = totalOutput + (math.floor(playerHas / inputQty) * outputQty)
        totalInputItems  = totalInputItems + playerHas
    end

    if totalOutput == 0 then
        return
    end

    if trade:getItemCount() > totalInputItems then
        player:messageSpecial(zoneText.COULD_NOT_ACCEPT_TRADE)
        return
    end

    local fullStacks  = math.floor(totalOutput / 99)
    local lastStack   = totalOutput % 99
    local slotsNeeded = fullStacks + (lastStack > 0 and 1 or 0)

    if player:getFreeSlotsCount() < slotsNeeded then
        player:messageSpecial(zoneText.ITEM_CANNOT_BE_OBTAINED, outputItem)
        return
    end

    local tradeValidation = {}
    for inputItem, qty in pairs(inputQtys) do
        if qty > 0 then
            table.insert(tradeValidation, { inputItem, qty })
        end
    end

    if not npcUtil.tradeHas(trade, tradeValidation) then
        return
    end

    player:confirmTrade()

    for _ = 1, fullStacks do
        player:addItem(outputItem, 99)
    end

    if lastStack > 0 then
        player:addItem(outputItem, lastStack)
    end

    player:messageSpecial(zoneText.ITEM_OBTAINED, outputItem)
end

-- Adelfete - Lower Jeuno
xi.customTrades.adelfete = function(player, npc, trade)
    processTrades(player, npc, trade, {
        -- Egg downgrades
        { give = { { item = xi.item.C_EGG, qty = 1 } },                               receive = { item = xi.item.B_EGG, qty = 6  } },
        { give = { { item = xi.item.B_EGG, qty = 1 } },                               receive = { item = xi.item.A_EGG, qty = 12 } },

        -- HQ Crystal selection via gil amount
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 1 } },                  receive = { item = xi.item.INFERNO_CRYSTAL,  qty = 12 } },
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 2 } },                  receive = { item = xi.item.GLACIER_CRYSTAL,  qty = 12 } },
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 3 } },                  receive = { item = xi.item.CYCLONE_CRYSTAL,  qty = 12 } },
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 4 } },                  receive = { item = xi.item.TERRA_CRYSTAL,    qty = 12 } },
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 5 } },                  receive = { item = xi.item.PLASMA_CRYSTAL,   qty = 12 } },
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 6 } },                  receive = { item = xi.item.TORRENT_CRYSTAL,  qty = 12 } },
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 7 } },                  receive = { item = xi.item.AURORA_CRYSTAL,   qty = 12 } },
        { give = { { item = xi.item.A_EGG, qty = 1 }, { gil = 8 } },                  receive = { item = xi.item.TWILIGHT_CRYSTAL, qty = 12 } },
    })
end

-- Survival Guide - Ru'Lude Gardens
xi.customTrades.survivalGuide = function(player, npc, trade)
    processTrades(player, npc, trade, {
        { give = { { item = xi.item.CAVERS_SHOVEL, qty = 1 } }, randomReceive = {
            xi.item.SPRINGSTONE,
            xi.item.SUMMERSTONE,
            xi.item.AUTUMNSTONE,
            xi.item.WINTERSTONE,
            xi.item.GEM_OF_THE_WEST,
            xi.item.GEM_OF_THE_EAST,
            xi.item.GEM_OF_THE_NORTH,
            xi.item.GEM_OF_THE_SOUTH,
        } },

        -- God Seal + Mangled Cockatrice Skin
        { give = { { item = xi.item.SEAL_OF_SEIRYU, qty = 1 }, { item = xi.item.MANGLED_COCKATRICE_SKIN, qty = 1 } }, receive = { item = xi.item.HECATES_CAPE,      qty = 1 } },
        { give = { { item = xi.item.SEAL_OF_BYAKKO, qty = 1 }, { item = xi.item.MANGLED_COCKATRICE_SKIN, qty = 1 } }, receive = { item = xi.item.CUCHULAINS_MANTLE, qty = 1 } },
    })
end

-- Anteurephiaux - Tavnazian Safehold
xi.customTrades.anteurephiaux = function(player, npc, trade)
    processTrades(player, npc, trade, {
        -- All 8 elemental obis -> Hachirin-no-obi
        { tradeSet = {
            xi.item.KORIN_OBI,
            xi.item.ANRIN_OBI,
            xi.item.KARIN_OBI,
            xi.item.HYORIN_OBI,
            xi.item.FURIN_OBI,
            xi.item.DORIN_OBI,
            xi.item.RAIRIN_OBI,
            xi.item.SUIRIN_OBI,
        }, receive = { item = xi.item.HACHIRIN_NO_OBI, qty = 1 } },

        -- All 8 elemental gorgets -> Fotia Gorget
        { tradeSet = {
            xi.item.FLAME_GORGET,
            xi.item.SNOW_GORGET,
            xi.item.BREEZE_GORGET,
            xi.item.SOIL_GORGET,
            xi.item.THUNDER_GORGET,
            xi.item.AQUA_GORGET,
            xi.item.LIGHT_GORGET,
            xi.item.SHADOW_GORGET,
        }, receive = { item = xi.item.FOTIA_GORGET, qty = 1 } },
    })
end

-- Momiji - Lower Jeuno
xi.customTrades.momiji = function(player, npc, trade)
    processTrades(player, npc, trade, {
        -- All 8 crafting rings -> Artificer's Ring
        { tradeSet = {
            xi.item.CARPENTERS_RING,
            xi.item.SMITHS_RING,
            xi.item.GOLDSMITHS_RING,
            xi.item.TAILORS_RING,
            xi.item.TANNERS_RING,
            xi.item.BONECRAFTERS_RING,
            xi.item.ALCHEMISTS_RING,
            xi.item.CHEFS_RING,
        }, receive = { item = xi.item.ARTIFICERS_RING, qty = 1 } },
    })
end

-- Yayaroon - Al Zahbi - WE NEED TO ADJUST SOME OF THESE PRICES AND REMOVE SOME OF THE ITEMS.
xi.customTrades.yayaroon = function(player, npc, trade)
    processYayaroon(player, npc, trade, {
        -- Private
        [1]  = { item = xi.item.SENTINEL_SHIELD,        cost =  30000 },
        [2]  = { item = xi.item.SNEAKING_BOOTS,         cost =  30000 },
        [3]  = { item = xi.item.TROOPERS_RING,          cost =  30000 },
        -- Private First Class
        [4]  = { item = xi.item.SHARK_GUN,              cost =  60000 },
        [5]  = { item = xi.item.PUPPET_CLAWS,           cost =  60000 },
        [6]  = { item = xi.item.SINGH_KILIJ,            cost =  60000 },
        -- Sergeant
        [7]  = { item = xi.item.MERCENARYS_TROUSERS,    cost =  90000 },
        [8]  = { item = xi.item.MULTIPLE_RING,          cost =  90000 },
        [9]  = { item = xi.item.HATEN_EARRING,          cost =  90000 },
        -- Sergeant Major
        [10] = { item = xi.item.VOLUNTEERS_BRAIS,       cost = 120000 },
        [11] = { item = xi.item.PRIESTS_EARRING,        cost = 120000 },
        [12] = { item = xi.item.CHAOTIC_EARRING,        cost = 120000 },
        -- Chief Sergeant
        [13] = { item = xi.item.PERDU_BOW,              cost = 150000 },
        [14] = { item = xi.item.PERDU_HANGER,           cost = 150000 },
        [15] = { item = xi.item.PERDU_SICKLE,           cost = 150000 },
        [16] = { item = xi.item.PERDU_WAND,             cost = 150000 },
        -- Second Lieutenant
        [17] = { item = xi.item.PERDU_BLADE,            cost = 165000 },
        [18] = { item = xi.item.PERDU_CROSSBOW,         cost = 165000 },
        [19] = { item = xi.item.PERDU_STAFF,            cost = 165000 },
        [20] = { item = xi.item.PERDU_SWORD,            cost = 165000 },
        [21] = { item = xi.item.PERDU_VOULGE,           cost = 165000 },
        -- First Lieutenant
        [22] = { item = xi.item.LIEUTENANTS_CAPE,       cost = 210000 },
        [23] = { item = xi.item.LIEUTENANTS_SASH,       cost = 210000 },
        [24] = { item = xi.item.LIEUTENANTS_GORGET,     cost = 210000 },
        -- ISNM items
        [25] = { item = xi.item.KOGA_SHURIKEN,          cost =  37500 },
        [26] = { item = xi.item.BUSKERS_CAPE,           cost =  37500 },
        [27] = { item = xi.item.IMMORTALS_EARRING,      cost =  37500 },
        [28] = { item = xi.item.BUSKERS_EARRING,        cost =  37500 },
        [29] = { item = xi.item.PIRATES_CAPE,           cost =  37500 },
        [30] = { item = xi.item.BARBAROSSAS_MOUFLES,    cost = 150000 },
        [31] = { item = xi.item.TEMPLAR_SABATONS,       cost = 150000 },
        [32] = { item = xi.item.DOMINION_RING,          cost = 150000 },
        [33] = { item = xi.item.STRIKE_SUBLIGAR,        cost = 150000 },
        [34] = { item = xi.item.IMMORTALS_CAPE,         cost = 150000 },
        [35] = { item = xi.item.DEADEYE_GLOVES,         cost = 150000 },
        [36] = { item = xi.item.LEECH_SCIMITAR,         cost = 150000 },
        [37] = { item = xi.item.PIRATES_EARRING,        cost = 150000 },
        [38] = { item = xi.item.BITTER_CORSET,          cost = 150000 },
        [39] = { item = xi.item.REQUIEM_FLUTE,          cost = 150000 },
        [40] = { item = xi.item.KAWAHORI_KABUTO,        cost = 150000 },
        [41] = { item = xi.item.ARAKAN_SAMUE,           cost = 150000 },
        [42] = { item = xi.item.CRUDE_SWORD,            cost = 150000 },
        [43] = { item = xi.item.MENSUR_EPEE,            cost = 150000 },
        [44] = { item = xi.item.WARDANCER,              cost = 150000 },
        [45] = { item = xi.item.COMPANY_FLEURET,        cost = 150000 },
        [46] = { item = xi.item.MAGNET_KNIFE,           cost = 150000 },
        [47] = { item = xi.item.SACRIFICE_TORQUE,       cost = 150000 },
        [48] = { item = xi.item.TOURNAMENT_LANCE,       cost = 150000 },
        [49] = { item = xi.item.MEGRIM_CROWN,           cost = 150000 },
        [50] = { item = xi.item.GOBNIUS_RING,           cost = 200000 },
    })
end

-- Jaha Amariyo - Port Jeuno
xi.customTrades.jahaAmariyo = function(player, npc, trade)
    processSealExchange(player, npc, trade, {
        { xi.item.BEASTMENS_SEAL,      3, xi.item.KINDREDS_SEAL, 1 },
        { xi.item.KINDREDS_CREST,      1, xi.item.KINDREDS_SEAL, 3 },
        { xi.item.HIGH_KINDREDS_CREST, 1, xi.item.KINDREDS_SEAL, 9 },
    })
end

-- Karl - Port Jeuno
xi.customTrades.karl = function(player, npc, trade)
    processSealExchange(player, npc, trade, {
        { xi.item.KINDREDS_SEAL,       1, xi.item.BEASTMENS_SEAL, 3  },
        { xi.item.KINDREDS_CREST,      1, xi.item.BEASTMENS_SEAL, 9  },
        { xi.item.HIGH_KINDREDS_CREST, 1, xi.item.BEASTMENS_SEAL, 27 },
    })
end

-- Buntz - Port Jeuno
xi.customTrades.buntz = function(player, npc, trade)
    processSealExchange(player, npc, trade, {
        { xi.item.BEASTMENS_SEAL,      9, xi.item.KINDREDS_CREST, 1 },
        { xi.item.KINDREDS_SEAL,       3, xi.item.KINDREDS_CREST, 1 },
        { xi.item.HIGH_KINDREDS_CREST, 1, xi.item.KINDREDS_CREST, 3 },
    })
end

return xi.customTrades
