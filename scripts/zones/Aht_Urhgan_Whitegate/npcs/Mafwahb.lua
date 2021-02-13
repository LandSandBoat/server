-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Mafwahb
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local LuckOfTheDraw = player:getCharVar("LuckOfTheDraw")

    if LuckOfTheDraw ==1 then
        player:startEvent(548)
        player:setCharVar("LuckOfTheDraw", 2)
    else
        player:startEvent(647)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
