-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Nomad Moogle
-- Type: Adventurer's Assistant
-- !pos 10.012 1.453 121.883 243
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.LIMIT_BREAKER) == false and player:getMainLvl() >= 75 then
        player:startEvent(10045, 75, 2, 10, 7, 30, 302895, 4095)
    elseif player:hasKeyItem(xi.ki.LIMIT_BREAKER) and not player:hasKeyItem(xi.ki.JOB_BREAKER) and player:getMainLvl() >= 99 then
        player:startEvent(10240, 0, 0, 0, 0)
    elseif player:hasKeyItem(xi.ki.LIMIT_BREAKER) == true and player:getMainLvl() >= 75 then
        player:startEvent(10045, 0, 1, 0, 0) -- Default text ID?
    else
        player:startEvent(10045, 0, 2, 0, 0) -- Default text ID?
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10045 then
        if option == 4 then
            player:addKeyItem(xi.ki.LIMIT_BREAKER)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIMIT_BREAKER)
        end
    end

    -- Job Breaker (Enables Capacity/Job Point Acquisition)
    elseif csid == 10240 and option == 28 then
        player:addKeyItem(xi.ki.JOB_BREAKER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.JOB_BREAKER)
    end
end

return entity
