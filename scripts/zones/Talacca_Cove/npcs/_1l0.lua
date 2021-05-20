-----------------------------------
-- Area: Talacca_Cove
--  NPC: rock slab (corsair job flag quest)
-- !pos -99 -7 -91 57
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if EventTriggerBCNM(player, npc) then
        return
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if EventFinishBCNM(player, csid, option) then
        return
    end

end

return entity
