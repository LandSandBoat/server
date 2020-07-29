-----------------------------------
-- Area: Rabao
--   NPC: Dancing Wolf
-- Type: Standard NPC
-- !pos 7.619 7 81.209 247
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH and player:getCharVar("BASTOK91") == 1) then
player:startEvent(102)
elseif (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH and player:getCharVar("BASTOK91") == 2) then
player:startEvent(103)
elseif (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH and player:getCharVar("BASTOK91") == 3 and player:hasKeyItem(tpz.ki.MIRACLESALT)) then
player:startEvent(104)
elseif (player:getCharVar("BASTOK91") == 4) then
player:startEvent(105)
else
player:startEvent(106)
end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
if (csid == 102) then
player:setCharVar("BASTOK91", 2)
elseif (csid == 104) then
player:setCharVar("BASTOK91", 4)
end
end
