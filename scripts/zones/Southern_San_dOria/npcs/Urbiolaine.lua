-----------------------------------
-- Area: Southern San d'Oria
-- NPC : Urbiolaine
-- Unity NPC
-----------------------------------
require("scripts/globals/roe")
-----------------------------------
local entity = {}

local function changeUnityLeader(player, leader)
    player:setUnityLeader(leader)

    -- Reset ranking data on change
    player:setCurrency("current_accolades", 0)
    player:setCurrency("prev_accolades", 0)
end

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
        changeUnityLeader(player, option)
        player:setCharVar("unity_changed", 1)
        tpz.roe.onRecordTrigger(player, 5)
    end
end

return entity
