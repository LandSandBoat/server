-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: _0zs
-----------------------------------
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    return 1
end

entity.onTrigger = function(player, npc)
    if (player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)) then
        player:startEvent(112)
    end
    return 1
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)
    if (csid== 112 and option == 1) then
        player:setPos(-20, 0, -355, 192, 34)
    end

end

return entity
