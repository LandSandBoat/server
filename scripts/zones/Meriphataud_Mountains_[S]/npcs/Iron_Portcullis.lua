-----------------------------------
-- Area: Meriphataud_Mountains_[S]
--  NPC: Iron Portcullis
-- !pos 736.952 -34.000 -39.999 97
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(104)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 104 and option == 1 then
        player:setPos(-239.447, 0.25, -19.98, 0, 99)
    end
end

return entity
