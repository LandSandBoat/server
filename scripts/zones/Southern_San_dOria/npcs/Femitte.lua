-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Femitte
-- Involved in Quest: Lure of the Wildcat (San d'Oria), Distant Loyalties
-- !pos -17 2 10 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DistantLoyaltiesProgress = player:getCharVar("DistantLoyaltiesProgress")
    local DistantLoyalties = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.DISTANT_LOYALTIES)
    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 3) == false) then
        player:startEvent(807)
    elseif (player:getFameLevel(SANDORIA) >= 4 and DistantLoyalties == 0) then
        player:startEvent(663)
    elseif (DistantLoyalties == 1 and DistantLoyaltiesProgress == 1) then
        player:startEvent(664)
    elseif (DistantLoyalties == 1 and DistantLoyaltiesProgress == 4 and player:hasKeyItem(tpz.ki.MYTHRIL_HEARTS)) then
        player:startEvent(665)
    else
        player:startEvent(661)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 807) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 3, true)
    elseif (csid == 663 and option == 0) then
        player:addKeyItem(tpz.ki.GOLDSMITHING_ORDER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.GOLDSMITHING_ORDER)
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.DISTANT_LOYALTIES)
        player:setCharVar("DistantLoyaltiesProgress", 1)
    elseif (csid == 665) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13585)
        else
            player:delKeyItem(tpz.ki.MYTHRIL_HEARTS)
            player:addItem(13585, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13585)
            player:setCharVar("DistantLoyaltiesProgress", 0)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.DISTANT_LOYALTIES)
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
