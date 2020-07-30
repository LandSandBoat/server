-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Coullene
-- Type: Involved in Quest (Flyers for Regine)
-- !pos 146.420 0.000 127.601 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- FLYERS FOR REGINE
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        if player:getCharVar("tradeCoullene") == 0 then
            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:messageSpecial(ID.text.FFR_COULLENE)
            player:addCharVar("FFR", -1)
            player:setCharVar("tradeCoullene", 1)
            player:confirmTrade()
        else
            player:messageSpecial(ID.text.FLYER_ALREADY)
        end
    end
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.COULLENE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
