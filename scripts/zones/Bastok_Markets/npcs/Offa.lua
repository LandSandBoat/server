-----------------------------------
-- Area: Bastok Markets
--   NPC: Offa
-- Type: Quest NPC
-- !pos -281.628 -16.971 -140.607 235
--
-- Auto-Script: Requires Verification. Verified standard dialog - thrydwolf 12/18/2011
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local SmokeOnTheMountain = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)
    if (SmokeOnTheMountain == QUEST_ACCEPTED) then
        player:startEvent(222)
    else
        player:startEvent(124)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
