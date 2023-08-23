-----------------------------------
-- Area: Davoi
--  NPC: Wall of Dark Arts
-- Involved in Mission: Magicite
-- !pos -22 1 -66 149
-----------------------------------
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.CREST_OF_DAVOI) then
        player:startEvent(54)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
