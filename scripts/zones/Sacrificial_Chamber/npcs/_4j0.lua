-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Mahogany Door
-- !pos 299 0.1 349 163
-----------------------------------
local ID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.bcnm.onTrigger(player, npc) then
        player:messageSpecial(ID.text.DOOR_SHUT)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.bcnm.onEventFinish(player, csid, option, npc)
end

return entity
