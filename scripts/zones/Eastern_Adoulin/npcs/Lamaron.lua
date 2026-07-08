-----------------------------------
-- Area: Eastern Adoulin
--  NPC: Lamaron
-- Type: Warp NPC
-- !pos -52.352 -0.65 96.708 257
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.PIONEERS_BADGE) then
        player:startEvent(590) -- Set sail to Yahse Hunting Grounds.
    else
        player:startEvent(531) -- Refused. Register with the Pioneers' Coalition first.
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 590 and option == 1 then
        player:setPos(363.391, 4.000, -215.002, 128, xi.zone.YAHSE_HUNTING_GROUNDS)
    end
end

return entity
