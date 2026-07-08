-----------------------------------
-- Area: Leujaoam Sanctum
-- Rune of Release
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance and instance:completed() then
        player:startEvent(100, 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.runeReleaseFinish(player, csid, option, npc, xi.zone.CAEDARVA_MIRE)
end

return entity
