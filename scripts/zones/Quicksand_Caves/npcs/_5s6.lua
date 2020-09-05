-----------------------------------
-- Area: Quicksand Caves
--  NPC: Ornate Door
-- Door blocked by Weight system
-- !pos -825 0 -379 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local difX = player:getXPos()-(-833)
    local difZ = player:getZPos()-(-380)
    local Distance = math.sqrt( math.pow(difX, 2) + math.pow(difZ, 2) )
    if (Distance < 3) then
        return -1
    end

    player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
