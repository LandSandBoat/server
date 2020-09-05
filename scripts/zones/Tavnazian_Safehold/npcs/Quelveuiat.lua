-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Quelveuiat
-- Standard Info NPC
-- !pos -3.177 -22.750 -25.970 26
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local SealionCrestKey = trade:hasItemQty(1658, 1)
    local CoralCrestKey = trade:hasItemQty(1659, 1)
    local Count = trade:getItemCount()

    if (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_COMPLETED and player:hasKeyItem(tpz.ki.TEMPLE_KNIGHT_KEY) == false) then
    -- Trade Sealion and Coral Crest keys to obtain Temple Knight key (keyitem).
        if (SealionCrestKey and CoralCrestKey and Count == 2) then
            player:addKeyItem(tpz.ki.TEMPLE_KNIGHT_KEY)
            player:tradeComplete()
            player:messageSpecial(ID.text.KEYITEM_OBTAINED)
        end
    end

end

function onTrigger(player, npc)

    if (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_AVAILABLE) then
        player:startEvent(119)
    elseif (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_ACCEPTED and player:getCharVar("SPLINTERSPINE_GRUKJUK") <= 1) then
        player:startEvent(120)
    elseif (player:getCharVar("SPLINTERSPINE_GRUKJUK") == 2 and player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_ACCEPTED) then
        player:startEvent(121)
    else
        player:startEvent(122)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 119 and option == 3) then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT)
    elseif (csid == 121) then
        player:setCharVar("SPLINTERSPINE_GRUKJUK", 0)
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT)
        player:addGil(GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2100)
    end

end
