-----------------------------------
-- Area: La Theine Plateau
--  NPC: Chocobo Tracks
-- Involved in quest: Chocobo on the Loose!
-- !pos -556 0 523 102
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE) == QUEST_ACCEPTED and player:getCharVar("ChocoboOnTheLoose") < 2) then
        player:startEvent(209)
    else
        player:messageSpecial(ID.text.CHOCOBO_TRACKS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 209) then
        player:setCharVar("ChocoboOnTheLoose", 2)
    end
end
