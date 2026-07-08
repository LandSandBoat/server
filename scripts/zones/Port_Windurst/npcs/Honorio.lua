-----------------------------------
-- Area: Port Windurst
--  NPC: Honorio
-- !pos 218 -5 114 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) and player:getGil() >= 200 then
        player:startEvent(181, 0, 8, 0, 0, 0, 0, 0, 200)
    else
        player:startEvent(183, 0, 8)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 181 then
        local xPos = player:getXPos()

        if xPos >= 222 and xPos <= 225 then
            player:delGil(200)
        end
    end
end

return entity
