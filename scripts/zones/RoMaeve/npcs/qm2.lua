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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_FINAL_IMAGE and player:getMissionStatus(player:getNation()) == 1 then
        if player:getCharVar("Mission7-1MobKilled") == 1 then
            npcUtil.giveKeyItem(player, xi.ki.REINFORCED_CERMET)
            player:setCharVar("Mission7-1MobKilled", 0)
            player:setMissionStatus(player:getNation(), 2)
        elseif npcUtil.popFromQM(player, npc, {ID.mob.MOKKURKALFI_I, ID.mob.MOKKURKALFI_II}, {claim=false, look=true, radius=2}) then
            -- move QM
            local newPosition = npcUtil.pickNewPosition(npc:getID(), ID.npc.BASTOK_7_1_QM_POS, true)
            npcUtil.queueMove(npc, newPosition)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
