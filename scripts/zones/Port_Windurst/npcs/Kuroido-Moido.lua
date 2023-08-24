-----------------------------------
-- Area: Port Windurst (240)
--  NPC: Kuriodo-Moido
-- Involved In Quest: Making Amends, Wonder Wands,
-- Starts and Finishes: Making Amens!, Orastery Woes
-- !pos -112.5 -4.2 102.9 240
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rand = math.random(1, 2)
    if rand == 1 then
        player:startEvent(225)   -- Standard Conversation
    else
        player:startEvent(226)   -- Standard Conversation
    end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
