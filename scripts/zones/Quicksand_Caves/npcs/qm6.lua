-----------------------------------
-- Area: Quicksand Caves
--  NPC: ??? (qm6)
-- Bastok Mission 8.1 "The Chains That Bind Us"
-- !pos -469 0 620 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/missions")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    -- THE CHAINS THAT BIND US
    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US and player:getCharVar("MissionStatus") == 1) then
        if (os.time() >= npc:getLocalVar("cooldown")) then
            if (GetMobByID(ID.mob.CENTURIO_IV_VII):isSpawned() or GetMobByID(ID.mob.TRIARIUS_IV_XIV):isSpawned() or GetMobByID(ID.mob.PRINCEPS_IV_XLV):isSpawned()) then
                player:messageSpecial(ID.text.NOW_IS_NOT_THE_TIME)
            else
                player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
                SpawnMob(ID.mob.CENTURIO_IV_VII):updateClaim(player)
                SpawnMob(ID.mob.TRIARIUS_IV_XIV):updateClaim(player)
                SpawnMob(ID.mob.PRINCEPS_IV_XLV):updateClaim(player)
            end
        else
            player:startEvent(11)
        end

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    -- THE CHAINS THAT BIND US
    if (csid == 11) then
        player:setCharVar("MissionStatus", 2)
    end
end
