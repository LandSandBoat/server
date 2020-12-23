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
    local promathiaStatus = player:getCharVar("PromathiaStatus")
    local currentMission = player:getCurrentMission(COP)

    if (currentMission == tpz.mission.id.cop.GARDEN_OF_ANTIQUITY and promathiaStatus == 2) then
        local eastTower = player:getCharVar("[SEA][AlTieu]EastTower")
        local eastTowerCs = player:getCharVar("[SEA][AlTieu]EastTowerCS")
        if (eastTower == 0 and eastTowerCs == 0) then
            if (not GetMobByID(ID.mob.AERNS_TOWER_EAST_1):isSpawned() and
                not GetMobByID(ID.mob.AERNS_TOWER_EAST_2):isSpawned() and
                not GetMobByID(ID.mob.AERNS_TOWER_EAST_3):isSpawned())
            then
                player:messageSpecial(ID.text.OMINOUS_SHADOW)
                SpawnMob(ID.mob.AERNS_TOWER_EAST_1):updateClaim(player)
                SpawnMob(ID.mob.AERNS_TOWER_EAST_2):updateClaim(player)
                SpawnMob(ID.mob.AERNS_TOWER_EAST_3):updateClaim(player)
            end
        elseif (eastTower == 1 and eastTowerCs == 0) then
            local southTower = player:getCharVar("[SEA][AlTieu]SouthTower")
            local westTower = player:getCharVar("[SEA][AlTieu]WestTower")
            local towerChecked = southTower + eastTower + westTower

            -- Event 161 first tower
            -- Event 162 second tower
            -- Event 163 thrid tower (unlock gate)
            -- For Event if parameter is 0 = South, 1 = East, 2 = West
            switch (towerChecked): caseof
            {
                [1] = player:startEvent(161, 1),    -- East tower in first
                [2] = function ()                   -- East tower in second
                    if (southTower == 1) then
                        player:startEvent(162, 2)
                    elseif (westTower == 1) then
                        player:startEvent(162, 0)
                    end
                end,
                [3] = player:startEvent(163)        -- East tower in third (same as other tower)
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
        player:setCharVar("[SEA][AlTieu]EastTowerCS", 1)
        player:setCharVar("[SEA][AlTieu]EastTower", 0)
    end
end
