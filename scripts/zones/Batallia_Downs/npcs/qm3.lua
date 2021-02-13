-----------------------------------
-- Area: Batallia Downs
--  NPC: qm3 (???)
--  Involved in Mission 9-1 (San dOria)
--  !pos 210 17 -615 105
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.BREAKING_BARRIERS and player:getCharVar("MissionStatus") == 3
        and not GetMobByID(ID.mob.SUPARNA):isSpawned() and not GetMobByID(ID.mob.SUPARNA_FLEDGLING):isSpawned()) then
        if (player:getCharVar("Mission9-1Kills") > 0) then
            player:startEvent(904)
        else
            SpawnMob(ID.mob.SUPARNA)
            SpawnMob(ID.mob.SUPARNA_FLEDGLING)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 904) then
        player:addKeyItem(tpz.ki.FIGURE_OF_LEVIATHAN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FIGURE_OF_LEVIATHAN)
        player:setCharVar("MissionStatus", 4)
        player:setCharVar("Mission9-1Kills", 0)
    end
end

return entity
