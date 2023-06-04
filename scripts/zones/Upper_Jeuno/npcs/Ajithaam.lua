-----------------------------------
-- Area: Upper Jeuno
--  NPC: Ajithaam
-- !pos -82 0.1 160 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

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

entity.onTrade = function(player, npc, trade)
    if
        trade:getGil() == 300 and
        trade:getItemCount() == 1 and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_COMPLETED and
        player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES
    then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(10177)
    end
end

entity.onTrigger = function(player, npc)
    local lureJeuno = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")

    if lureJeuno ~= 2 and xi.settings.main.ENABLE_TOAU == 1 then
        if lureJeuno == 0 then
            player:startEvent(10088)
        else
            if wildcatJeuno == 0 then
                player:startEvent(10089)
            elseif utils.mask.isFull(wildcatJeuno, 20) then
                player:startEvent(10091)
            else
                player:startEvent(10090)
            end
        end
    elseif player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        player:startEvent(10176)
    else
        player:startEvent(10092)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10088 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT)
        player:setCharVar("WildcatJeuno", 0)
        player:addKeyItem(xi.ki.WHITE_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHITE_SENTINEL_BADGE)
    elseif csid == 10091 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT)
        player:addFame(xi.quest.fame_area.JEUNO, 150)
        player:setCharVar("WildcatJeuno", 0)
        player:delKeyItem(xi.ki.WHITE_SENTINEL_BADGE)
        player:addKeyItem(xi.ki.WHITE_INVITATION_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.WHITE_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHITE_INVITATION_CARD)
    elseif csid == 10177 then
        player:tradeComplete()
        xi.teleport.to(player, xi.teleport.id.WHITEGATE)
    end
end

return entity
