-----------------------------------
-- Area: Ilrusi Atoll
--  NPC: Rune of Release
-- !pos 412 -9 54 55
-----------------------------------
require("scripts/globals/assault")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance:completed() then
        player:startEvent(100, 4)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.ARRAPAGO_REEF)
    xi.assault.runeReleaseFinish(player, csid, option)
end

return entity
