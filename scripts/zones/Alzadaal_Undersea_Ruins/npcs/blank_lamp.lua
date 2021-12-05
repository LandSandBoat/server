-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: 19 (no name)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and player:getCharVar("AhtUrganStatus") == 0 then
        player:startEvent(8)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 8 then
        player:setCharVar("AhtUrganStatus", 1)
    end
end

return entity
