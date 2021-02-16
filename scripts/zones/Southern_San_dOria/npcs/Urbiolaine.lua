-----------------------------------
-- Area: Southern San d'Oria
-- NPC : Urbiolaine
-- Unity NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

local function changeUnityLeader(player, leader)
    player:setUnityLeader(leader)
    player:setCharVar("unity_changed", 1)

    -- Reset ranking data on change
    player:setCurrency("current_accolades", 0)
    player:setCurrency("prev_accolades", 0)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local hasAllForOne = player:hasEminenceRecord(5)
    local allForOneCompleted = player:getEminenceCompleted(5)
    local accolades = player:getCurrency("unity_accolades")
    local remainingLimit = WEEKLY_EXCHANGE_LIMIT - player:getCharVar("weekly_accolades_spent")

    -- Check player total records completed
    if player:getNumEminenceCompleted() < 10 then
        player:startEvent(3528)

    -- Check for "All for One"
    elseif not hasAllForOne and not allForOneCompleted then
        player:startEvent(3525)

    -- First time selecting Unity
    elseif not allForOneCompleted then
        player:startEvent(3526)
    else
        player:startEvent(3529, 0, 0, accolades, remainingLimit)
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
        tpz.roe.onRecordTrigger(player, 5)
        player:messageSpecial(ID.text.YOU_HAVE_JOINED_UNITY, option)
    end
end

return entity
