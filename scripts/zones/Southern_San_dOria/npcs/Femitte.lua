-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Femitte
-- Involved in Quest: Lure of the Wildcat (San d'Oria), Distant Loyalties
-- !pos -17 2 10 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local distantLoyaltiesProgress = player:getCharVar("DistantLoyaltiesProgress")
    local distantLoyalties = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.DISTANT_LOYALTIES)
    local wildcatSandy = player:getCharVar("WildcatSandy")

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 3)
    then
        player:startEvent(807)
    elseif
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 4 and
        distantLoyalties == 0
    then
        player:startEvent(663)
    elseif distantLoyalties == 1 and distantLoyaltiesProgress == 1 then
        player:startEvent(664)
    elseif
        distantLoyalties == 1 and
        distantLoyaltiesProgress == 4 and
        player:hasKeyItem(xi.ki.MYTHRIL_HEARTS)
    then
        player:startEvent(665)
    else
        player:startEvent(661)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 807 then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 3, true))
    elseif csid == 663 and option == 0 then
        player:addKeyItem(xi.ki.GOLDSMITHING_ORDER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.GOLDSMITHING_ORDER)
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.DISTANT_LOYALTIES)
        player:setCharVar("DistantLoyaltiesProgress", 1)
    elseif csid == 665 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13585)
        else
            player:delKeyItem(xi.ki.MYTHRIL_HEARTS)
            player:addItem(13585, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13585)
            player:setCharVar("DistantLoyaltiesProgress", 0)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.DISTANT_LOYALTIES)
        end
    end
end

--------Other CS
--32692
--0
--661  Standard dialog
--663
--664
--665
--725
--747
--748
--807  Lure of the Wildcat
--945  CS with small mythra dancer

return entity
