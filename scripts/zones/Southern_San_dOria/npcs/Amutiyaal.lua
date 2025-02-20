-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Amutiyaal
--  Warp NPC (Aht Urhgan)
-- !pos 116 0.1 84 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

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

entity.onTrade = function(player, npc, trade)
    if
        trade:getGil() == 300 and
        trade:getItemCount() == 1 and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_COMPLETED and
        player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES
    then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(881)
    end
end

entity.onTrigger = function(player, npc)
    local lureSandy = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        lureSandy ~= xi.questStatus.QUEST_COMPLETED and
        xi.settings.main.ENABLE_TOAU == 1
    then
        if lureSandy == xi.questStatus.QUEST_AVAILABLE then
            player:startEvent(812)
        else
            if wildcatSandy == 0 then
                player:startEvent(813)
            elseif utils.mask.isFull(wildcatSandy, 20) then
                player:startEvent(815)
            else
                player:startEvent(814)
            end
        end
    elseif player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        player:startEvent(880)
    else
        player:startEvent(816)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 812 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT)
        player:setCharVar('WildcatSandy', 0)
        npcUtil.giveKeyItem(player, xi.ki.RED_SENTINEL_BADGE)
    elseif csid == 815 then
        player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT)
        player:addFame(xi.fameArea.SANDORIA, 150)
        player:setCharVar('WildcatSandy', 0)
        player:delKeyItem(xi.ki.RED_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.RED_SENTINEL_BADGE)
        npcUtil.giveKeyItem(player, xi.ki.RED_INVITATION_CARD)
    elseif csid == 881 then
        player:tradeComplete()
        xi.teleport.to(player, xi.teleport.id.WHITEGATE)
    end
end

return entity
