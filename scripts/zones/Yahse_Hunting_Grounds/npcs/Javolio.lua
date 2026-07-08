-----------------------------------
-- Area: Yahse Hunting Grounds
--  NPC: Javolio
-- Type: Warp NPC
-- !pos 358.2 4 -215 260
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.PIONEERS_BADGE) then
        player:startEvent(504) -- Set sail to Eastern Adoulin.
    else
        player:startEvent(511) -- Refused. Register with the Pioneers' Coalition first.
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 504 and option == 1 then
        player:setPos(-56.000, -0.650, 96.000, 64, xi.zone.EASTERN_ADOULIN)
    end
end

return entity
