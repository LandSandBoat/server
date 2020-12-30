-----------------------------------
-- Area: Qufim Island
--  NPC: Nightflowers
-- Involved in Quest: Save My Son (Beastmaster Flag #1)
-- !pos -264.775 -3.718 28.767 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentTime = VanadielHour()

    if currentTime >= 22 or currentTime <= 4 then
        if player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SAVE_MY_SON) == QUEST_ACCEPTED and player:getCharVar("SaveMySon_Event") == 0 then
            player:startEvent(0)
        else
            player:messageSpecial(ID.text.NOW_THAT_NIGHT_HAS_FALLEN)
        end
    else
        player:messageSpecial(ID.text.THESE_WITHERED_FLOWERS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 0 then
        player:setCharVar("SaveMySon_Event", 1)
    end
end
