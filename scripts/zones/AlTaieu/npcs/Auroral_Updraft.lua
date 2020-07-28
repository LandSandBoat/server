-----------------------------------
--  Area: Al'Taieu
--  NPC:  Auroral Updraft
--  Type: Standard NPC
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.AURORAL_UPDRAFT_OFFSET
    if (offset == 0) then
        player:startEvent(150)
    elseif (offset >= 1 and offset <= 5) then
        player:startEvent(155)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 155) and option == 1 then
        player:setPos(-25, -1 , -620 , 208 , 33)
    elseif (csid == 150) and option == 1 then
        player:setPos(611.931, 132.787, 773.427, 192, 32) -- To Sealion's Den {R}
    end
end
