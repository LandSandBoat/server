-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: Treasure Chest
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.events.strangeHappenings.hasClaimed(player, npc) then
        player:messageSpecial(ID.text.CHEST_WONT_OPEN)
        return
    end

    player:startEvent(81)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 81 then
        xi.events.strangeHappenings.onChestTrigger(player, npc)
    end
end

return entity
