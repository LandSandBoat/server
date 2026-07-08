-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: Treasure Chest
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.events.strangeHappenings.hasClaimed(player, npc) then
        player:messageSpecial(ID.text.CHEST_WONT_OPEN)
        return
    end

    player:startEvent(414)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 414 then
        xi.events.strangeHappenings.onChestTrigger(player, npc)
    end
end

return entity
