-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Indescript Markings
-- !pos 322 24 113
-- Quest NPC
-----------------------------------
require("scripts/globals/campaign")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX) == QUEST_ACCEPTED and player:getCharVar("DownwardHelix") == 3) then
        player:startEvent(4)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 4) then
        player:setCharVar("DownwardHelix", 4)
    end
end
