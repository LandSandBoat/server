----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Rotih_Moalghett
-- Type: Quest
-- !pos -64 -75 4 96
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_ACCEPTED) then
        if (player:getCharVar("TigressStrikesProg") == 1) then
            player:startEvent(101)
        else
            player:startEvent(104)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 104) then
        player:setCharVar("TigressStrikesProg", 1)
    end
end
