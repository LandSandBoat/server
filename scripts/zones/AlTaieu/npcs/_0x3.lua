-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (East Tower)
-- !pos 683.718 -6.250 -222.167 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.GARDEN_OF_ANTIQUITY
        and player:getCharVar("PromathiaStatus") == 2
        and player:getCharVar("[SEA][AlTieu]EastTower") == 0
        and player:getCharVar("[SEA][AlTieu]EastTowerCS") == 0
        and not GetMobByID(ID.mob.AERNS_TOWER_EAST+0):isSpawned()
        and not GetMobByID(ID.mob.AERNS_TOWER_EAST+1):isSpawned()
        and not GetMobByID(ID.mob.AERNS_TOWER_EAST+2):isSpawned()
    ) then
        player:messageSpecial(ID.text.OMINOUS_SHADOW)
        SpawnMob(ID.mob.AERNS_TOWER_EAST+0):updateClaim(player)
        SpawnMob(ID.mob.AERNS_TOWER_EAST+1):updateClaim(player)
        SpawnMob(ID.mob.AERNS_TOWER_EAST+2):updateClaim(player)

    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.GARDEN_OF_ANTIQUITY
        and player:getCharVar("PromathiaStatus") == 2
        and player:getCharVar("[SEA][AlTieu]EastTower") == 1
        and player:getCharVar("[SEA][AlTieu]EastTowerCS") == 0
    ) then
        player:startEvent(163)

    else
        player:messageSpecial(ID.text.NOTHING_OF_INTEREST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 163) then
        player:setCharVar("[SEA][AlTieu]EastTowerCS", 1)
        player:setCharVar("[SEA][AlTieu]EastTower", 0)
    end
end
