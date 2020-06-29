-----------------------------------
-- Area: Port San d'Oria
--  NPC: Answald
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- FLYERS FOR REGINE
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        if player:getCharVar("tradeAnswald") == 0 then
            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:messageSpecial(ID.text.FFR_ANSWALD)
            player:addCharVar("FFR", -1)
            player:setCharVar("tradeAnswald", 1)
            player:confirmTrade()
        else
            player:messageSpecial(ID.text.FLYER_ALREADY)
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_ANSWALD)
    else
        player:startEvent(584)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
