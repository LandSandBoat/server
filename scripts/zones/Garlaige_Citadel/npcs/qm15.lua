-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm15 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos 19.893 -5.500 325.767 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.HEAT_FROM_CEILING)
    if
        not GetMobByID(ID.mob.CHANDELIER):isSpawned() and
        player:hasKeyItem(tpz.ki.BOMB_INCENSE) and
        player:getCharVar("hittingTheMarquisateHagainCS") == 8 and
        os.time() > GetNPCByID(ID.npc.CHANDELIER_QM):getLocalVar("chandelierCooldown")
    then
        player:startEvent(56, tpz.keyItem.BOMB_INCENSE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 56 and option == 1 then
        GetMobByID(ID.mob.CHANDELIER):setRespawnTime(10)
    end
end
