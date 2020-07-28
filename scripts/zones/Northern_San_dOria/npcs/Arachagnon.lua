-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arachagnon
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
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
        12633, 270,    -- Elvaan Jerkin
        12634, 270,    -- Elvaan Bodice
        12755, 162,    -- Elvaan Gloves
        12759, 162,    -- Elvaan Gauntlets
        12885, 234,    -- Elvaan M Chausses
        12889, 234,    -- Elvaan F Chausses
        13006, 162,    -- Elvaan M Ledelsens
        13011, 162,    -- Elvaan F Ledelsens
    }

    player:showText(npc, ID.text.ARACHAGNON_SHOP_DIALOG)
    tpz.shop.general(player, stock, SANDORIA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
