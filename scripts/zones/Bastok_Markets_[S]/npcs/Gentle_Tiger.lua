----------------------------------
-- Area: Bastok Markets [S]
--  NPC: GentleTiger
-- Type: Quest
-- !pos -203  -10  1
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local onSabbatical = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.ON_SABBATICAL)
    local onSabbaticalProgress = player:getCharVar("OnSabbatical")
    if (onSabbatical == QUEST_ACCEPTED) then
        if (onSabbaticalProgress == 1) then
            player:startEvent(46)
        else
            player:startEvent(47)
        end
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_ACCEPTED) then
        if (player:getCharVar("FiresOfDiscProg") == 5) then
            player:startEvent(160)
        else
            player:startEvent(161)
        end
    else
        player:startEvent(109)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 46) then
        player:setCharVar("OnSabbatical", 2)
    elseif (csid == 160) then
        player:setCharVar("FiresOfDiscProg", 6)
    end
end
