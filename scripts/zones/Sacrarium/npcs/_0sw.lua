-----------------------------------
-- Area: Sacrarium
--  NPC: _0sw (Reliquiarium Gate)
-- !pos 23.447 -1.563 50.941 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)

    if (player:getZPos() < 52) then
        player:messageSpecial(ID.text.STURDY_GATE)
    else
        player:messageSpecial(ID.text.KEYHOLE_DAMAGED)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
