-----------------------------------
-- Area: Port Windurst
--  NPC: Door: Departures Exit
-- !pos 218 -5 114 240
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasKeyItem(xi.ki.AIRSHIP_PASS) == true and player:getGil() >= 200) then
        player:startEvent(181, 0, 8, 0, 0, 0, 0, 0, 200)
    else
        player:startEvent(183, 0, 8)
    end
    return 1

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 181) then
        X = player:getXPos()

        if (X >= 221 and X <= 225) then
            player:delGil(200)
        end
    end

end

return entity
