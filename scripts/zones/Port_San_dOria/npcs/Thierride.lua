-----------------------------------
-- Area: Port San d'Oria
--  NPC: Thierride
-- Type: Quest Giver
-- !pos -67 -5 -28 232
-----------------------------------
-- Starts and Finishes Quest: A Taste For Meat
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM) == QUEST_ACCEPTED and
        trade:hasItemQty(595, 1) and
        trade:getItemCount() == 1
    then
        player:tradeComplete()
        player:startEvent(539)
        player:setCharVar("TheBrugaireConsortium-Parcels", 31)
    else
        player:startEvent(529)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
