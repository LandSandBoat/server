-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Banishing Gate #2
-- !pos -100 -2.949 81 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.POUCH_OF_WEIGHTED_STONES) == false or player:getZPos() < 80.5) then
        player:messageSpecial(ID.text.A_GATE_OF_STURDY_STEEL)
        return 1
    else
        local DoorID = npc:getID()

        for i = DoorID, DoorID+4, 1 do
            GetNPCByID(i):openDoor(30)
        end
        player:messageSpecial(ID.text.BANISHING_GATES + 1) -- Second Banishing gate opening
        return 1
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
