-----------------------------------
-- Area: Port Bastok
--  NPC: Rajesh
-- !pos -62 1 -8 236
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasKeyItem(xi.ki.AIRSHIP_PASS) == true and player:getGil() >= 200) then
        player:startEvent(141)
    else
        player:startEvent(142)
    end
    return 1

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 141 and option == 0) then
        X = player:getXPos()

        if (X >= -58 and X <= -55) then
            player:delGil(200)
        end
    end

end

return entity
