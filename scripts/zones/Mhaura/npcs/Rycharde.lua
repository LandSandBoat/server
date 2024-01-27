-----------------------------------
-- Area: Mhaura
--  NPC: Rycharde
-----------------------------------
-- Used in: scripts/quests/otherAreas/Rycharde_the_Chef.lua
-- Used in: scripts/quests/otherAreas/Way_of_the_Cook.lua
-- Used in: scripts/quests/otherAreas/Unending_Chase.lua
-- Used in: scripts/quests/otherAreas/His_Name_is_Valgeir.lua
-- Used in: scripts/quests/otherAreas/The_Clue.lua
-- Used in: scripts/quests/otherAreas/The_Basics.lua
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- player:startEvent(69) -- POSIBLE default dialog
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
