-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Exoroche
-- Involved in Quests: Father and Son, A Boy's Dream
-- !pos 72 -1 60 230
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

------- used in expansions
--    player:startEvent(946)  -- you want to hear of my father go talk to albieche
--    player:startEvent(947) -- trainees spectacles

return entity
