-- Zone: Al'Taieu (33)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------

local antiquityVars =
{
    -- [crystalOffset] = { thisFightDone, thisCsAcquired, otherCsAcquired1, otherCsAcquired2, firstCsParam, secondCsParam1, secondCsParam2 }
    [0] = { '[SEA][AlTieu]SouthTower', '[SEA][AlTieu]SouthTowerCS', '[SEA][AlTieu]EastTowerCS', '[SEA][AlTieu]WestTowerCS', 0, 2, 1 },
    [1] = { '[SEA][AlTieu]WestTower', '[SEA][AlTieu]WestTowerCS', '[SEA][AlTieu]SouthTowerCS', '[SEA][AlTieu]EastTowerCS', 2, 1, 0 },
    [2] = { '[SEA][AlTieu]EastTower', '[SEA][AlTieu]EastTowerCS', '[SEA][AlTieu]SouthTowerCS', '[SEA][AlTieu]WestTowerCS', 1, 2, 0 },
}

return {
    --[[..............................................................................................
        Garden of Antiquity: player clicks a rubious crystal tower

        Event 161 first post-fight CS, mentions current tower by param: 0 = South, 1 = East, 2 = West
        Event 162 second post-fight CS, mentions final tower by param: 0 = South, 1 = East, 2 = West
        Event 163 third post-fight CS
        ..............................................................................................]]
    rubiousCrystalOnTrigger = function(player, npc)
        local npcId = npc:getID()
        local crystalOffset = npcId - ID.npc.RUBIOUS_CRYSTAL_BASE
        local ruaernOffset = ID.mob.RUAERN_BASE + crystalOffset * 3
        local cop = player:getCurrentMission(xi.mission.log_id.COP)
        local copStat = player:getCharVar('PromathiaStatus')
        local cVar = antiquityVars[crystalOffset]
        local thisFightDone = player:getCharVar(cVar[1]) == 1
        local thisCsAcquired = player:getCharVar(cVar[2]) == 1

        -- spawn ru'aerns
        if
            cop == xi.mission.id.cop.GARDEN_OF_ANTIQUITY and
            copStat < 3 and
            not thisCsAcquired and
            not thisFightDone and
            npcUtil.popFromQM(player, npc, { ruaernOffset, ruaernOffset + 1, ruaernOffset + 2 }, { hide = 0 })
        then
            player:messageSpecial(ID.text.OMINOUS_SHADOW)

        -- post-fight CS
        elseif
            cop == xi.mission.id.cop.GARDEN_OF_ANTIQUITY and
            copStat == 2 and
            not thisCsAcquired and
            thisFightDone
        then
            local otherTowerDone1 = player:getCharVar(cVar[3]) == 1
            local otherTowerDone2 = player:getCharVar(cVar[4]) == 1

            if otherTowerDone1 and otherTowerDone2 then
                player:startEvent(163) -- third CS
            elseif otherTowerDone1 then
                player:startEvent(162, cVar[6]) -- second CS. param mentions remaining tower.
            elseif otherTowerDone2 then
                player:startEvent(162, cVar[7]) -- second CS. param mentions remaining tower.
            else
                player:startEvent(161, cVar[5]) -- first CS. param mentions current tower.
            end

        -- default dialog
        else
            player:messageSpecial(ID.text.NOTHING_OF_INTEREST)
        end
    end,

    rubiousCrystalOnEventFinish = function(player, csid, option, npc)
        local npcId = player:getEventTarget():getID()
        local crystalOffset = npcId - ID.npc.RUBIOUS_CRYSTAL_BASE
        local cVar = antiquityVars[crystalOffset]

        if csid == 161 or csid == 162 or csid == 163 then
            player:setCharVar(cVar[1], 0)
            player:setCharVar(cVar[2], 1)
        end
    end,
}
