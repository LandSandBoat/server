-----------------------------------
-- Area: Al'Taieu
--  NPC: Swirling_Vortex
-- Type: Standard NPC
-- !pos ? ? ? 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/limbus")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local offset = npc:getID() - ID.npc.SWIRLING_VORTEX_OFFSET
    if offset >= 0 and offset <= 1 then
        player:startEvent(159 + offset)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 160 and option == 1 then
        tpz.limbus.enter(player,1)
    elseif csid == 159 and option == 1 then
        tpz.limbus.enter(player,0)
    end
end
