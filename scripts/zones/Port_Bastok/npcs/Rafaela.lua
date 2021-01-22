-----------------------------------
-- Area: Port Bastok
--  NPC: Rafaela
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

player:startEvent(22)

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

PastPerfectVar = player:getCharVar("PastPerfectVar")

    if (csid == 22 and PastPerfectVar == 1) then
        player:setCharVar("PastPerfectVar", 2)
    end

end

return entity
