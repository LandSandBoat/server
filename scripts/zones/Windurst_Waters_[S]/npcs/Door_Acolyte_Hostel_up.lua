-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door Acolyte hostel
-- Type: Quest NPC
-- !pos 146.619, -8.525, 242.874 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.SAY_IT_WITH_A_HANDBAG) == QUEST_ACCEPTED
        and player:getCharVar("sayItWithAHandbagCS") == 0
    then
        player:startEvent(171)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 171 then
        if option == 1 then
            player:setCharVar("sayItWithAHandbagCS", 1)
        end
    end
end
