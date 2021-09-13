-----------------------------------
-- Area: The Boyahda Tree
--  NPC: Mandragora Warden
-- Type: Mission NPC
-- !pos 81.981 7.593 139.556 153
-----------------------------------
local ID = require("scripts/zones/The_Boyahda_Tree/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local missionStatus = player:getMissionStatus(player:getNation())

    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.DOLL_OF_THE_DEAD and (missionStatus == 4 or missionStatus == 5) and npcUtil.tradeHas(trade, 1181) then
        player:startEvent(13)
    end
end

entity.onTrigger = function(player, npc)
    if player:getMissionStatus(player:getNation()) == 4  or player:getMissionStatus(player:getNation()) == 5 then
        player:messageText(npc, ID.text.WARDEN_SPEECH)
        player:messageSpecial(ID.text.WARDEN_TRANSLATION)
    else
        player:startEvent(10)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 13 then
        player:setMissionStatus(player:getNation(), 6)
        npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_ZONPA_ZIPPA)
    end
end

return entity
