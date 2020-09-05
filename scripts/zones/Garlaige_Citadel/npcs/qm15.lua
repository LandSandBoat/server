-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm15 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos 19.893 -5.500 325.767 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local nm = GetMobByID(ID.mob.CHANDELIER)
    if (
        player:getCharVar("hittingTheMarquisateHagainCS") == 8 and
        os.time() > GetNPCByID(ID.npc.CHANDELIER_QM):getLocalVar("pop") and
        not nm:isSpawned()
    ) then
        player:messageSpecial(ID.text.HEAT_FROM_CEILING)
        nm:spawn()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
