-----------------------------------
-- Area: Western Altepa Desert
--  NPC: Dreamrose
-- Involved in Mission: San D'Oria 6-1
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.LEAUTES_LAST_WISHES and
        player:getMissionStatus(player:getNation()) == 2 and
        not GetMobByID(ID.mob.SABOTENDER_ENAMORADO):isSpawned()
    then
        if player:getCharVar("Mission6-1MobKilled") == 1 then
            player:addKeyItem(xi.ki.DREAMROSE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DREAMROSE)
            player:setCharVar("Mission6-1MobKilled", 0)
            player:setMissionStatus(player:getNation(), 3)
        else
            SpawnMob(ID.mob.SABOTENDER_ENAMORADO):updateClaim(player)
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
