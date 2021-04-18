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
    if player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.BREAKING_BARRIERS and player:getMissionStatus(player:getNation()) == 2 then
        player:addKeyItem(xi.ki.FIGURE_OF_GARUDA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FIGURE_OF_GARUDA)
        player:setMissionStatus(player:getNation(), 3)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
