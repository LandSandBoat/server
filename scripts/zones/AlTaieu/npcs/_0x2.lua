-----------------------------------
-- Area: Al'Taieu
--  NPC: Rubious Crystal (West Tower)
-- !pos -683.709 -6.250 -222.142 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local promathiaStatus = player:getCharVar("PromathiaStatus")
    local currentMission = player:getCurrentMission(COP)

    if (currentMission == tpz.mission.id.cop.GARDEN_OF_ANTIQUITY and promathiaStatus == 2) then
        local westTower = player:getCharVar("[SEA][AlTieu]WestTower")
        local westTowerCs = player:getCharVar("[SEA][AlTieu]WestTowerCS")
        if (westTower == 0 and westTowerCs == 0) then
            if (not GetMobByID(ID.mob.AERNS_TOWER_WEST_1):isSpawned() and
                not GetMobByID(ID.mob.AERNS_TOWER_WEST_2):isSpawned() and
                not GetMobByID(ID.mob.AERNS_TOWER_WEST_3):isSpawned())
            then
                player:messageSpecial(ID.text.OMINOUS_SHADOW)
                SpawnMob(ID.mob.AERNS_TOWER_WEST_1):updateClaim(player)
                SpawnMob(ID.mob.AERNS_TOWER_WEST_2):updateClaim(player)
                SpawnMob(ID.mob.AERNS_TOWER_WEST_3):updateClaim(player)
            end
        elseif (westTower == 1 and westTowerCs == 0) then
            local southTower = player:getCharVar("[SEA][AlTieu]SouthTower")
            local eastTower = player:getCharVar("[SEA][AlTieu]EastTower")
            local towerChecked = southTower + eastTower + westTower
            
            -- Event 161 first tower
            -- Event 162 second tower
            -- Event 163 thrid tower (unlock gate)
            -- For Event if parameter is 0 = South, 1 = East, 2 = West
            switch (towerChecked): caseof
            {
                [1] = player:startEvent(161, 2),    -- West tower in first
                [2] = function ()                   -- West tower in second
                    if (southTower == 1) then
                        player:startEvent(162, 1)
                    elseif (eastTower == 1) then
                        player:startEvent(162, 0)
                    end
                end,
                [3] = player:startEvent(163)        -- West tower in third (same as other tower)
            }
        end
    else
        player:messageSpecial(ID.text.NOTHING_OF_INTEREST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 161 or csid == 162 or csid == 163) then
        player:setCharVar("[SEA][AlTieu]WestTowerCS", 1)
        player:setCharVar("[SEA][AlTieu]WestTower", 0)
    end
end
