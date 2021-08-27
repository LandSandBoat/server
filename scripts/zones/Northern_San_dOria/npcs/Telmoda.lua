-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Telmoda
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local Telmoda_Madaline = player:getCharVar("Telmoda_Madaline_Event")

    if (Telmoda_Madaline ~= 1) then
        player:setCharVar("Telmoda_Madaline_Event", 1)
        player:startEvent(531)
    else
        player:startEvent(616)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
