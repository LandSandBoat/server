-----------------------------------
-- Area: Temple of Uggalepih (159)
--  NPC: qm16 (???)
-- Notes: CS for Windurst 9-2
-- !pos -239.442 -1.000 -18.870 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.MOON_READING and player:getCharVar("MissionStatus") >= 1 then
        player:startEvent(68)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 68 then
        npcUtil.giveKeyItem(player, tpz.ki.ANCIENT_VERSE_OF_UGGALEPIH)
    end
end

return entity
