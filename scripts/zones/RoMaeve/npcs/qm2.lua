-----------------------------------
-- Area: Ro'Maeve
--  NPC: qm2 (???)
-- Involved in Mission: Bastok 7-1
-- !pos 102 -4 -114 122 and <many pos>
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_FINAL_IMAGE and player:getCharVar("MissionStatus") == 1 then
        if player:getCharVar("Mission7-1MobKilled") == 1 then
            npcUtil.giveKeyItem(player, tpz.ki.REINFORCED_CERMET)
            player:setCharVar("Mission7-1MobKilled", 0)
            player:setCharVar("MissionStatus", 2)
        elseif npcUtil.popFromQM(player, npc, {ID.mob.MOKKURKALFI_I, ID.mob.MOKKURKALFI_II}, {claim=false, look=true, radius=2}) then
            -- move QM
            local newPosition = npcUtil.pickNewPosition(npc:getID(), ID.npc.BASTOK_7_1_QM_POS, true)
            npcUtil.queueMove(npc, newPosition)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
