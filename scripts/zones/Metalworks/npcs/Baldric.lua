-----------------------------------
-- Area: Metalworks
--   NPC: Baldric
-- Type: Quest Giver
-- !pos -50.858 1.777 -31.141 237
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STARDUST) ~= QUEST_AVAILABLE) then
        if (trade:hasItemQty(503, 1) and trade:getItemCount() == 1) then
            player:startEvent(555)
        end
    end

end

function onTrigger(player, npc)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STARDUST) == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 2) then
        player:startEvent(554)
    else
        player:startEvent(552)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 554) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.STARDUST)
    elseif (csid == 555) then
        player:tradeComplete()
        player:addGil(300)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*300)
        player:completeQuest(BASTOK, tpz.quest.id.bastok.STARDUST)
    end
end
