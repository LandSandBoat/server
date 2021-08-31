-----------------------------------
-- Area: North Gustaberg (S) (J-9)
--  NPC: Solitary Ant
-- Involved in Quests: Fire in the Hole
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    player:startEvent(112)

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

end

return entity
