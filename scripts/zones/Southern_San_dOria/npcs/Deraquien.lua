-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Deraquien
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -98 -2 31 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(18)
end

---------other CS
--    player:startEvent(654) -- nothing to report
--    player:startEvent(33)-- theif of royl sceptre
--    player:startEvent(47)-- as again about the theif
--    player:startEvent(34) -- reminder of theif in la thein
--    player:startEvent(80)  -- thief caught but phillone was there
--    player:startEvent(20)  -- go get reward for thief
--    player:startEvent(87) -- vijrtall shows up and derq tells you go talk tho phillone
--    player:startEvent(30) --reminder go talk to phillone
--    player:startEvent(38) -- go help  retrieve royal sceptre
--    player:startEvent(27) -- the lady wanst involved in the theft :(

return entity
