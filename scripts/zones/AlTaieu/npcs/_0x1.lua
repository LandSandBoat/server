-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (South Tower)
-- !pos 0 -6.250 -736.912 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (
            player:getCurrentMission(COP) == tpz.mission.id.cop.GARDEN_OF_ANTIQUITY
        and player:getCharVar("PromathiaStatus") == 2
        and player:getCharVar("[SEA][AlTieu]SouthTower") == 0
        and player:getCharVar("[SEA][AlTieu]SouthTowerCS") == 0
        and not GetMobByID(ID.mob.AERNS_TOWER_SOUTH+0):isSpawned()
        and not GetMobByID(ID.mob.AERNS_TOWER_SOUTH+1):isSpawned()
        and not GetMobByID(ID.mob.AERNS_TOWER_SOUTH+2):isSpawned()
    ) then
        player:messageSpecial(ID.text.OMINOUS_SHADOW)
        SpawnMob(ID.mob.AERNS_TOWER_SOUTH+0):updateClaim(player)
        SpawnMob(ID.mob.AERNS_TOWER_SOUTH+1):updateClaim(player)
        SpawnMob(ID.mob.AERNS_TOWER_SOUTH+2):updateClaim(player)

    elseif (
            player:getCurrentMission(COP) == tpz.mission.id.cop.GARDEN_OF_ANTIQUITY
        and player:getCharVar("PromathiaStatus") == 2
        and player:getCharVar("[SEA][AlTieu]SouthTower") == 1
        and player:getCharVar("[SEA][AlTieu]SouthTowerCS") == 0
    ) then
        player:startEvent(161)

    else
        player:messageSpecial(ID.text.NOTHING_OF_INTEREST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 161) then
        player:setCharVar("[SEA][AlTieu]SouthTowerCS", 1)
        player:setCharVar("[SEA][AlTieu]SouthTower", 0)
    end
end
