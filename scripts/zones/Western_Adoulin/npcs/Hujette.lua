-----------------------------------
-- Area: Western Adoulin
--  NPC: Hujette
-- Involved with Quest: 'All the Way to the Bank'
-- !pos 35 0 -56 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- ALL THE WAY TO THE BANK
    if player:hasKeyItem(xi.ki.TARUTARU_SAUCE_INVOICE) then
        local paidHujette = utils.mask.getBit(player:getCharVar('ATWTTB_Payments'), 1)
        if not paidHujette and npcUtil.tradeHas(trade, { { 'gil', 3000 } }) then
            player:startEvent(5070)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.HUJETTE_SHOP_TEXT)
    local stock =
    {
        5941, 20,     -- Campfire Choco
        5940, 8,      -- Trail Cookie
        5942, 20,     -- Cascade Candy
        5775, 544,    -- Chocolate Crepe
        5147, 3000,   -- Snoll Gelato
    }
    xi.shop.general(player, stock)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- ALL THE WAY TO THE BANK
    if csid == 5070 then
        player:confirmTrade()
        player:setCharVar('ATWTTB_Payments', utils.mask.setBit(player:getCharVar('ATWTTB_Payments'), 2, true))
        if utils.mask.isFull(player:getCharVar('ATWTTB_Payments'), 5) then
            npcUtil.giveKeyItem(player, xi.ki.TARUTARU_SAUCE_RECEIPT)
        end
    end
end

return entity
