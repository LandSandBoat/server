-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Phamelise
-- Zulkheim Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/conquest")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        player:messageSpecial(ID.text.FLYER_REFUSED)
    else
        onHalloweenTrade(player, trade, npc)
    end
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.ZULKHEIM) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.PHAMELISE_CLOSED_DIALOG)
    else
        local stock =
        {
            4372,   44,    -- Giant Sheep Meat
            622,    44,    -- Dried Marjoram
            610,    55,    -- San d'Orian Flour
            611,    36,    -- Rye Flour
            1840, 1840,    -- Semolina
            4366,   22,    -- La Theine Cabbage
            4378,   55,    -- Selbina Milk
        }

        player:showText(npc, ID.text.PHAMELISE_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
