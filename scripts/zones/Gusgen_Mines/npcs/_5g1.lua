-----------------------------------
-- Area: Gusgen Mines
--  NPC: _5g1 (Door B)
-- !pos 20.002 -42.398 -25.499 196
-----------------------------------
local ID = require("scripts/zones/Gusgen_Mines/IDs")
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
