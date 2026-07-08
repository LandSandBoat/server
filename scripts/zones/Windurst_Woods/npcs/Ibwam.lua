-----------------------------------
-- Area: Windurst Woods
--  NPC: Ibwam
-- Type: Warp NPC
-- !pos -25.655 1.749 -60.651 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

--[[
Bitmask Designations:
Windurst Woods (Working in a circuit from Ibwam)
00001    (H-10) Soni-Muni (Bomingo Round, walking the rim of the fountain)
00002    (J-13) Etsa Rhuyuli (atop the Auction House)
00004    (I-10) Cayu Pensharhumi (at the arch in the corridor west of Leviathan's Gate)
00008    (I-5) Umumu (Mithra Groves, at the arch next to the dhalmels.)
00010    (J-3) Nanaa Mihgo (Mithra Groves. North-most cluster)

Windurst Walls (Counter-clockwise)
00020    (J-11) Yoriri (on top of the Auction House)
00040    (K-7) Shantotto (in Shantotto's Manor)
00080    (J-6) Moan-Maon (just west of the Consulate of Jeuno, at the pathway that leads to it)
00100    (H-3) Chomomo (on the East side behind the House of the Hero, go on the path leading North from Gerun-Garun)
00200    (F-5) Naih Arihmepp (wanders along the path by Yoran-Oran's Manor)

Windurst Waters (All NPCs are in North Waters) (North to South)
00400    (G-4) Npopo (right by the gate to Sarutabaruta)
00800    (F-8) Lago-Charago (on top of the Optistery)
01000    (G-9) Amagusa-Chigurusa (South-east part of Huntsman's Court area, top left corner of G-9)
02000    (F-9) Funpo-Shipo (walks along the path outside Timbre Timbers Tavern, on the north side)
04000    (F-10) Kyume-Romeh (bottom floor of Timbre Timber Tavern)

Port Windurst (West to East)
08000    (E-7) Kunchichi (a magic-caster inside the Orastery)
10000    (E-7) Yaman-Hachuman (inside the Orastery, east wall)
20000    (F-6) Choyi Totlihpa (southeast of Consulate of Bastok, entrance of the pathway tunnel)
40000    (G-7) Three of Clubs (standing guard leading to the dock/pier with the Magic/Weapon-Armor shops)
80000    (M-6) Yujuju (outside the Air Travel Agency)
]]--

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { { 'gil', 300 } }) and
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_COMPLETED and
        player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES
    then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(794)
    end
end

entity.onTrigger = function(player, npc)
    local lureWindurst = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        lureWindurst ~= xi.questStatus.QUEST_COMPLETED and
        xi.settings.main.ENABLE_TOAU == 1
    then
        if lureWindurst == xi.questStatus.QUEST_AVAILABLE then
            player:startEvent(736)
        else
            if wildcatWindurst == 0 then
                player:startEvent(737)
            elseif utils.mask.isFull(wildcatWindurst, 20) then
                player:startEvent(739)
            else
                player:startEvent(738)
            end
        end
    elseif player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        player:startEvent(793)
    else
        player:startEvent(740)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 736 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT)
        player:setCharVar('WildcatWindurst', 0)
        npcUtil.giveKeyItem(player, xi.ki.GREEN_SENTINEL_BADGE)
    elseif
        csid == 739 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT, {
            keyItem = xi.ki.GREEN_INVITATION_CARD,
            fame = 150,
            var = 'WildcatWindurst'
        })
    then
        player:delKeyItem(xi.ki.GREEN_SENTINEL_BADGE)
        player:messageSpecial(ID.text.KEYITEM_LOST, xi.ki.GREEN_SENTINEL_BADGE)
    elseif csid == 794 then
        player:confirmTrade()
        xi.teleport.to(player, xi.teleport.id.WHITEGATE)
    end
end

return entity
