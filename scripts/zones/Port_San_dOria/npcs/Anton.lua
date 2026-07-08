-----------------------------------
-- Area: Port San d'Oria
--  NPC: Anton
-- !pos -19 -8 27 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
        player:startEvent(517)
    elseif player:getGil() < 200 then
        player:startEvent(716)
    else
        player:startEvent(604)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 604 then
        local xPos = player:getXPos()

        if xPos >= -13 and xPos <= -8 then
            player:delGil(200)
        end
    end
end

return entity
