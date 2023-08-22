-----------------------------------
-- Area: Port San d'Oria
--  NPC: Thierride
-- Type: Quest Giver
-- !pos -67 -5 -28 232
-----------------------------------
-- Starts and Finishes Quest: A Taste For Meat
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM) == QUEST_ACCEPTED then
        if npcUtil.tradeHasExactly(trade, 595) then
            player:startEvent(539)
        else
            player:startEvent(529)
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 539 then
        player:tradeComplete()
        player:setCharVar("TheBrugaireConsortium-Parcels", 31)
    end
end

return entity
