-----------------------------------
-- Area: Valley of Sorrows
--  NPC: qm2 (???)
-- Note: Used to rank 9.1 San d'oria
-- !pos 91 -3 -16 128
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.BREAKING_BARRIERS and player:getMissionStatus(player:getNation()) == 1) then
        player:addKeyItem(xi.ki.FIGURE_OF_TITAN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FIGURE_OF_TITAN)
        player:setMissionStatus(player:getNation(), 2)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
