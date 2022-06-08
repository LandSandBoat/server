-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/dynamis")

local m = Module:new("dynamis_singles_for_hundos")

m:addOverride("xi.zones.Castle_Oztroja.npcs.Antiqix.onTrade", function(player, npc, trade)
    local ID = require("scripts/zones/Castle_Oztroja/IDs")
    local TIMELESS_HOURGLASS = 4236
    local currency = {1449, 1450, 1451}
    local shop = {
        7, 1312, -- Angel Skin
        8, 1518, -- Colossal Skull
        9, 1464, -- Lancewood Log
       23, 1463, -- Chronos Tooth
       24, 1467, -- Relic Steel
       25, 1462, -- Lancewood Lumber
       28, 658,  -- Damascus Ingot
    }
    local maps = {
        [xi.ki.MAP_OF_DYNAMIS_SAN_DORIA]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BASTOK]     = 10000,
        [xi.ki.MAP_OF_DYNAMIS_WINDURST]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_JEUNO]      = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BEAUCEDINE] = 15000,
        [xi.ki.MAP_OF_DYNAMIS_XARCABARD]  = 20000,
        [xi.ki.MAP_OF_DYNAMIS_VALKURM]    = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BUBURIMU]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_QUFIM]      = 10000,
        [xi.ki.MAP_OF_DYNAMIS_TAVNAZIA]   = 20000,
    }

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
    local ID = require("scripts/zones/Beadeaux/IDs")
    local TIMELESS_HOURGLASS = 4236
    local currency = {1455, 1456, 1457}
    local shop = {
        7, 1313, -- Siren's Hair
        8, 1521, -- Slime Juice
        9, 1469, -- Wootz Ore
       12, 4246, -- Cantarella
       20, 1468, -- Marksman's Oil
       25, 1461, -- Wootz Ingot
       33, 1460, -- Koh-I-Noor
    }
    local maps = {
        [xi.ki.MAP_OF_DYNAMIS_SAN_DORIA]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BASTOK]     = 10000,
        [xi.ki.MAP_OF_DYNAMIS_WINDURST]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_JEUNO]      = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BEAUCEDINE] = 15000,
        [xi.ki.MAP_OF_DYNAMIS_XARCABARD]  = 20000,
        [xi.ki.MAP_OF_DYNAMIS_VALKURM]    = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BUBURIMU]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_QUFIM]      = 10000,
        [xi.ki.MAP_OF_DYNAMIS_TAVNAZIA]   = 20000,
    }

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
    local ID = require("scripts/zones/Davoi/IDs")
    local TIMELESS_HOURGLASS = 4236
    local currency = {1452, 1453, 1454}
    local shop = {
         5, 1295, -- Twincoon
         6, 1466, -- Relic Iron
         7, 1520, -- Goblin Grease
         8, 1516, -- Griffon Hide
        23, 1459, -- Griffon Leather
        25, 883,  -- Behemoth Horn
        28, 1458, -- Mammoth Tusk
    }
    local maps = {
        [xi.ki.MAP_OF_DYNAMIS_SAN_DORIA]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BASTOK]     = 10000,
        [xi.ki.MAP_OF_DYNAMIS_WINDURST]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_JEUNO]      = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BEAUCEDINE] = 15000,
        [xi.ki.MAP_OF_DYNAMIS_XARCABARD]  = 20000,
        [xi.ki.MAP_OF_DYNAMIS_VALKURM]    = 10000,
        [xi.ki.MAP_OF_DYNAMIS_BUBURIMU]   = 10000,
        [xi.ki.MAP_OF_DYNAMIS_QUFIM]      = 10000,
        [xi.ki.MAP_OF_DYNAMIS_TAVNAZIA]   = 20000,
    }

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

return m 