-----------------------------------
-- Area: Lower Jeuno
--  NPC: Honorine
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------
---@type TNpcEntity

local currencyExchange =
{
    [xi.item.TUKUKU_WHITESHELL]     = xi.item.LUNGO_NANGO_JADESHELL,
    [xi.item.LUNGO_NANGO_JADESHELL] = xi.item.RIMILALA_STRIPESHELL,
    [xi.item.ORDELLE_BRONZEPIECE]   = xi.item.MONTIONT_SILVERPIECE,
    [xi.item.MONTIONT_SILVERPIECE]  = xi.item.RANPERRE_GOLDPIECE,
    [xi.item.ONE_BYNE_BILL]         = xi.item.ONE_HUNDRED_BYNE_BILL,
    [xi.item.ONE_HUNDRED_BYNE_BILL] = xi.item.TEN_THOUSAND_BYNE_BILL,
}

local currencyReturn =
{
    [xi.item.RIMILALA_STRIPESHELL] = xi.item.LUNGO_NANGO_JADESHELL,
    [xi.item.RANPERRE_GOLDPIECE] = xi.item.MONTIONT_SILVERPIECE,
    [xi.item.TEN_THOUSAND_BYNE_BILL] = xi.item.ONE_HUNDRED_BYNE_BILL,
}

local entity = {}

entity.onTrade = function(player, npc, trade)
    local clusterShift   = xi.item.FIRE_CLUSTER - xi.item.FIRE_CRYSTAL
    local clustersToGive = {}

    for itemID = xi.item.FIRE_CRYSTAL, xi.item.DARK_CRYSTAL do
        local clusters = math.floor(trade:getItemQty(itemID) / 12)

        if clusters > 0 and npcUtil.tradeHas(trade, {{ itemID, clusters * 12 }}) then
            clustersToGive[#clustersToGive + 1] = { itemID + clusterShift, clusters }
        end
    end

    if #clustersToGive > 0 then
        player:confirmTrade()
        npcUtil.giveItem(player, clustersToGive)
        return
    elseif npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_WHISTLE) then
        player:confirmTrade()
        npcUtil.giveItem(player, xi.item.CHOCOBO_WHISTLE)
        player:printToPlayer("Your Chocobo Whistle has been re-charged!", xi.msg.channel.SAY, "Honorine")
        return
    end

    -- QoL trades for dynamis 100s
    if player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) then
        for inputCurrency, outputCurrency in pairs(currencyExchange) do
            if npcUtil.tradeHasExactly(trade, {{ inputCurrency, xi.settings.main.CURRENCY_EXCHANGE_RATE }}) then
                player:confirmTrade()
                npcUtil.giveItem(player, outputCurrency)
                return
            end
        end

        for inputCurrency, outputCurrency in pairs(currencyReturn) do
            if npcUtil.tradeHasExactly(trade, inputCurrency) then
                if player:getFreeSlotsCount() < math.ceil(xi.settings.main.CURRENCY_EXCHANGE_RATE / 99) - 1 then
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, outputCurrency)
                    return
                end

                player:confirmTrade()

                local amount = xi.settings.main.CURRENCY_EXCHANGE_RATE
                local itemsToGive = {}
                while amount > 0 do
                    player:addItem(outputCurrency, math.min(99, amount), true)
                    table.insert(itemsToGive, { outputCurrency, math.min(99, amount) })
                    amount = amount - 99
                end

                player:messageSpecial(ID.text.ITEM_OBTAINED, outputCurrency)
                return
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local time = os.time()

    if time > player:getLocalVar("HonorineMessageTime") then
        player:printToPlayer("Did you know I can exchange crystals/clusters, dynamis currency, and refill your chocobo whistle?", xi.msg.channel.SAY, "Honorine")
        player:printToPlayer("Anyway, abra cadabra, have a costume! ^_^", xi.msg.channel.SAY, "Honorine")
        player:setLocalVar("HonorineMessageTime", time + 60)
    end

    if player:getCharVar("Sausaged") == 1 then
        player:printToPlayer("That Galka finally came back after picking up all of that meat. I think...", xi.msg.channel.SAY, "Honorine")
        player:printToPlayer("I think he actually ate all of that. He says you weren't the special one and to take this.", xi.msg.channel.SAY, "Honorine")
        player:printToPlayer("Whatever that means. I think he had the meat sweats...", xi.msg.channel.SAY, "Honorine")
        if npcUtil.giveItem(player, 4396) then
            player:setCharVar("Sausaged", 0)
        end
    else
        player:addStatusEffect(xi.effect.COSTUME, math.random(1, 2417), 0, 3600)
    end
end

return entity