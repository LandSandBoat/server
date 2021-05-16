-----------------------------------
-- Area: La Vaule [S]
--  NPC: _2d1 (Reinforced Gateway)
-- !pos -114.386 -3.599 -179.804 85
-----------------------------------
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
