-----------------------------------
-- Area: Port Bastok
--  NPC: Agapito
-- Start & Finishes Quest: The Stars of Ifrit
-- !pos -72.093 -3.097 9.309 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TheStarsOfIfrit = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_STARS_OF_IFRIT)

    if (player:getFameLevel(BASTOK) >= 3 and TheStarsOfIfrit == QUEST_AVAILABLE and player:hasKeyItem(tpz.ki.AIRSHIP_PASS) == true) then
        player:startEvent(180)
    elseif (TheStarsOfIfrit == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.CARRIER_PIGEON_LETTER) == true) then
        player:startEvent(181)
    else
        player:startEvent(17)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 180) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.THE_STARS_OF_IFRIT)
    elseif (csid == 181) then
        player:addGil(GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2100)
        player:addFame(BASTOK, 100)
        player:addTitle(tpz.title.STAR_OF_IFRIT)
        player:completeQuest(BASTOK, tpz.quest.id.bastok.THE_STARS_OF_IFRIT)
    end
end
