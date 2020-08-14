-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: ???
-- Involved in Quest: Unforgiven
-- !pos 110.714 -40.856 -53.154 26
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------
-- For those who don't know
-- at the end of if (player:getQuestStatus(REGION, QUEST_NAME)
-- == 0 means QUEST_AVAILABLE
-- == 1 means QUEST_ACCEPTED
-- == 2 means QUEST_COMPLETED
-- e.g. if (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNFORGIVEN) == 0
-- means if (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNFORGIVEN) == QUEST AVAILABLE

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

local Unforgiven = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNFORGIVEN)

    if (Unforgiven == 1 and player:hasKeyItem(tpz.ki.ALABASTER_HAIRPIN) == false) then
        player:addKeyItem(tpz.ki.ALABASTER_HAIRPIN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ALABASTER_HAIRPIN) -- ALABASTER HAIRPIN for Unforgiven Quest

    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

end
