-----------------------------------
-- Garden of Antiquity
-- Promathia 8-1
-----------------------------------
-- !addmission 6 800
-- Crystalline Field !pos .1 -10 -464 33
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require("scripts/globals/teleports")
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)

local antiquityVars =
{
    -- [crystalOffset] = {thisFightDone, thisCsAcquired, otherCrystal, otherCrystal2, firstCsParam, secondCsParam1, secondCsParam2}
    [0] = {'SouthTower', 'SouthTowerCS', 1, 2, 0, 2, 1}, -- !pos 0 -6.250 -736.912 33
    [1] = {'WestTower', 'WestTowerCS', 0, 2, 2, 1, 0}, -- !pos -683.709 -6.250 -222.142 33
    [2] = {'EastTower', 'EastTowerCS', 0, 1, 1, 2, 0}, -- !pos 683.718 -6.250 -222.167 33
}

local function rubiousCrystalOnTrigger(player, npc)
    local zoneId = npc:getZoneID()
    local crystalOffset = npc:getID() - zones[zoneId].npc.RUBIOUS_CRYSTAL_BASE
    local ruaernOffset = zones[zoneId].mob.RUAERN_BASE + crystalOffset * 3
    local cVar = antiquityVars[crystalOffset]
    local thisFightDone = mission:getVar(player, cVar[1]) == 1
    local thisCsAcquired = mission:getVar(player, cVar[2]) == 1
    -- spawn ru'aerns
    if not thisFightDone and not thisCsAcquired then
        npcUtil.popFromQM(player, npc, {ruaernOffset, ruaernOffset + 1, ruaernOffset + 2}, {hide = 0})
        return mission:messageSpecial(zones[zoneId].text.OMINOUS_SHADOW)
    -- post-fight CS
    elseif not thisCsAcquired then
        local otherTowerDone1 = mission:getVar(player, antiquityVars[cVar[3]][2]) == 1
        local otherTowerDone2 = mission:getVar(player, antiquityVars[cVar[4]][2]) == 1
        if otherTowerDone1 and otherTowerDone2 then
            return mission:progressEvent(163) -- third CS
        elseif otherTowerDone1 then
            return mission:progressEvent(162, cVar[6]) -- second CS. param mentions remaining tower.
        elseif otherTowerDone2 then
            return mission:progressEvent(162, cVar[7]) -- second CS. param mentions remaining tower.
        else
            return mission:progressEvent(161, cVar[5]) -- first CS. param mentions current tower.
        end
    -- default dialog
    else
        return mission:messageSpecial(zones[zoneId].text.NOTHING_OF_INTEREST)
    end
end

local function rubiousCrystalOnEventFinish(player, csid, option)
    local crystalOffset = player:getEventTarget():getID() - zones[player:getZoneID()].npc.RUBIOUS_CRYSTAL_BASE
    mission:setVar(player, antiquityVars[crystalOffset][2], 1)
end

local function checkTowerCsVars(player)
    local status = 0
    for _, cVar in pairs(antiquityVars) do
        if mission:getVar(player, cVar[2]) == 1 then
            status = status + 1
        end
    end
    if status == 3 then
        for _, cVar in pairs(antiquityVars) do
            mission:setVar(player, cVar[1], 0)
            mission:setVar(player, cVar[2], 0)
        end
    end
    return status
end

mission.reward =
{
    item = xi.items.TAVNAZIAN_RING,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ALTAIEU] =
        {
            ['_0x0'] = -- Crystalline Field
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:event(100)
                    elseif checkTowerCsVars(player) == 3 then
                        mission:setVar(player, 'Status', 2)
                        return mission:progressEvent(100)
                    elseif mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(164)
                    else
                        return mission:messageSpecial(npc, zones[npc:getZoneID()].text.IMPERVIOUS_FIELD_BLOCKS)
                    end
                end,
            },

            ['_0x1'] = -- South Tower
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return rubiousCrystalOnTrigger(player, npc)
                    end
                end,
            },

            ['_0x2'] = -- West Tower
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return rubiousCrystalOnTrigger(player, npc)
                    end
                end,
            },

            ['_0x3'] = -- East Tower
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return rubiousCrystalOnTrigger(player, npc)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option)
                    if option == 1 then
                        player:setPos(-20, 0.624, -355, 191, 34) -- {R}
                    end
                end,

                [161] = function(player, csid, option)
                    rubiousCrystalOnEventFinish(player, csid, option)
                end,

                [162] = function(player, csid, option)
                    rubiousCrystalOnEventFinish(player, csid, option)
                end,

                [163] = function(player, csid, option)
                    rubiousCrystalOnEventFinish(player, csid, option)
                end,

                [164] = function(player, csid, option)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {
            ['_iya'] = -- Gate of the Gods
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(1)
                    else
                        return mission:messageSpecial(zones[npc:getZoneID()].text.PORTAL_DOES_NOT_RESPOND)
                    end
                end,
            },

            ['_iyb'] = -- East Particle Gate
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(zones[npc:getZoneID()].text.GATE_DOES_NOT_RESPOND)
                end,
            },

            ['_iyc'] = -- West Particle Gate
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(zones[npc:getZoneID()].text.GATE_DOES_NOT_RESPOND)
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option)
                    if player:getFreeSlotsCount() == 0 then
                        mission:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, xi.items.TAVNAZIAN_RING)
                    else
                        mission:complete(player)
                    end
                end,
            },
        }
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.ALTAIEU] =
        {
            ['_0x0'] = -- Crystalline Field
            {
                onTrigger = function(player, npc)
                    return mission:event(100)
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option)
                    if option == 1 then
                        player:setPos(-20, 0.624, -355, 191, 34) -- {R}
                    end
                end,
            },
        },
    },
}

return mission
