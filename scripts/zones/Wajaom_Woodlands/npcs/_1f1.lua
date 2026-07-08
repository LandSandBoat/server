-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Engraved Tablet
-- !pos -64 -11 -641 51
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.SICKLEMOON_SALT) then
        player:startEvent(514)
    else
        player:startEvent(516)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 514 and option == 1 then
        player:delKeyItem(xi.ki.SICKLEMOON_SALT)
    end
end

return entity
