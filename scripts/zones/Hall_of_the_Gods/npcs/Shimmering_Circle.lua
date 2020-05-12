-----------------------------------
-- Area: Hall of the Gods
--  NPC: Shimmering Circle
-- Lifts players up to the sky!
-- !pos 0 -20 147 251
-----------------------------------
require("scripts/globals/keyitems");
require("scripts/globals/missions");
local ID = require("scripts/zones/Hall_of_the_Gods/IDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local ZilartProgress = player:getCurrentMission(ZILART);
    local ZVar = player:getCharVar("ZilartStatus");

    if (player:getZPos() < 200) then
        if (ZilartProgress == tpz.mission.id.zilart.THE_GATE_OF_THE_GODS and ZVar == 0) then
            player:startEvent(3); -- First time.
        elseif (ZilartProgress ~= tpz.mission.id.zilart.NONE and ZilartProgress > tpz.mission.id.zilart.THE_GATE_OF_THE_GODS or -- If player has not done any ZM, Progress == 255
         (ZilartProgress == tpz.mission.id.zilart.THE_GATE_OF_THE_GODS and ZVar > 0)) then
            player:startEvent(10);
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY);
        end
    else
        player:startEvent(11);
    end

end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    if (csid == 3) then
        player:setCharVar("ZilartStatus",1);
    end

end;
