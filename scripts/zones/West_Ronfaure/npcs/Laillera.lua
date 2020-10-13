-----------------------------------
-- Area: West Ronfaure
--  NPC: Laillera
-- !pos -127.297 -62.000 266.800 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_PICKPOCKET) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.LAILLERA_DIALOG + 4)
    else
        player:showText(npc, ID.text.LAILLERA_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
