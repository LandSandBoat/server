-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r9 (Ornate Gate)
-- !pos 139.000 -25.500 60.000 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('X_MARKS_THE_SPOT') == 4 then
        player:startEvent(37)
    elseif npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 37 then
        player:setCharVar('X_MARKS_THE_SPOT', 5)
    end
end

return entity
