-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Capiria
-- Type: Involved in Quest (Flyers for Regine)
-- !pos -127.355 0.000 130.461 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- FLYERS FOR REGINE
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        if player:getCharVar("tradeCapiria") == 0 then
            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:messageSpecial(ID.text.FFR_CAPIRIA)
            player:addCharVar("FFR", -1)
            player:setCharVar("tradeCapiria", 1)
            player:confirmTrade()
        else
            player:messageSpecial(ID.text.FLYER_ALREADY)
        end
    end
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.CAPIRIA_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
