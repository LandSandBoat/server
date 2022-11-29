-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Cermet Portal (Security Gate)
--   ID: 16916869
--  !pos -240 -2.05 460
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getXPos() < -240 then
        player:messageSpecial(ID.text.PORTAL_DOES_NOT_RESPOND)
        return 1
    end

    return -1
end

return entity
