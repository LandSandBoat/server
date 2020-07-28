-----------------------------------
--  Area: Western Adoulin
--  NPC: Hujette
--  Type: Quest NPC and Shop NPC
--  Involved with Quest: 'All the Way to the Bank'
--  !pos 35 0 -56 256
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
    -- ALL THE WAY TO THE BANK
    if (player:hasKeyItem(tpz.ki.TARUTARU_SAUCE_INVOICE)) then
        local ATWTTB_Paid_Hujette = player:getMaskBit(player:getCharVar("ATWTTB_Payments"), 1)
        if ((not ATWTTB_Paid_Hujette) and npcUtil.tradeHas( trade, {{"gil", 3000}} )) then
            player:startEvent(5070)
        end
    end
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.HUJETTE_SHOP_TEXT)
    local stock =
    {
        5941, 20,     -- Campfire Choco
        5940, 8,      -- Trail Cookie
        5942, 20,     -- Cascade Candy
        5775, 544,    -- Chocolate Crepe
        5147, 3000,   -- Snoll Gelato
    }
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- ALL THE WAY TO THE BANK
    if (csid == 5070) then
        player:confirmTrade()
        player:setMaskBit("ATWTTB_Payments", 1, true)
        if (player:isMaskFull(player:getCharVar("ATWTTB_Payments"), 5)) then
            npcUtil.giveKeyItem(player, tpz.ki.TARUTARU_SAUCE_RECEIPT)
        end
    end
end
