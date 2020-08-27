-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Amutiyaal
--  Warp NPC (Aht Urhgan)
-- !pos 116 0.1 84 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/quests")
-------------------------------------

--[[
Bitmask Designations:
Southern San d'Oria (East to West)
00001    (K-5) Daggao (Lion Springs Tavern)
00002    (J-9) Authere (a small boy under a tree to the east of the Auction House)
00004    (I-8) Rouva (under a tree in west Victory Square)
00008    (I-8) Femitte (Rouva's attache)
00010    (G-8) Deraquien (guarding entrance to Watchdog Alley)

Northern San d'Oria (South to North)
00020    (I-9) Giaunne (west of the fountain)
00040    (J-8) Anilla (north of the fountain)
00080    (J-8) Maloquedil (east of Anilla, under a tree)
00100    (H-8) Phairupegiont (north of Windurstian Consul, looking into the moat)
00200    (E-4) Bertenont (upstairs outside the Royal Armoury)

Port San d'Oria (West to East)
00400    (G-7) Perdiouvilet (Rusty Anchor Pub)
00800    (H-8) Pomilla (outside the Rusty Anchor, watching Joulet fish)
01000    (H-8) Cherlodeau (just before the docks where two fisherman are having a contest)
02000    (H-10) Parcarin (on top of the Auction House)
04000    (J-8) Rugiette (Regine's Magicmart)

Chateau d'Oraguille (East to West)
08000    (I-9) Curilla (Temple Knights' Quarters)
10000    (I-9) Halver (main room)
20000    (H-9) Rahal (Royal Knights' Quarters)
40000    (H-7) Perfaumand (guarding Prince Royal Trion I d'Oraguille's Room)
80000    (F-7) Chalvatot (Her Majesty's garden)
--]]

function onTrade(player, npc, trade)
    if (trade:getGil() == 300 and trade:getItemCount() == 1 and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_COMPLETED and player:getCurrentMission(TOAU) > tpz.mission.id.toau.IMMORTAL_SENTRIES) then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(881)
    end
end

function onTrigger(player, npc)

    local LureSandy = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT)
    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (LureSandy ~= QUEST_COMPLETED and ENABLE_TOAU == 1) then
        if (LureSandy == QUEST_AVAILABLE) then
            player:startEvent(812)
        else
            if (WildcatSandy == 0) then
                player:startEvent(813)
            elseif (player:isMaskFull(WildcatSandy, 20) == true) then
                player:startEvent(815)
            else
                player:startEvent(814)
            end
        end
    elseif (player:getCurrentMission(TOAU) >= tpz.mission.id.toau.PRESIDENT_SALAHEEM) then
        player:startEvent(880)
    else
        player:startEvent(816)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 812) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT)
        player:setCharVar("WildcatSandy", 0)
        player:addKeyItem(tpz.ki.RED_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RED_SENTINEL_BADGE)
    elseif (csid == 815) then
        player:completeQuest(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT)
        player:addFame(SANDORIA, 150)
        player:setCharVar("WildcatSandy", 0)
        player:delKeyItem(tpz.ki.RED_SENTINEL_BADGE)
        player:addKeyItem(tpz.ki.RED_INVITATION_CARD)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.RED_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RED_INVITATION_CARD)
    elseif (csid == 881) then
        player:tradeComplete()
        tpz.teleport.to(player, tpz.teleport.id.WHITEGATE)
    end
end
