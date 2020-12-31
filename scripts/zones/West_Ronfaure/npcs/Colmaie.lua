-----------------------------------
-- Area: West Ronfaure
--  NPC: Colmaie
-- Type: Standard NPC
-- !pos -133.627 -61.999 272.373 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_PICKPOCKET) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.COLMAIE_DIALOG + 5)
    else
        player:showText(npc, ID.text.COLMAIE_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
