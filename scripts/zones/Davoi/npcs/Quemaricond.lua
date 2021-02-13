-----------------------------------
-- Area: Davoi
--  NPC: Quemaricond
-- Involved in Mission: Infiltrate Davoi
-- !pos 23 0.1 -23 149
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    20.6, 0, -23,
    46, 0, -19,
    53.5, -1.8, -19,
    61, -1.1, -18.6,
    67.3, -1.5, -18.6,
    90, -0.5, -19
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    entity.onPath(npc)
end

entity.onPath = function(npc)

    tpz.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.INFILTRATE_DAVOI and player:getCharVar("MissionStatus") == 3) then
        player:startEvent(117)
        npc:wait()
    else
        player:showText(npc, ID.text.QUEMARICOND_DIALOG)
        npc:wait(2000)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)

    if (csid == 117) then
        player:setCharVar("MissionStatus", 4)
        player:addKeyItem(tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
    end

    npc:wait(0)
end

return entity
