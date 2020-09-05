-----------------------------------
-- Area:  Sacrarium
-- NPC:   qm4 (???)
-- Notes: Used to spawn Old Prof. Mariselle
-- !pos 22.669 -3.111 127.279 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cop = player:getCurrentMission(COP)
    local copStat = player:getCharVar("PromathiaStatus")
    local prof = GetMobByID(ID.mob.OLD_PROFESSOR_MARISELLE)
    local profLoc = GetServerVariable("Old_Prof_Spawn_Location")

    if (cop == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and copStat == 3 and not player:hasKeyItem(tpz.ki.RELIQUIARIUM_KEY) and not prof:isSpawned() and profLoc == 4) then
        player:messageSpecial(ID.text.EVIL_PRESENCE)
        SpawnMob(ID.mob.OLD_PROFESSOR_MARISELLE):updateClaim(player)
        prof:setPos(npc:getXPos()+1, npc:getYPos(), npc:getZPos()+1) -- Set Prof. spawn x and z pos. +1 from NPC
    elseif (cop == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and copStat == 4 and not player:hasKeyItem(tpz.ki.RELIQUIARIUM_KEY)) then
        player:addKeyItem(tpz.ki.RELIQUIARIUM_KEY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RELIQUIARIUM_KEY)
    elseif (profLoc == 4) then
        player:messageSpecial(ID.text.DRAWER_SHUT)
    else
        player:messageSpecial(ID.text.DRAWER_OPEN)
        player:messageSpecial(ID.text.DRAWER_EMPTY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
