-----------------------------------
-- Area: Leujaoam Sanctum
-- Rune of Release
-----------------------------------
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance:completed() then
        player:startEvent(100, 0)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 100 and option == 1 then
        xi.assaultUtil.runeReleaseFinish(player, LEUJAOAM_ASSAULT_POINT)
    end
end

return entity
