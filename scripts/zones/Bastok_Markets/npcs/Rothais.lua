-----------------------------------
-- Area: Bastok Markets
--  NPC: Rothais
-- Involved in Quest: Gourmet
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local vanatime = VanadielHour()

    if vanatime >= 18 or vanatime < 6 then
        player:startEvent(204)
    elseif vanatime >= 6 and vanatime < 12 then
        player:startEvent(205)
    else
        player:startEvent(206)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
