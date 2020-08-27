-----------------------------------
-- Area: Windurst Woods
--   NPC: Nokkhi Jinjahl
-- Type: Travelling Merchant NPC / NPC Quiver Maker / Windurst 1st Place
-- !pos 4 1 -43 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local ammoList =
    {
        {21307, 6199}, -- arrow, achiyalabopa
        {21306, 6200}, -- arrow, adlivun
        {19195, 5819}, -- arrow, antlion
        {18154, 4221}, -- arrow, beetle
        {21309, 6137}, -- arrow, chapuli
        {18159, 4224}, -- arrow, demon
        {21302, 6269}, -- arrow, eminent
        {19800, 5912}, -- arrow, gargouille
        {18156, 4222}, -- arrow, horn
        {17320, 4225}, -- arrow, iron
        {17325, 5332}, -- arrow, kabura
        {21308, 6138}, -- arrow, mantid
        {21303, 6280}, -- arrow, ra'kaznar
        {21304, 6202}, -- arrow, raaz
        {19182, 5871}, -- arrow, ruszor
        {18155, 4223}, -- arrow, scorpion
        {17321, 4226}, -- arrow, silver
        {18158, 5333}, -- arrow, sleep
        {17330, 4219}, -- arrow, stone
        {21305, 6201}, -- arrow, tulfaire

        {21314, 6278}, -- bolt, abrasion
        {21321, 6203}, -- bolt, achiyalabopa
        {18148, 5335}, -- bolt, acid
        {19801, 5913}, -- bolt, adaman
        {21320, 6204}, -- bolt, adlivun
        {21318, 6206}, -- bolt, bismuth
        {18150, 5334}, -- bolt, blind
        {18151, 5339}, -- bolt, bloody
        {21322, 6140}, -- bolt, damascus
        {19183, 5872}, -- bolt, dark adaman
        {19196, 5820}, -- bolt, darkling
        {17338, 4229}, -- bolt, darksteel
        {21316, 6270}, -- bolt, eminent
        {19197, 5821}, -- bolt, fusion
        {21313, 6310}, -- bolt, gashing
        {18153, 5336}, -- bolt, holy
        {21324, 6139}, -- bolt, midrium
        {17337, 4228}, -- bolt, mythril
        {21323, 6141}, -- bolt, oxidant
        {21317, 6281}, -- bolt, ra'kaznar
        {21315, 6279}, -- bolt, righteous
        {18149, 5337}, -- bolt, sleep
        {21319, 6205}, -- bolt, titanium
        {18152, 5338}, -- bolt, venom

        {19803, 5915}, -- bullet, adaman
        {21336, 6208}, -- bullet, adlivun
        {21337, 6207}, -- bullet, achiyalabopa
        {17340, 5363}, -- bullet
        {21333, 6210}, -- bullet, bismuth
        {17343, 5359}, -- bullet, bronze
        {21338, 6143}, -- bullet, damascus
        {19184, 5873}, -- bullet, dark adaman
        {21330, 6311}, -- bullet, decimating
        {21328, 6437}, -- bullet, divine
        {19198, 5822}, -- bullet, dweomer
        {21331, 6271}, -- bullet, eminent
        {17312, 5353}, -- bullet, iron
        {19802, 5914}, -- bullet, orichalcum
        {19199, 5823}, -- bullet, oberon's
        {21332, 6282}, -- bullet, ra'kaznar
        {17341, 5340}, -- bullet, silver
        {18723, 5416}, -- bullet, steel
        {18160, 5341}, -- bullet, spartan
        {21335, 6209}, -- bullet, titanium

        {2176, 5402}, -- card, fire
        {2177, 5403}, -- card, ice
        {2178, 5404}, -- card, wind
        {2179, 5405}, -- card, earth
        {2180, 5406}, -- card, thunder
        {2181, 5407}, -- card, water
        {2182, 5408}, -- card, light
        {2183, 5409}, -- card, dark
    }

    local carnationsNeeded = 0
    local giveToPlayer = {}

    -- check for invalid items
    for i = 0, 8, 1 do
        local itemId = trade:getItemId(i)
        if itemId > 0 and itemId ~= 948 then
            local validSlot = false
            for k, v in pairs(ammoList) do
                if v[1] == itemId then
                    local itemQty = trade:getSlotQty(i)
                    if itemQty % 99 ~= 0 then
                        player:messageSpecial(ID.text.NOKKHI_BAD_COUNT)
                        return
                    end
                    local stacks = itemQty / 99
                    carnationsNeeded = carnationsNeeded + stacks
                    giveToPlayer[#giveToPlayer+1] = {v[2], stacks}
                    validSlot = true
                    break
                end
            end
            if not validSlot then
                player:messageSpecial(ID.text.NOKKHI_BAD_ITEM)
                return
            end
        end
    end

    -- check for correct number of carnations
    if carnationsNeeded == 0 or trade:getItemQty(948) ~= carnationsNeeded then
        player:messageSpecial(ID.text.NOKKHI_BAD_COUNT)
        return
    end

    -- check for enough inventory space
    if player:getFreeSlotsCount() < carnationsNeeded then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, giveToPlayer[1][1])
        return
    end

    -- make the trade
    player:messageSpecial(ID.text.NOKKHI_GOOD_TRADE)
    for k, v in pairs(giveToPlayer) do
        player:addItem(v[1], v[2])
        player:messageSpecial(ID.text.ITEM_OBTAINED, v[1])
    end
    player:tradeComplete()
end

function onTrigger(player, npc)
    player:startEvent(667, npc:getID())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
