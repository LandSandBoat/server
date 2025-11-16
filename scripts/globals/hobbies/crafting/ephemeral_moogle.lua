-----------------------------------
-- Global functionality for Ephemeral Moogles.
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.crafting = xi.crafting or {}

-- Event ID each moogle uses. TODO: Mog Garden moogle.
local moogleEventTable =
{
    ['Ephemeral_Moogle_Wood'   ] = { trigger =  913, trade =  915, fail =  917 }, -- Northern San d'Oria
    ['Ephemeral_Moogle_Smith'  ] = { trigger =  914, trade =  916, fail =  918 }, -- Northern San d'Oria
    ['Ephemeral_Moogle_Gold'   ] = { trigger =  617, trade =  618, fail =  619 }, -- Bastok Markets
    ['Ephemeral_Moogle_Cloth'  ] = { trigger =  896, trade =  898, fail =  900 }, -- Windurst Woods
    ['Ephemeral_Moogle_Leather'] = { trigger = 3549, trade = 3550, fail = 3551 }, -- Southern San d'Oria
    ['Ephemeral_Moogle_Bone'   ] = { trigger =  895, trade =  897, fail =  899 }, -- Windurst Woods
    ['Ephemeral_Moogle_Alchemy'] = { trigger =  617, trade =  618, fail =  619 }, -- Bastok Mines
    ['Ephemeral_Moogle_Cook'   ] = { trigger = 1098, trade = 1099, fail = 1100 }, -- Windurst Waters
    ['Ephemeral_Moogle_Garden' ] = { trigger =    0, trade =    0, fail =    0 }, -- Mog Garden
}

-- Information for crystal item IDs and currency.
local crystalTable =
{
    [xi.element.FIRE   ] = { crystal = xi.item.FIRE_CRYSTAL,      cluster = xi.item.FIRE_CLUSTER,      currency = 'fire_crystals'      },
    [xi.element.ICE    ] = { crystal = xi.item.ICE_CRYSTAL,       cluster = xi.item.ICE_CLUSTER,       currency = 'ice_crystals'       },
    [xi.element.WIND   ] = { crystal = xi.item.WIND_CRYSTAL,      cluster = xi.item.WIND_CLUSTER,      currency = 'wind_crystals'      },
    [xi.element.EARTH  ] = { crystal = xi.item.EARTH_CRYSTAL,     cluster = xi.item.EARTH_CLUSTER,     currency = 'earth_crystals'     },
    [xi.element.THUNDER] = { crystal = xi.item.LIGHTNING_CRYSTAL, cluster = xi.item.LIGHTNING_CLUSTER, currency = 'lightning_crystals' },
    [xi.element.WATER  ] = { crystal = xi.item.WATER_CRYSTAL,     cluster = xi.item.WATER_CLUSTER,     currency = 'water_crystals'     },
    [xi.element.LIGHT  ] = { crystal = xi.item.LIGHT_CRYSTAL,     cluster = xi.item.LIGHT_CLUSTER,     currency = 'light_crystals'     },
    [xi.element.DARK   ] = { crystal = xi.item.DARK_CRYSTAL,      cluster = xi.item.DARK_CLUSTER,      currency = 'dark_crystals'      },
}

local getStoredCrystals = function(player)
    -- Fetch Crystals stored.
    local fireCrystals    = player:getCurrency('fire_crystals')
    local iceCrystals     = player:getCurrency('ice_crystals')
    local windCrystals    = player:getCurrency('wind_crystals')
    local earthCrystals   = player:getCurrency('earth_crystals')
    local thunderCrystals = player:getCurrency('lightning_crystals')
    local waterCrystals   = player:getCurrency('water_crystals')
    local lightCrystals   = player:getCurrency('light_crystals')
    local darkCrystals    = player:getCurrency('dark_crystals')

    -- Build bitmasks.
    local param1 = fireCrystals + iceCrystals * 65536
    local param2 = windCrystals + earthCrystals * 65536
    local param3 = thunderCrystals + waterCrystals * 65536
    local param4 = lightCrystals + darkCrystals * 65536

    return { param1, param2, param3, param4 }
end

xi.crafting.ephemeralMoogleOnTrade = function(player, npc, trade)
    local eventParams = { 0, 0, 0, 0, 0, 0, 0, 0 }
    local validTrade  = false

    for i = xi.element.FIRE, xi.element.DARK do
        local entry = crystalTable[i]

        -- Check how far from crystal cap we are.
        local availablePoints = 5000 - player:getCurrency(entry.currency)

        -- Handle Clusters.
        local clusterQuantity = trade:getItemQty(entry.cluster)                              -- Current total clusters of an element in trade.
        local clusterLimit    = math.floor(availablePoints / 12)                             -- Max amount of clusters that we can fit in storage.
        clusterQuantity       = utils.clamp(clusterQuantity, 0, clusterLimit)                -- Limit current clusters in trade if we are limited by storage cap.
        availablePoints       = utils.clamp(availablePoints - clusterQuantity * 12, 0, 5000) -- Reduce currency limit tracking (For crystals of the same element).

        if clusterQuantity > 0 then
            trade:confirmItem(entry.cluster, clusterQuantity)
        end

        -- Handle Crystals.
        local crystalQuantity = trade:getItemQty(entry.crystal)
        crystalQuantity       = utils.clamp(crystalQuantity, 0, availablePoints)

        if crystalQuantity > 0 then
            trade:confirmItem(entry.crystal, crystalQuantity)
        end

        -- Save event parameters.
        eventParams[i] = clusterQuantity + crystalQuantity * 65536

        -- Store total to add after trade is confirmed
        local total = crystalQuantity + clusterQuantity * 12
        if total > 0 then
            validTrade = true
            player:setLocalVar('[EM]' .. entry.currency, total)
        end
    end

    if validTrade then
        player:startEvent(moogleEventTable[npc:getName()].trade, eventParams[1], eventParams[2], eventParams[3], eventParams[4], eventParams[5], eventParams[6], eventParams[7], eventParams[8])
    else
        player:startEvent(moogleEventTable[npc:getName()].fail)
    end
end

xi.crafting.ephemeralMoogleOnTrigger = function(player, npc)
    local eventParams = getStoredCrystals(player)

    player:startEvent(moogleEventTable[npc:getName()].trigger, eventParams[1], eventParams[2], eventParams[3], eventParams[4], 0, 0, 0, 0)
end

xi.crafting.ephemeralMoogleOnEventUpdate = function(player, csid, option, npc)
    -- Only trade event (crystal storing) has updates.
    if csid == moogleEventTable[npc:getName()].trade then
        -- Delete confirmed trade items, first thing.
        player:confirmTrade()

        -- Add currencies.
        for i = xi.element.FIRE, xi.element.DARK do
            local currencyName   = crystalTable[i].currency
            local currencyAmount = player:getLocalVar('[EM]' .. currencyName)
            if currencyAmount > 0 then
                player:addCurrency(currencyName, currencyAmount)
                player:setLocalVar('[EM]' .. currencyName, 0)
            end
        end

        -- Update event.
        local eventParams = getStoredCrystals(player)

        player:updateEvent(eventParams[1], eventParams[2], eventParams[3], eventParams[4])
    end
end

xi.crafting.ephemeralMoogleOnEventFinish = function(player, csid, option, npc)
    -- Logic for crystal retrieving.
    if csid ~= moogleEventTable[npc:getName()].trigger then
        return
    end

    if bit.band(option, 0xFFFF) == 0 then
        return
    end

    -- Grab the crystal type and quantities
    local crystalType   = bit.band(bit.rshift(option, 16), 0xFF) -- Element.
    local totalQuantity = bit.band(option, 0xFFFF)
    local crystalAmount = totalQuantity % 12
    local clusterAmount = math.floor(totalQuantity / 12)

    -- Player selected 'As many you can fit.'
    if option > 0x80000000 then
        -- Recalculate the quantity according to open inventory slots
        local freeSlots = player:getFreeSlotsCount()
        if freeSlots > 0 then -- If we don't have any free slots, don't bother. Just fail later.
            local clusterStacks = math.ceil(clusterAmount / 12)

            -- If we don't have room for everything, drop the extra crystals first
            if (clusterStacks + math.ceil(crystalAmount / 12)) > freeSlots then
                crystalAmount = 0
            end

            -- Pick the the smaller of the cluster stacks and free slots
            clusterStacks = math.min(clusterStacks, freeSlots)

            -- Original number of clusters could have an incomplete stack
            clusterAmount = math.min(clusterAmount, clusterStacks * 12)
        end
    end

    local totalToRemove = clusterAmount * 12 + crystalAmount

    -- Check current currency.
    if totalToRemove > player:getCurrency(crystalTable[crystalType].currency) then
        printf('Player %s attempted to retrieve an invalid ammount of %s' , player:getName(), crystalTable[crystalType].currency)
        return
    end

    -- Check free slots. Return if not enough slots without giving any.
    local slotsUsed = math.ceil(clusterAmount / 12) + math.ceil(crystalAmount / 12)
    if slotsUsed > player:getFreeSlotsCount() then
        return
    end

    -- Delete currency.
    if totalToRemove > 0 then
        player:delCurrency(crystalTable[crystalType].currency, totalToRemove) -- Remove currency.
    end

    -- Give Clusters.
    if clusterAmount > 0 then
        npcUtil.giveItem(player, { { crystalTable[crystalType].cluster, clusterAmount } })
    end

    -- Give Crystals.
    if crystalAmount > 0 then
        npcUtil.giveItem(player, { { crystalTable[crystalType].crystal, crystalAmount } })
    end
end
