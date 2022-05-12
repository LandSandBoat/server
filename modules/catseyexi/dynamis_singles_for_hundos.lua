-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------

m:addOverride("xi.zones.Castle_Oztroja.npcs.Antiqix.onTrade", function(player, npc, trade)
    local gil = trade:getGil()
    local count = trade:getItemCount()

    if (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND)) then
        if npcUtil.tradeHasExactly(trade, 1453) then
	    	player:tradeComplete()
            player:addItem(1452,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1452) -- Give 100 Ordelle bronzepiece
        elseif npcUtil.tradeHasExactly(trade, 1456) then
            player:tradeComplete()
            player:addItem(1455,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1455) -- Give 100 One byne bill
	    elseif npcUtil.tradeHasExactly(trade, 1450) then
            player:tradeComplete()
            player:addItem(1449,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1449) -- Give 100 Tukuku whiteshell
	    end	
		
        -- buy prismatic hourglass
        if (gil == xi.settings.PRISMATIC_HOURGLASS_COST and count == 1 and not player:hasKeyItem(xi.ki.PRISMATIC_HOURGLASS)) then
            player:startEvent(54)

        -- return timeless hourglass for refund
        elseif (count == 1 and trade:hasItemQty(TIMELESS_HOURGLASS, 1)) then
            player:startEvent(97)

        -- currency exchanges
        elseif (count == xi.settings.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[1], xi.settings.CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(55, xi.settings.CURRENCY_EXCHANGE_RATE)
        elseif (count == xi.settings.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[2], xi.settings.CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(56, xi.settings.CURRENCY_EXCHANGE_RATE)
        elseif (count == 1 and trade:hasItemQty(currency[3], 1)) then
            player:startEvent(58, currency[3], currency[2], xi.settings.CURRENCY_EXCHANGE_RATE)

        -- shop
        else
            local item
            local price
            for i=1, 13, 2 do
                price = shop[i]
                item = shop[i+1]
                if (count == price and trade:hasItemQty(currency[2], price)) then
                    player:setLocalVar("hundoItemBought", item)
                    player:startEvent(57, currency[2], price, item)
                    break
                end
            end

        end
    end
end)

m:addOverride("xi.zones.Beadeaux.npcs.Haggleblix.onTrade", function(player, npc, trade)
    local gil = trade:getGil()
    local count = trade:getItemCount()

    if (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND)) then
        if npcUtil.tradeHasExactly(trade, 1453) then
	    	player:tradeComplete()
            player:addItem(1452,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1452) -- Give 100 Ordelle bronzepiece
        elseif npcUtil.tradeHasExactly(trade, 1456) then
            player:tradeComplete()
            player:addItem(1455,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1455) -- Give 100 One byne bill
	    elseif npcUtil.tradeHasExactly(trade, 1450) then
            player:tradeComplete()
            player:addItem(1449,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1449) -- Give 100 Tukuku whiteshell
	    end		

        -- buy prismatic hourglass
        if (gil == xi.settings.PRISMATIC_HOURGLASS_COST and count == 1 and not player:hasKeyItem(xi.ki.PRISMATIC_HOURGLASS)) then
            player:startEvent(134)

        -- return timeless hourglass for refund
        elseif (count == 1 and trade:hasItemQty(TIMELESS_HOURGLASS, 1)) then
            player:startEvent(153)

        -- currency exchanges
        elseif (count == xi.settings.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[1], xi.settings.CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(135, xi.settings.CURRENCY_EXCHANGE_RATE)
        elseif (count == xi.settings.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[2], xi.settings.CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(136, xi.settings.CURRENCY_EXCHANGE_RATE)
        elseif (count == 1 and trade:hasItemQty(currency[3], 1)) then
            player:startEvent(138, currency[3], currency[2], xi.settings.CURRENCY_EXCHANGE_RATE)

        -- shop
        else
            local item
            local price
            for i=1, 13, 2 do
                price = shop[i]
                item = shop[i+1]
                if (count == price and trade:hasItemQty(currency[2], price)) then
                    player:setLocalVar("hundoItemBought", item)
                    player:startEvent(137, currency[2], price, item)
                    break
                end
            end

        end
    end
end)

m:addOverride("xi.zones.Davoi.npcs.Lootblox.onTrade", function(player, npc, trade)
    local gil = trade:getGil()
    local count = trade:getItemCount()

    if (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND)) then
        if npcUtil.tradeHasExactly(trade, 1453) then
	    	player:tradeComplete()
            player:addItem(1452,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1452) -- Give 100 Ordelle bronzepiece
        elseif npcUtil.tradeHasExactly(trade, 1456) then
            player:tradeComplete()
            player:addItem(1455,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1455) -- Give 100 One byne bill
	    elseif npcUtil.tradeHasExactly(trade, 1450) then
            player:tradeComplete()
            player:addItem(1449,100)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1449) -- Give 100 Tukuku whiteshell
	    end		

        -- buy prismatic hourglass
        if (gil == xi.settings.PRISMATIC_HOURGLASS_COST and count == 1 and not player:hasKeyItem(xi.ki.PRISMATIC_HOURGLASS)) then
            player:startEvent(134)

        -- return timeless hourglass for refund
        elseif (count == 1 and trade:hasItemQty(TIMELESS_HOURGLASS, 1)) then
            player:startEvent(153)

        -- currency exchanges
        elseif (count == xi.settings.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[1], xi.settings.CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(135, xi.settings.CURRENCY_EXCHANGE_RATE)
        elseif (count == xi.settings.CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[2], xi.settings.CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(136, xi.settings.CURRENCY_EXCHANGE_RATE)
        elseif (count == 1 and trade:hasItemQty(currency[3], 1)) then
            player:startEvent(138, currency[3], currency[2], xi.settings.CURRENCY_EXCHANGE_RATE)

        -- shop
        else
            local item
            local price
            for i=1, 13, 2 do
                price = shop[i]
                item = shop[i+1]
                if (count == price and trade:hasItemQty(currency[2], price)) then
                    player:setLocalVar("hundoItemBought", item)
                    player:startEvent(137, currency[2], price, item)
                    break
                end
            end

        end
    end
end)