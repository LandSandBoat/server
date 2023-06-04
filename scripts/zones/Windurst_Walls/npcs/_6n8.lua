-----------------------------------
-- Area: Windurst Walls
--  Door: Priming Gate
--  Involved in quest: Toraimarai Turmoil
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local x = player:getXPos()
    local z = player:getZPos()

    if x >= 1.51 and x <= 9.49 and z >= 273.1 and z <= 281 then
        if player:hasKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) then
            player:startEvent(401)
        else
            player:startEvent(264)
        end
    else
        player:startEvent(395)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
