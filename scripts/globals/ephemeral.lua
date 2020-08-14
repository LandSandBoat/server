----------------------------------------------
-- Global functionality for Ephemeral Moogles
----------------------------------------------
require("scripts/globals/npc_util")
----------------------------------------------

tpz = tpz or {}

tpz.ephemeral = {}

-- Cap per crystal type that can be stored. Retail/Default is 5000
local CrystalCap = 5000

-- Information for currency storage and event params
local crystalData =
{
    { crystal = 4096, cluster = 4104, tradeparam = 1, eventparam = 1, offset = 0, name = "fire_crystals" }, -- Fire Crystal
    { crystal = 4097, cluster = 4105, tradeparam = 2, eventparam = 1, offset = 16, name = "ice_crystals" }, -- Ice Crystal
    { crystal = 4098, cluster = 4106, tradeparam = 3, eventparam = 2, offset = 0, name = "wind_crystals" }, -- Wind Crystal
    { crystal = 4099, cluster = 4107, tradeparam = 4, eventparam = 2, offset = 16, name = "earth_crystals" }, -- Earth Crystal
    { crystal = 4100, cluster = 4108, tradeparam = 5, eventparam = 3, offset = 0, name = "lightning_crystals" }, -- Lightning Crystal
    { crystal = 4101, cluster = 4109, tradeparam = 6, eventparam = 3, offset = 16, name = "water_crystals" }, -- Water Crystal
    { crystal = 4102, cluster = 4110, tradeparam = 7, eventparam = 4, offset = 0, name = "light_crystals" }, -- Light Crystal
    { crystal = 4103, cluster = 4111, tradeparam = 8, eventparam = 4, offset = 16, name = "dark_crystals" }, -- Dark Crystal
}

-- Helper function for getting crystal counts as params
local getCrystalTotals = function(player)
    local params = { 0, 0, 0, 0 }
    for _, v in pairs(crystalData) do
        params[v.eventparam] = bit.bor(params[v.eventparam], bit.lshift(player:getCurrency(v.name), v.offset))
    end
    return params
end

tpz.ephemeral.onTrade = function(player, trade, successEvent, failEvent)
    local params = { 0, 0, 0, 0, 0, 0, 0, 0 }
    local success = false
    for _, v in pairs(crystalData) do
        if npcUtil.tradeHas(trade, v.crystal) or npcUtil.tradeHas(trade, v.cluster) then
            -- Check how far from crystal cap we are
            local currentCount = math.min(player:getCurrency(v.name), CrystalCap) -- In case there is a db discrepancy
            local diff = CrystalCap - currentCount

            -- Count clusters and subtract any that won't fit
            local hqQty = trade:getItemQty(v.cluster)
            local hqToCrystal = math.min(hqQty * 12, math.floor(diff / 12))
            hqQty = math.floor(hqToCrystal / 12)
            diff = math.max(diff - hqQty * 12, 0)

            -- Confirm the clusters in the trade
            if hqQty > 0 then trade:confirmItem(v.cluster, hqQty) end

            -- Count normal crystals and and subtract any that won't fit
            local qty = math.min(trade:getItemQty(v.crystal), diff)

            -- Confirm the crystals in the trade
            if qty > 0 then trade:confirmItem(v.crystal, qty) end

            -- Calculate the params
            params[v.tradeparam] = bit.bor(hqQty, bit.lshift(qty, 16))

            -- Calculate total and add to player
            local total = qty + hqQty * 12
            player:addCurrency(v.name, total)

            -- Make sure we flag success if any of the crystals can be traded
            if (qty > 0) or (hqQty > 0) then
                success = true
            end
        end
    end

    if success then
        player:startEvent(successEvent, unpack(params))
    else
        player:startEvent(failEvent)
    end
end

tpz.ephemeral.onTrigger = function(player, event)
    player:startEvent(event, unpack(getCrystalTotals(player)))
end

tpz.ephemeral.onEventUpdate = function(player)
    player:updateEvent(unpack(getCrystalTotals(player)))
end

tpz.ephemeral.onEventFinish = function(player, option, wasTrade)
    -- Early out if the player cancelled the menu
    if not wasTrade and bit.band(option, 0xFFFF) == 0 then
        return
    end

    if wasTrade then
        -- Confirm trade
        player:confirmTrade()
    else
        -- Grab the crystal type and quantities
            local index = bit.band(bit.rshift(option, 16), 0xFF)
            local quantity = bit.band(option, 0xFFFF)
            local crystals = quantity % 12
            local clusters = math.floor(quantity / 12)

             -- Player selected "as many as can fit"
            if (option > 0x80000000) then
                -- Recalculate the quantity according to open inventory slots
                local freeSlots = player:getFreeSlotsCount()
                if freeSlots > 0 then -- If we don't have any free slots, don't bother. Just fail later.
                    local clusterStacks = math.ceil(clusters / 12)

                    -- If we don't have room for everything, drop the extra crystals first
                    if (clusterStacks + math.ceil(crystals / 12)) > freeSlots then
                        crystals = 0
                    end

                    -- Pick the the smaller of the cluster stacks and free slots
                    clusterStacks = math.min(clusterStacks, freeSlots)

                    -- Original number of clusters could have an incomplete stack
                    clusters = math.min(clusters, clusterStacks * 12)
                end
            end

            local totalToRemove = 0

            -- Clusters first
            if clusters > 0 then
                if npcUtil.giveItem(player, { { crystalData[index].cluster, clusters } }) then
                    totalToRemove = clusters * 12
                end
            end

            -- Then Crystals
            if crystals > 0 then
                if npcUtil.giveItem(player, { { crystalData[index].crystal, crystals } }) then
                    totalToRemove = totalToRemove + crystals
                end
            end

            -- Crystals were added. Remove them from char_points
            if totalToRemove > 0 then
                player:delCurrency(crystalData[index].name, totalToRemove)
            end
    end
end
