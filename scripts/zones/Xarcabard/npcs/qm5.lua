-----------------------------------
-- Area: Xarcabard
--  NPC: qm5 (???)
-- Involved in Quests: Breaking Barriers
-- !pos 179 -33 82 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.BREAKING_BARRIERS and player:getCharVar("MissionStatus") == 2 then
        player:addKeyItem(tpz.ki.FIGURE_OF_GARUDA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FIGURE_OF_GARUDA)
        player:setCharVar("MissionStatus", 3)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
