-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("kupo_shield")

m:addOverride("xi.zones.Bastok_Markets.npcs.Nudara.onTrade", function(player, npc, trade)
    local function validateAndTradeItem(player, trade)
        local validtrade = false
        if (player:getCharVar("KupoShield") ~= 1) then
            if (player:hasKeyItem(xi.keyItem.WAY_OF_THE_ALCHEMIST) and
                (trade:hasItemQty(1386,1) or trade:hasItemQty(10792,1))) then
                validtrade = true
            elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_BLACKSMITH) and
                (trade:hasItemQty(1356, 1) or trade:hasItemQty(19788, 1))) then
                validtrade = true
            elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_BONEWORKER) and
                (trade:hasItemQty(1396, 1) or trade:hasItemQty(11058, 1))) then
                validtrade = true
            elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_CARPENTER) and
                (trade:hasItemQty(1346, 1) or trade:hasItemQty(18884, 1))) then
                validtrade = true
            elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_CULINARIAN) and
                (trade:hasItemQty(4235, 1) or trade:hasItemQty(5930, 1))) then
                validtrade = true
            elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_GOLDSMITH) and
                (trade:hasItemQty(1376, 1) or trade:hasItemQty(11060,1))) then
                validtrade = true
            elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_WEAVER) and
                (trade:hasItemQty(1366,1) or trade:hasItemQty(11000,1))) then
                validtrade = true
            elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_TANNER) and
                (trade:hasItemQty(12573,1) or trade:hasItemQty(10577,1))) then
                validtrade = true
            end
        end

        if (validtrade) then
            player:tradeComplete()
            player:addItem(26406)
            player:setCharVar("KupoShield",1)
            player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.ITEM_OBTAINED, 26406)
        else
            player:PrintToPlayer("Invalid trade")
        end
    end

    if(trade:getItemCount() >0) then
        validateAndTradeItem(player, trade)
    end
end)

m:addOverride("xi.zones.Bastok_Markets.npcs.Nudara.onTrigger", function(player, npc)
    local function hasKeyItem(player)
        if (player:hasKeyItem(xi.keyItem.WAY_OF_THE_ALCHEMIST) or player:hasKeyItem(xi.keyItem.WAY_OF_THE_BLACKSMITH) or
            player:hasKeyItem(xi.keyItem.WAY_OF_THE_BONEWORKER) or player:hasKeyItem(xi.keyItem.WAY_OF_THE_CARPENTER) or
            player:hasKeyItem(xi.keyItem.WAY_OF_THE_CULINARIAN) or player:hasKeyItem(xi.keyItem.WAY_OF_THE_GOLDSMITH) or
            player:hasKeyItem(xi.keyItem.WAY_OF_THE_WEAVER) or player:hasKeyItem(xi.keyItem.WAY_OF_THE_TANNER))
		then 
		    return true 
		end
        
		return false
    end
	
    local function announceOptions(player)
        if (player:hasKeyItem(xi.keyItem.WAY_OF_THE_ALCHEMIST)) then
            player:PrintToPlayer(
                "Trade me a [Cursed Mail] or a [Saida Ring] for a special shield.")
        elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_BLACKSMITH)) then
            player:PrintToPlayer(
                "Trade me a [Cursed Hauberk] or a [Gorkhali Kukri] for a special shield.")
        elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_BONEWORKER)) then
            player:PrintToPlayer(
                "Trade me a [Cursed Harness] or a [Hajduk Ring] for a special shield.")
        elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_CARPENTER)) then
            player:PrintToPlayer(
                "Trade me a [Cursed Togi] or a [Vejovis Wand] for a special shield.")
        elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_CULINARIAN)) then
            player:PrintToPlayer(
                "Trade me a [Cursed Soup] or a [Sprightly Soup] for a special shield.")
        elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_GOLDSMITH)) then
            player:PrintToPlayer(
                "Trade me a [Cursed Cuirass] or an [Evader Earring] for a special shield.")
        elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_WEAVER)) then
            player:PrintToPlayer(
                "Trade me a [Cursed Dalmatica] or a [Swith Cape] for a special shield.")
        elseif (player:hasKeyItem(xi.keyItem.WAY_OF_THE_TANNER)) then
            player:PrintToPlayer(
                "Trade me a [Dusk Jerkin] or [Urja Trousers] for a special shield.")
        end
    end

    if (hasKeyItem(player) == true) then
        announceOptions(player)
    else
        player:startEvent(118)
    end
end)

return m 