-----------------------------------
-- Guild Shops
-----------------------------------

xi = xi or {}
xi.guildShops = xi.guildShops or {}
xi.guildShops.state = xi.guildShops.state or {} -- In-memory shop state, keyed by canonical NPC name.

--- Buy-curve divisor for an item.
local priceFloorOf = function(cfg)
    -- Buy-curve floor defaults to 3/4 of max stock; items can override per-item.
    return cfg.priceFloor or (cfg.maxStock * 3 / 4)
end

--- Calculate buy price of an item at open
--- Two-segment discount curve.
--- - Below the knee (2/3*priceFloor) it ramps 0..80% off;
--- - Above it, 80%..90% off at maxStock.
--- The discount is floored before applying: 1/125 below the knee, 1/1000 above.
local calcBuyPrice = function(buyMax, priceFloor, maxStock, stock)
    local kneeRatio = 2 / 3
    if priceFloor <= 0 then
        return buyMax
    end

    local knee = kneeRatio * priceFloor
    if stock <= knee then
        return math.floor(buyMax * (125 - math.floor(150 * stock / priceFloor)) / 125)
    end

    return math.floor(buyMax * (200 - math.floor(100 * (stock - knee) / (maxStock - knee))) / 1000)
end

---Calculate sell price of an item at open
---1.5 * base when empty, down to base when full (base = regular NPC sell price).
local calcSellPrice = function(base, maxStock, stock)
    if maxStock <= 0 then
        return math.floor(base * 3 / 2)
    end

    local index = math.floor(200 * stock / maxStock)
    return math.floor(base * (600 - index) / 400)
end

local getShopState = function(name)
    local state = xi.guildShops.state[name]
    if state == nil then
        state =
        {
            lastRoll = -1, -- Vanaday the snapshot was locked (-1 = uninitialized)
            items    = {}, -- [itemId] = { stock, buyPrice, sellPrice, offered }
        }

        xi.guildShops.state[name] = state
    end

    return state
end

-- The stock config for an item, or nil if the shop does not carry it.
local shopConfig = function(shop, itemId)
    for _, cfg in ipairs(shop.stock) do
        if cfg.id == itemId then
            return cfg
        end
    end
end

-- Resolve an NPC to its Shop Name
-- Some NPCs share stock
local canonicalShop = function(npc)
    local name = npc:getName()
    local cfg  = xi.data.guildShops[name]
    return (cfg and cfg.sharedStock) or name
end

local shopFor = function(npc)
    return xi.data.guildShops[canonicalShop(npc)]
end

---A rejected result: zeroed itemNo/count with a Trade reason code.
local rejected = function(trade)
    return { itemNo = 0, count = 0, trade = trade }
end

---Rolls the shop to the current day: restock/trim each item to targetStock, lock prices.
---Mutates only once per Vanaday
local rollShopDay = function(npc, shop)
    local state = getShopState(canonicalShop(npc))
    local today = VanadielUniqueDay()
    if state.lastRoll == today then
        return state
    end

    local firstRoll = state.lastRoll < 0
    local days      = firstRoll and 0 or (today - state.lastRoll)

    for _, cfg in ipairs(shop.stock) do
        local prev  = state.items[cfg.id]
        local stock = prev and prev.stock or cfg.initial

        if not firstRoll and cfg.restockRate > 0 and stock < cfg.targetStock then
            stock = math.min(cfg.targetStock, stock + cfg.restockRate * days)
        end

        -- Sales can pile stock up to maxStock during the day, but every open trims it back to targetStock.
        stock = math.min(stock, cfg.targetStock)

        state.items[cfg.id] =
        {
            stock     = stock,
            buyPrice  = calcBuyPrice(cfg.buyMax, priceFloorOf(cfg), cfg.maxStock, stock),
            sellPrice = cfg.sellPrice or calcSellPrice(GetReadOnlyItem(cfg.id):getBasePrice(), cfg.maxStock, stock),
            offered   = stock > 0, -- locked: 0 at open => not sold today
        }
    end

    state.lastRoll = today

    return state
end

local guildShopIsOpen = function(npc)
    local shop = shopFor(npc)
    if shop == nil then
        return false
    end

    local hour = VanadielHour()
    return hour >= shop.hours[1] and hour < shop.hours[2]
end

---@param player CBaseEntity
---@param npc CBaseEntity
---@return boolean isOpen
xi.guildShops.onTrigger = function(player, npc)
    local shop = shopFor(npc)
    if shop == nil then
        return false
    end

    npc:facePlayer(player)
    rollShopDay(npc, shop)

    return player:openGuildShop(npc, shop.hours[1], shop.hours[2])
end

---Process player purchase.
---@param player CBaseEntity
---@param npc CBaseEntity
---@param itemId xi.item
---@param quantity integer
---@return { itemNo: integer, count: integer, trade: integer }
xi.guildShops.onPlayerBuy = function(player, npc, itemId, quantity)
    local shop = shopFor(npc)

    -- Invalid shop or the guild shop is now closed
    if shop == nil or not guildShopIsOpen(npc) then
        return rejected(-1)
    end

    -- Invalid item
    local cfg = shopConfig(shop, itemId)
    if cfg == nil then
        return rejected(-1)
    end

    -- Get current item state
    local state = rollShopDay(npc, shop)
    local item  = state.items[itemId]

    -- Item is not being offered today, even if someone sold some.
    if not item.offered then
        return rejected(-1)
    end

    -- Bad quantity or no more in stock
    quantity = math.min(quantity, item.stock)
    if quantity <= 0 then
        return rejected(-1)
    end

    -- Player does not have money for purchase
    local cost = item.buyPrice * quantity
    if player:getGil() < cost then
        return rejected(-1)
    end

    -- Inventory is full
    if not player:addItem(itemId, quantity) then
        return rejected(-1)
    end

    -- Delete player gil and adjust remaining stock
    player:delGil(cost)
    item.stock = item.stock - quantity

    -- Hand off result to core for packet purposes
    return { itemNo = itemId, count = item.stock, trade = quantity }
end

---Items the shop offers today.
---@param player CBaseEntity
---@param npc CBaseEntity
---@return { id: integer, count: integer, price: integer, max: integer }[]
xi.guildShops.onBuyList = function(player, npc)
    local shop = shopFor(npc)
    if shop == nil then
        return {}
    end

    local state = rollShopDay(npc, shop)

    local items = {}
    for _, cfg in ipairs(shop.stock) do
        local item = state.items[cfg.id]
        if item.offered then
            items[#items + 1] =
            {
                id    = cfg.id,
                count = item.stock,
                price = item.buyPrice,
                max   = cfg.maxStock,
            }
        end
    end

    return items
end

---Process players selling items to the shop.
---@param player CBaseEntity
---@param npc CBaseEntity
---@param itemId xi.item
---@param quantity integer
---@return { itemNo: integer, count: integer, trade: integer, sold: integer, price: integer }
xi.guildShops.onPlayerSell = function(player, npc, itemId, quantity)
    local shop = shopFor(npc)

    -- Invalid shop or closed
    if shop == nil or not guildShopIsOpen(npc) then
        return rejected(-4)
    end

    -- Invalid item, or one the shop refuses to buy back
    local cfg = shopConfig(shop, itemId)
    if cfg == nil or cfg.noSell then
        return rejected(-4)
    end

    -- Get current item state
    local state  = rollShopDay(npc, shop)
    local item   = state.items[itemId]

    -- Cap the purchase to the least of requested quantity or remaining stock
    local want   = math.min(quantity, cfg.maxStock - item.stock)

    -- Packet does NOT provide specific inventory slots, we have to iterate the player inventory ourselves
    -- The sale can potentially span multiple stacks
    local stacks = player:findItems(itemId, xi.inventoryLocation.INVENTORY)
    local sold   = 0
    for _ = 1, #stacks do
        local front = player:findItems(itemId, xi.inventoryLocation.INVENTORY)[1]
        local take  = front and math.min(want - sold, front:getQuantity() - front:getReservedValue()) or 0
        if take <= 0 then
            break
        end

        player:delItem(itemId, take)
        sold = sold + take
    end

    if sold <= 0 then
        return rejected(-4)
    end

    player:addGil(item.sellPrice * sold)
    item.stock = item.stock + sold

    -- Return sale status to core for packet and audit purposes.
    local trade = (sold < quantity) and -1 or sold
    return { itemNo = itemId, count = item.stock, trade = trade, sold = sold, price = item.sellPrice }
end

---Items the shop buys.
---@param player CBaseEntity
---@param npc CBaseEntity
---@return { id: integer, count: integer, price: integer, max: integer }[]
xi.guildShops.onSellList = function(player, npc)
    local shop = shopFor(npc)
    if shop == nil then
        return {}
    end

    local state = rollShopDay(npc, shop)

    local items = {}
    for _, cfg in ipairs(shop.stock) do
        if not cfg.noSell then
            local item  = state.items[cfg.id]
            local price = item.sellPrice
            if cfg.hidden then
                -- When MSB is set in packet, the client hides the item from the initial sell menu
                price = bit.bor(price, 0x80000000)
            end

            items[#items + 1] =
            {
                id    = cfg.id,
                count = item.stock,
                price = price,
                max   = cfg.maxStock,
            }
        end
    end

    return items
end

---Per-hour tick for a player with this shop open; closes at the close hour.
---@param player CBaseEntity
---@param npc CBaseEntity
xi.guildShops.onGameHour = function(player, npc)
    local shop = shopFor(npc)
    if shop == nil then
        return
    end

    if VanadielHour() == shop.hours[2] then
        xi.guildShops.onShopClose(player, npc)
    end
end

---Notifies player currently browsing the shop that it closed.
---@param player CBaseEntity
---@param npc CBaseEntity
xi.guildShops.onShopClose = function(player, npc)
    local shop = shopFor(npc)
    if shop ~= nil then
        player:sendGuildClose(shop.hours[1], shop.hours[2])
    end

    player:clearGuildShop()
end
