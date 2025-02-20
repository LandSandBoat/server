-----------------------------------
-- Area: Port Jeuno
--  NPC: Zedduva
-- !pos -61 7 -54 246
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.AIRSHIP_PASS) and
        player:getGil() >= 200
    then
        player:startEvent(36)
    else
        player:startEvent(44)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 36 then
        local zPos = player:getZPos()

        if zPos >= -61 and zPos <= -58 then
            player:delGil(200)
        end
    end
end

return entity
