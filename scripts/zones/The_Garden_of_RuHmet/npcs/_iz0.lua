-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: Cermet Portal (Security Gate)
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() > -400 then
        player:messageSpecial(ID.text.PORTAL_WONT_OPEN_ON_THIS_SIDE)
        return 1
    end

    return -1
end

return entity
