-----------------------------------
-- Area: Sealion's Den
--  NPC: Iron Gate
-- !pos 612 132 774 32
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Sealions_Den/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.bcnm.onTrigger(player, npc) then
        return
    elseif player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_WARRIOR_S_PATH then
        player:startEvent(12)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if xi.bcnm.onEventFinish(player, csid, option) then
        return
    end

    if csid == 12 and option == 1 then
        player:setPos(-31.8, 0, -618.7, 190, 33)
    end
end

return entity
