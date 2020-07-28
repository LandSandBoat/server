-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Boncort
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
    -- FLYERS FOR REGINE
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        if player:getCharVar("tradeBoncort") == 0 then
            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:messageSpecial(ID.text.FFR_BONCORT)
            player:addCharVar("FFR", -1)
            player:setCharVar("tradeBoncort", 1)
            player:confirmTrade()
        else
            player:messageSpecial(ID.text.FLYER_ALREADY)
        end
    end
end

function onTrigger(player, npc)
    local stock =
    {
        4441, 837, 1,    --Grape Juice
        4356, 180, 2,    --White Bread
        4380, 198, 2,    --Smoked Salmon
        4423, 270, 2,    --Apple Juice
        4364, 108, 3,    --Black Bread
        4376, 108, 3,    --Meat Jerky
        4509,  10, 3,    --Distilled Water
        5007, 163, 3,    --Scroll of Sword Madrigal
    }

    player:showText(npc, ID.text.BONCORT_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
