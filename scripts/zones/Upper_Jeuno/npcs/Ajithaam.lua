-----------------------------------
-- Area: Upper Jeuno
--  NPC: Ajithaam
-- !pos -82 0.1 160 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Upper_Jeuno/IDs")

--[[
Bitmask Designations:
Ru'Lude Gardens (South to North)
00001    (H-9) Albiona (near the downstairs fountain and embassies)
00002    (G-8) Crooked Arrow (by the steps leading to the Auction House)
00004    (H-7) Muhoho (upstairs on the palace balcony)
00008    (G-7) Adolie (in the palace Guard Post)
00010    (I-6) Yavoraile (in the palace Dining Hall)

Upper Jeuno (North to South)
00020    (G-7) Sibila-Mobla (wanders outside M&P's Market)
00040    (G-8) Shiroro (in the house with Nekha Shachaba outside)
00080    (G-8) Luto Mewrilah (north-west of the Temple of the Goddess)
00100    (H-9) Renik (Just east of the Temple of the Goddess)
00200    (H-9) Hinda (inside the Temple of the Goddess, she is the first person on the left as you enter)

Lower Jeuno (North to South)
00400    (J-7) Sutarara (Neptune's Spire Inn, 2nd door on the left, outside of the Tenshodo)
00800    (I-7) Saprut (top of the stairs above AH)
01000    (H-9) Bluffnix (Gobbiebag quest NPC, in Muckvix's Junk Shop)
02000    (H-10) Naruru (Merchant's House on the middle level above Muckvix's Junk Shop)
04000    (G-10) Gurdern (across from the Chocobo Stables)

Port Jeuno (West to East)
08000    (G-8) Red Ghost (pacing back and forth between Bastok & San d'Oria Air Travel Agencies)
10000    (H-8) Karl (Show all three kids the badge)
20000    (H-8) Shami (BCNM Orb NPC)
40000    (I-8) Rinzei (west of the Windurst Airship Agency, next to Sagheera)
80000    (I-8) Sagheera (west of the Windurst Airship Agency)
]]--

function onTrade(player, npc, trade)
    if (trade:getGil() == 300 and trade:getItemCount() == 1 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_COMPLETED and player:getCurrentMission(TOAU) > tpz.mission.id.toau.IMMORTAL_SENTRIES) then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(10177)
    end
end

function onTrigger(player, npc)
    local LureJeuno = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (LureJeuno ~= 2 and ENABLE_TOAU == 1) then
        if (LureJeuno == 0) then
            player:startEvent(10088)
        else
            if (WildcatJeuno == 0) then
                player:startEvent(10089)
            elseif (player:isMaskFull(WildcatJeuno, 20) == true) then
                player:startEvent(10091)
            else
                player:startEvent(10090)
            end
        end
    elseif (player:getCurrentMission(TOAU) >= tpz.mission.id.toau.PRESIDENT_SALAHEEM) then
        player:startEvent(10176)
    else
        player:startEvent(10092)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10088) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT)
        player:setCharVar("WildcatJeuno", 0)
        player:addKeyItem(tpz.ki.WHITE_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WHITE_SENTINEL_BADGE)
    elseif (csid == 10091) then
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT)
        player:addFame(JEUNO, 150)
        player:setCharVar("WildcatJeuno", 0)
        player:delKeyItem(tpz.ki.WHITE_SENTINEL_BADGE)
        player:addKeyItem(tpz.ki.WHITE_INVITATION_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.WHITE_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WHITE_INVITATION_CARD)
    elseif (csid == 10177) then
        player:tradeComplete()
        tpz.teleport.to(player, tpz.teleport.id.WHITEGATE)
    end
end
