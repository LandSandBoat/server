-----------------------------------
-- Area: Windurst Waters
--  NPC: Churano-Shurano
-- !pos -60.8 -11.2 98.9 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Day (280) vs night (281): he can only observe the stars at night.
    local hour    = VanadielHour()
    local ambient = (hour >= 18 or hour < 6) and 281 or 280

    if player:hasKeyItem(xi.ki.MAGICKED_ASTROLABE) then
        player:startEvent(ambient)
    elseif math.randomInt(1, 100) <= 50 then
        player:startEvent(ambient)
    else
        local cost = 10000
        if player:getLocalVar('Astrolabe') == 0 then
            player:startEvent(1080, cost)
        else
            player:startEvent(1081, cost)
        end
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
