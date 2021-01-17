-----------------------------------
-- Area: Port San d'Oria
--  NPC: Anton
-- !pos -19 -8 27 232
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS) == false) then
        player:startEvent(517)
    elseif (player:getGil() < 200) then
        player:startEvent(716)
    else
        player:startEvent(604)
    end
    return 1

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 604) then
        X = player:getXPos()

        if (X >= -13 and X <= -8) then
            player:delGil(200)
        end
    end

end

return entity
