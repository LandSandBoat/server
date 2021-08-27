-----------------------------------
-- Area: Sacrarium
--  NPC: qm_professor_mariselle (???)
-- Notes: Used to spawn Old Prof. Mariselle
-- !pos 102.669 -3.111 127.279 28
-- !pos 62.668 -3.111 127.288 28
-- !pos 22.669 -3.111 127.279 28
-- !pos 102.670 -3.111 -127.318 28
-- !pos 62.668 -3.111 -127.310 28
-- !pos 22.669 -3.111 -127.318 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cop = player:getCurrentMission(COP)
    local copStat = player:getCharVar("PromathiaStatus")
    local hasProf = npc:getLocalVar("hasProfessorMariselle") == 1

    if
        cop == xi.mission.id.cop.THE_SECRETS_OF_WORSHIP and
        copStat == 3 and
        not player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY) and
        hasProf and
        npcUtil.popFromQM(player, npc, ID.mob.OLD_PROFESSOR_MARISELLE, {radius = 2, hide = 0})
    then
        player:messageSpecial(ID.text.EVIL_PRESENCE)
    elseif
        cop == xi.mission.id.cop.THE_SECRETS_OF_WORSHIP and
        copStat == 4 and
        not player:hasKeyItem(xi.ki.RELIQUIARIUM_KEY)
    then
        npcUtil.giveKeyItem(player, xi.ki.RELIQUIARIUM_KEY)
    elseif hasProf then
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
