-----------------------------------
-- Area: Southern San d'Oria
-- NPC : Urbiolaine
-- Unity NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- Check player total records completed
    if player:getNumEminenceCompleted() < 10 then
        player:startEvent(3528)

    -- Check for "All for One"
    elseif not player:hasEminenceRecord(5) then
        player:startEvent(3525)

    -- First time selecting Unity
    elseif not player:getEminenceCompleted(5) then
        player:startEvent(3526)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 3526 and
        option >= 1 and
        option <= 11
    then
        -- Set unity, complete quest, set charvar for has changed this week
    end
end

return entity
