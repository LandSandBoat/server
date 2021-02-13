-----------------------------------
-- Area: West Ronfaure
--  NPC: Laillera
-- !pos -127.297 -62.000 266.800 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_PICKPOCKET) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.LAILLERA_DIALOG + 4)
    else
        player:showText(npc, ID.text.LAILLERA_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
