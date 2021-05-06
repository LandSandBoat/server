-----------------------------------
-- Area: Western Adoulin
--  NPC: Defliaa
-- Type: Quest NPC and Shop NPC
-- Involved with Quest: 'All the Way to the Bank'
-- !pos 43 2 -113 256
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/utils")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- ALL THE WAY TO THE BANK
    if (player:hasKeyItem(xi.ki.TARUTARU_SAUCE_INVOICE)) then
        local ATWTTB_Paid_Defliaa = utils.mask.getBit(player:getCharVar("ATWTTB_Payments"), 0)
        if (not ATWTTB_Paid_Defliaa and npcUtil.tradeHas( trade, {{"gil", 19440}} )) then
            player:startEvent(5069)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.DEFLIAA_SHOP_TEXT)
    local stock =
    {
        5166, 3400,   -- Coeurl Sub
        4421, 1560,   -- Melon Pie
        5889, 19440,  -- Stuffed Pitaru
        5885, 18900,  -- Saltena
        4396, 280,    -- Sausage Roll
        4356, 200,    -- White Bread
        5686, 800,    -- Cheese Sandwich
    }
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- ALL THE WAY TO THE BANK
    if (csid == 5069) then
        player:confirmTrade()
        player:setCharVar("ATWTTB_Payments", utils.mask.setBit(player:getCharVar("ATWTTB_Payments"), 0, true))
        if utils.mask.isFull(player:getCharVar("ATWTTB_Payments"), 5) then
            npcUtil.giveKeyItem(player, xi.ki.TARUTARU_SAUCE_RECEIPT)
        end
    end
end

return entity
