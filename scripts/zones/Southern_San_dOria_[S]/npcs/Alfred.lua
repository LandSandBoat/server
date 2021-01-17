-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Alfred
-- !pos 94 1 -58 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(314)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 200 and option == 1) then
        player:setPos(94, -62, 266, 40, 81)
    end

end

return entity
