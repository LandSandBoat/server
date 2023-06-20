-----------------------------------
-- Area: Castle Oztroja
--  NPC: _477 (Brass Door)
-- Notes: Open by 4 torch stands
-- !pos -100 -71 -49 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        player:messageSpecial(ID.text.ITS_LOCKED)
        return 1
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
