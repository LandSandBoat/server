-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Authere
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos 33 1 -31 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('BrothersCS') == 1 then
        player:startEvent(597)  -- brothers cs
    else
        player:startEvent(605)  -- when i grow up im gonna fight like trion
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 597 then
        player:setCharVar('BrothersCS', 0)
    end
end

------- for later use
-- player:startEvent(598)  -- did nothing no cs or speech

return entity
