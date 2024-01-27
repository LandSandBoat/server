-----------------------------------
-- Area: Sacrarium
--  NPC: qm_prof_3 (???)
-- Notes: Used to spawn Old Prof. Mariselle
-- !pos 102.670 -3.111 -127.318 28
-----------------------------------
local ID = zones[xi.zone.SACRARIUM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local isSpawnPoint = npc:getLocalVar('hasProfessorMariselle') == 1

    if isSpawnPoint then
        player:messageSpecial(ID.text.DRAWER_SHUT)
    else
        player:messageSpecial(ID.text.DRAWER_OPEN)
        player:messageSpecial(ID.text.DRAWER_EMPTY)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
