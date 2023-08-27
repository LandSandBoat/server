-----------------------------------
-- Area: Chateau d'Oraguille
-- Door: Prince Regent's Rm
-- Starts and Finishes Quest: Prelude of Black and White (Start), Pieuje's Decision (Start)
-- !pos -37 -3 31 233
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getNation() == xi.nation.SANDORIA and
        player:getRank(player:getNation()) == 10
    then
        player:startEvent(73)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
