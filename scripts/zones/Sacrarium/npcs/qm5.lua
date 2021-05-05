-----------------------------------
-- Area: Sacrarium
--  NPC: qm5 (???)
-- Notes: Used to spawn Old Prof. Mariselle
-- !pos 102.670 -3.111 -127.318 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cop = player:getCurrentMission(COP)
    local copStat = player:getCharVar("PromathiaStatus")
    local prof = GetMobByID(ID.mob.OLD_PROFESSOR_MARISELLE)
    local profLoc = GetServerVariable("Old_Prof_Spawn_Location")

    if (cop == xi.mission.id.cop.THE_SECRETS_OF_WORSHIP and copStat == 3 and not player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY) and not prof:isSpawned() and profLoc == 5) then
        player:messageSpecial(ID.text.EVIL_PRESENCE)
        SpawnMob(ID.mob.OLD_PROFESSOR_MARISELLE):updateClaim(player)
        prof:setPos(npc:getXPos()+1, npc:getYPos(), npc:getZPos()+1) -- Set Prof. spawn x and z pos. +1 from NPC
    elseif (cop == xi.mission.id.cop.THE_SECRETS_OF_WORSHIP and copStat == 4 and not player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY)) then
        player:addKeyItem(xi.ki.RELIQUIARIUM_KEY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RELIQUIARIUM_KEY)
    elseif (profLoc == 5) then
        player:messageSpecial(ID.text.DRAWER_SHUT)
    else
        player:messageSpecial(ID.text.DRAWER_OPEN)
        player:messageSpecial(ID.text.DRAWER_EMPTY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
