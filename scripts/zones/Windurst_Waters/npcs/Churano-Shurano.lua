-----------------------------------
-- Area: Windurst Waters
--  NPC: Churano-Shurano
-- !pos -60.8 -11.2 98.9 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MAGICKED_ASTROLABE) then
        local cost = 10000
        if player:getLocalVar('Astrolabe') == 0 then
            player:startEvent(1080, cost)
        else
            player:startEvent(1081, cost)
        end
    else
        player:startEvent(280)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 1080 or csid == 1081 then
        if option == 1 and player:getGil() >= 10000 then
            player:updateEvent(xi.ki.MAGICKED_ASTROLABE)
        else
            player:updateEvent(0)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1080 and option ~= xi.ki.MAGICKED_ASTROLABE then
        player:setLocalVar('Astrolabe', 1)
    elseif
        (csid == 1080 or csid == 1081) and
        option == xi.ki.MAGICKED_ASTROLABE and
        player:getGil() >= 10000
    then
        npcUtil.giveKeyItem(player, xi.ki.MAGICKED_ASTROLABE)
        player:delGil(10000)
    end
end

return entity
