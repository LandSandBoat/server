-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Engraved Tablet
-- !pos 320 -15.35 -379 61
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.SILVER_SEA_SALT) then
        player:startEvent(12)
    else
        player:startEvent(14)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 12 and option == 1 then
        player:delKeyItem(xi.ki.SILVER_SEA_SALT)
    end
end

return entity
