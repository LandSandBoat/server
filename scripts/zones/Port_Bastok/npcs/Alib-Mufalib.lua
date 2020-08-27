-----------------------------------
-- Area: Port Bastok
--  NPC: Alib-Mufalib
-- Type: Warp NPC
-- !pos 116.080 7.372 -31.820 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Port_Bastok/IDs")

--[[
Bitmask Designations:
Port Bastok (East to West)
00001   (J-5) Kaede (northernmost house)
00002   (F-5) Patient Wheel (north of Warehouse 2)
00004   (F-6) Paujean (bottom floor of Warehouse 2)
00008   (E-6) Hilda (Steaming Sheep Restaurant, walks on the top floor and occasionally down. However, she can still be talked to when on second floor. Unable to get if you have Cid's Secret flagged.)
00010   (F-8) Tilian (end of a pier west of Air Travel Agency)

Metalworks (all found on top floor)
00020    (G-8) Raibaht (Cid's lab)
00040    (G-8) Invincible Shield (outside Cid's Lab)
00080    (G-7) Manilam (on top of Cermet Refinery)
00100    (I-8) Kaela (between Consulate of Windurst & Consulate of Bastok)
00200    (K-7) Ayame (Inside north Cannonry)

Bastok Markets (East to West)
00400    (K-10) Harmodios (Harmodios's Music Shop)
00800    (J-10) Arawn (west of music store)
01000    (I-9) Horatius (Inside Trader's Home)
02000    (E-10) Ken (outside Mjoll's General Goods)
04000    (E-11) Pavel (West Gate to South Gustaberg)

Bastok Mines (Clockwise, starting at Ore Street, upper floor to lower floor)
08000    (H-5) Griselda (upper floor, Bat's Lair Inn)
10000    (I-6) Goraow (upper floor, in stairwell of Ore Street)
20000    (I-7) Echo Hawk (lower floor, Ore Street)
40000    (H-6) Deidogg (lower floor, Ore Street)
80000    (H-9) Vaghron (southwest of South Auction House)
]]--

function onTrade(player, npc, trade)
    if (trade:getGil() == 300 and trade:getItemCount() == 1 and player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_COMPLETED and player:getCurrentMission(TOAU) > tpz.mission.id.toau.IMMORTAL_SENTRIES) then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(379)
    end
end

function onTrigger(player, npc)
    local LureBastok = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT)
    local WildcatBastok = player:getCharVar("WildcatBastok")
    if (LureBastok ~= 2 and ENABLE_TOAU == 1) then
        if (LureBastok == 0) then
            player:startEvent(357)
        else
            if (WildcatBastok == 0) then
                player:startEvent(358)
            elseif (player:isMaskFull(WildcatBastok, 20) == true) then
                player:startEvent(360)
            else
                player:startEvent(359)
            end
        end
    elseif (player:getCurrentMission(TOAU) >= tpz.mission.id.toau.PRESIDENT_SALAHEEM) then
        player:startEvent(378)
    else
        player:startEvent(361)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 357) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT)
        player:setCharVar("WildcatBastok", 0)
        player:addKeyItem(tpz.ki.BLUE_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLUE_SENTINEL_BADGE)
    elseif (csid == 360) then
        player:completeQuest(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT)
        player:addFame(BASTOK, 150)
        player:setCharVar("WildcatBastok", 0)
        player:delKeyItem(tpz.ki.BLUE_SENTINEL_BADGE)
        player:addKeyItem(tpz.ki.BLUE_INVITATION_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.BLUE_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLUE_INVITATION_CARD)
    elseif (csid == 379) then
        player:tradeComplete()
        tpz.teleport.to(player, tpz.teleport.id.WHITEGATE)
    end
end
