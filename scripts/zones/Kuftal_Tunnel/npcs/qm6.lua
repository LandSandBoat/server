-----------------------------------
-- Area: Kuftal Tunnel
--  NPC: ???
-- Involved in Mission: Bastok 8-2
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- ENTER THE TALEKEEPER
    if player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.ENTER_THE_TALEKEEPER then
        local missionStatus = player:getCharVar("MissionStatus")
        local anyGhostsAlive = false
        for i = 0, 2 do
            if GetMobByID(ID.mob.TALEKEEPER_OFFSET + i):isAlive() then
                anyGhostsAlive = true
                break
            end
        end

        if player:getCharVar("MissionStatus") == 2 and not anyGhostsAlive then
            player:messageSpecial(ID.text.EVIL)
            for i = 0, 2 do
                SpawnMob(ID.mob.TALEKEEPER_OFFSET + i)
            end
        elseif player:getCharVar("MissionStatus") == 3 and not anyGhostsAlive then
            player:startEvent(13)
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        end

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 13 then
        player:setCharVar("MissionStatus", 4)
        npcUtil.giveKeyItem(player, tpz.ki.OLD_PIECE_OF_WOOD)
    end
end

return entity
