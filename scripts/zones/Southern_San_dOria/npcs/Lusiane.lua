-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Lusiane
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        player:messageSpecial(ID.text.FLYER_REFUSED)
    end
end

function onTrigger(player, npc)
    local stock =
    {
        17389,  496, 1,    -- Bamboo Fishing Rod
        17395,    9, 2,    -- Lugworm
        17390,  217, 2,    -- Yew Fishing Rod
        17396,    3, 3,    -- Little Worm
        5068,   110, 3,    -- Scroll of Light Threnoldy
        5066,  1265, 3,    -- Scroll of Lightning Threnoldy
        17391,   66, 3,    -- Willow Fishing Rod
    }

    player:showText(npc, ID.text.LUSIANE_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
