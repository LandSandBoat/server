-----------------------------------
-- Area: Windurst Walls
--  Door: Priming Gate
--  Involved in quest: Toraimarai Turmoil
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local x = player:getXPos()
    local z = player:getZPos()

    if x >= 4 and x <= 8 and z >= 276 and z <= 280 then
        if player:hasKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) then
            player:startEvent(401)
        else
            player:startEvent(264)
        end
    elseif x >= 0 and x <= 3 and z >= 270 and z <= 275 then
        player:startEvent(395)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
