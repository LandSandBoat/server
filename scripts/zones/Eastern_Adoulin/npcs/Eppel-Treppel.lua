-----------------------------------
-- Area: Eastern Adoulin (257)
--  NPC: Eppel-Treppel
-- Speak to Eppel-Treppel to enter the Celennia Memorial Library.
-- !pos -90.922 -2.650 -80.891 257
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(591)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 591 and option == 1 then
        player:setPos(-97, -2, -87, 96, 284)
    end
end

return entity
