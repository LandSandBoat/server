-----------------------------------
-- Area: Den of Rancor
--  NPC: Switch
-- !pos -56 45 40 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getZPos() > 35 then
        GetNPCByID(ID.npc.DROP_GATE):openDoor() -- drop gate to Sacrificial Chamber
    end
end
