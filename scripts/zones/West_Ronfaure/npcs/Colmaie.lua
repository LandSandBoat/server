-----------------------------------
-- Area: West Ronfaure
--  NPC: Colmaie
-- Type: Standard NPC
-- !pos -133.627 -61.999 272.373 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_PICKPOCKET) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.COLMAIE_DIALOG + 5)
    else
        player:showText(npc, ID.text.COLMAIE_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
