-----------------------------------
-- Area: Fort_Karugo-Narugo_[S]
--  NPC: Pecca-Pocca
-- Involved In Quest: REQUIEM_FOR_THE_DEPARTED
-- !pos -163 -68 -155 96
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.REQUIEM_FOR_THE_DEPARTED) == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SHEAF_OF_HANDMADE_INCENSE) then
            player:startEvent(233) -- standard dialogue after receiving KI
        else
            player:startEvent(234) -- to receive KI
        end
    else
        player:startEvent(233)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 234 then
        npcUtil.giveKeyItem(player, xi.ki.SHEAF_OF_HANDMADE_INCENSE)
    end
end

return entity
