-----------------------------------
-- Area: Jugner Forest
--  NPC: qm1 (???)
-- Involved in Quest: A Timely Visit
-- !pos -310 0 407
-----------------------------------
ID = require('scripts/zones/Jugner_Forest/IDs')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("Quest[0][105]Prog") ~= 6 then
        player:messageSpecial(ID.text.DUG_UP)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
