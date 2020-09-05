-----------------------------------
-- Area: Metalworks
--   NPC: Hungry Wolf
-- Type: Quest Giver
-- !pos -25.861 -11 -30.172 237
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-- Updated for "Smoke on the Mountain" by EccentricAnata 03.22.13
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN) ~= QUEST_AVAILABLE and
      trade:hasItemQty(4395, 1) and trade:getItemCount() == 1) then
        player:startEvent(429)
    end
--]]
end

function onTrigger(player, npc)

 local SmokeOnTheMountain = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)

    if (SmokeOnTheMountain == QUEST_AVAILABLE) then
        player:startEvent(428)
    else
        player:startEvent(421)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 428) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)
    elseif (csid == 429) then
        player:tradeComplete()
        player:addGil(GIL_RATE*300)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*300)
        player:addTitle(tpz.title.HOT_DOG)
        if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN) == QUEST_ACCEPTED) then
            player:addFame(BASTOK, 30)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.SMOKE_ON_THE_MOUNTAIN)
        else
            player:addFame(BASTOK, 5)
        end
    end
end
