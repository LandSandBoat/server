-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Cermet Portal (Security Gate)
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getXPos() < -440 then
        player:messageSpecial(ID.text.DOES_NOT_RESPOND)
        return 1
    end

    return -1
end

return entity
