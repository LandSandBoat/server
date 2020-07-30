-----------------------------------
-- Area: Metalworks
--  NPC: Franziska
-- Type: Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
if (player:getCharVar("OptionalcsCornelia") ==1) then
player:startEvent(777)
else
player:startEvent(620)
end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
if (csid == 777) then
player:setCharVar("OptionalcsCornelia", 0)
end
end
