-----------------------------------
-- Area: Port Jeuno
--  NPC: Door: Departures Exit (for Windurst)
-- !pos 3 7 -54 246
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.AIRSHIP_PASS) and
        player:getGil() >= 200
    then
        player:startEvent(39)
    else
        player:startEvent(47)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 39 then
        local zPos = player:getZPos()

        if zPos >= -61 and zPos <= -58 then
            player:delGil(200)
        end
    end
end

return entity
