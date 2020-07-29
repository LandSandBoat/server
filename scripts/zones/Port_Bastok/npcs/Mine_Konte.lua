-----------------------------------
-- Area: Port Bastok
--  NPC: Mine Konte
-- Involved in Quest: Out of One's Shell
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    OutOfOneShell = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.OUT_OF_ONE_S_SHELL)

    if (OutOfOneShell == QUEST_ACCEPTED and player:getCharVar("OutOfTheShellZone") == 0) then
        player:startEvent(83)
    else
        player:startEvent(42)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
