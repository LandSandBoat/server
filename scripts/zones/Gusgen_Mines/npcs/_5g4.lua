-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g4 (Door E)
-- !pos 19.998 -22.4 174.506 196
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        player:messageSpecial(ID.text.LOCK_OTHER_DEVICE)
    else
        return 0
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
