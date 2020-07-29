-----------------------------------
-- Area: Garlaige Citadel
--  NPC: _5ki (Banishing Gate #3)
-- !pos -100 -3.008 359 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.POUCH_OF_WEIGHTED_STONES) == false or player:getZPos() > 359) then
        player:messageSpecial(ID.text.A_GATE_OF_STURDY_STEEL)
        return 1
    else
        local DoorID = npc:getID()

        for i = DoorID, DoorID+4, 1 do
            GetNPCByID(i):openDoor(30)
        end
        player:messageSpecial(ID.text.BANISHING_GATES + 2) -- Third Banishing gate opening
        return 1
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
