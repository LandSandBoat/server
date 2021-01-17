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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Unforgiven = player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.UNFORGIVEN)

    if (Unforgiven == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.ALABASTER_HAIRPIN) == false) then
        player:addKeyItem(tpz.ki.ALABASTER_HAIRPIN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ALABASTER_HAIRPIN) -- ALABASTER HAIRPIN for Unforgiven Quest
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

end
