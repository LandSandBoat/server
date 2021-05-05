-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm3 (???)
-- Involved In Quest: Yomi Okuri
-- !pos -767 -4 192 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local cstime = VanadielHour()

    if (player:hasKeyItem(xi.ki.YOMOTSU_HIRASAKA) and (cstime > 18 or cstime < 5) and not GetMobByID(ID.mob.DOMAN):isSpawned() and not GetMobByID(ID.mob.ONRYO):isSpawned()) then
        if (player:getCharVar("OkuriNMKilled") >= 1 and player:needToZone()) then
            player:delKeyItem(xi.ki.YOMOTSU_HIRASAKA)
            player:addKeyItem(xi.ki.FADED_YOMOTSU_HIRASAKA)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.FADED_YOMOTSU_HIRASAKA)
            player:setCharVar("OkuriNMKilled", 0)
        else
            player:startEvent(10)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 10 and option == 1) then
        player:needToZone(true) -- If you zone, you will need to repeat the fight.
        player:setCharVar("OkuriNMKilled", 0)
        SpawnMob(ID.mob.DOMAN):updateClaim(player)
        SpawnMob(ID.mob.ONRYO):updateClaim(player)
    end
end

return entity
