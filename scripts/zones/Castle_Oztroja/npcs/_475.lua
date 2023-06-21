-----------------------------------
-- Area: Castle Oztroja
--  NPC: _475 (Brass Door)
-- Involved in Mission: Magicite
-- !pos -99 24 -105 151
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
