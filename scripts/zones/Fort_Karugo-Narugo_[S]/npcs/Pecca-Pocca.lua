-----------------------------------
-- Area: Fort_Karugo-Narugo_[S]
--  NPC: Pecca-Pocca
-- Involved In Quest: REQUIEM_FOR_THE_DEPARTED
-- !pos -163 -68 -155 96
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED) == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.SHEAF_OF_HANDMADE_INCENSE) then
            player:startEvent(233) -- standard dialogue after receiving KI
        else
            player:startEvent(234) -- to receive KI
        end
    else
        player:startEvent(233)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 234 then
        npcUtil.giveKeyItem(player, tpz.ki.SHEAF_OF_HANDMADE_INCENSE)
    end
end
