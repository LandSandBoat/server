-----------------------------------
-- Area: Lower Jeuno
--  NPC: Domenic
-- BCNM/KSNM Teleporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY) then
        player:startEvent(10115, player:getGil())
    else
        player:startEvent(10116)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10115 then
        if option == 1 and player:getGil() >= 750 then
            player:delGil(750)
            xi.teleport.to(player, xi.teleport.id.GHELSBA_HUT)
        elseif option == 2 and player:getGil() >= 750 then
            player:delGil(750)
            player:setPos(0, 0, 0, 0, 139)
        elseif option == 3 and player:getGil() >= 750 then
            player:delGil(750)
            player:setPos(0, 0, 0, 0, 144)
        elseif option == 4 and player:getGil() >= 750 then
            player:delGil(750)
            player:setPos(0, 0, 0, 0, 146)
        elseif option == 5 and player:getGil() >= 1000 then
            player:delGil(1000)
            player:setPos(0, 0, 0, 0, 206)
        end
    end
end

return entity
