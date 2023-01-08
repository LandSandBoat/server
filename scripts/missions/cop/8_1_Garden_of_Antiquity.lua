-----------------------------------
-- Garden of Antiquity
-- Promathia 8-1
-----------------------------------
-- !addmission 6 800
-- Crystalline Field : !pos -0.078 -10 -462.53 33
-- Rubious Crystal South : !pos -0.027 -4 -736.48 33
-- Rubious Crystal West : !pos -682.218 -4 -221.65 33
-- Rubious Crystal East : !pos 682.228 -4 -221.78 33
-- Gate of the god : !pos -20 0.1 -283 34
-- Particle Gate : !pos 1 0.1 -320 34
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED },
}

local antiquityVars =
{
    -- [crystalOffset] = { thisFightDone, thisCsAcquired, otherCsAcquired1, otherCsAcquired2, firstCsParam, secondCsParam1, secondCsParam2 }
    [0] = { 'SouthTower', 'SouthTowerCS', 'EastTowerCS', 'WestTowerCS', 0, 2, 1 },
    [1] = { 'WestTower', 'WestTowerCS', 'SouthTowerCS', 'EastTowerCS', 2, 1, 0 },
    [2] = { 'EastTower', 'EastTowerCS', 'SouthTowerCS', 'WestTowerCS', 1, 2, 0 },
}

local function clearKillVars(player, towerNum)
    mission:setVar(player, ""..towerNum.."-1KILL", 0)
    mission:setVar(player, ""..towerNum.."-2KILL", 0)
    mission:setVar(player, ""..towerNum.."-3KILL", 0)
end

local function clearTowerVars(player)
    mission:setVar(player, "SouthTower", 0)
    mission:setVar(player, "WestTower", 0)
    mission:setVar(player, "EastTower", 0)
    mission:setVar(player, "SouthTowerCS", 0)
    mission:setVar(player, "WestTowerCS", 0)
    mission:setVar(player, "EastTowerCS", 0)
end

local function setCsVarsFromNpc(player, npc)
    local npcId = npc:getID()
    local crystalOffset = npcId - ID.npc.RUBIOUS_CRYSTAL_BASE
    local cVar = antiquityVars[crystalOffset]

    mission:setVar(player, cVar[2], 1)
end

local function rubiousCrystalOnTrigger(player, npc)
    if mission:getVar(player, 'Status') == 1 then
        local npcId = npc:getID()
        local crystalOffset = npcId - ID.npc.RUBIOUS_CRYSTAL_BASE
        local ruaernOffset = ID.mob.RUAERN_BASE + crystalOffset * 3
        local cVar = antiquityVars[crystalOffset]
        local thisFightDone = mission:getVar(player, cVar[1])
        local thisCsAcquired = mission:getVar(player, cVar[2])

        -- spawn ru'aerns
        if
            thisCsAcquired == 0 and
            thisFightDone == 0 and
            npcUtil.popFromQM(player, npc, { ruaernOffset, ruaernOffset + 1, ruaernOffset + 2 }, { hide = 0 })
        then
            clearKillVars(player, crystalOffset)
            return player:messageSpecial(ID.text.OMINOUS_SHADOW)
        -- post-fight CS
        elseif thisCsAcquired == 0 and thisFightDone == 1 then
            local otherTowerDone1 = mission:getVar(player, cVar[3]) == 1
            local otherTowerDone2 = mission:getVar(player, cVar[4]) == 1

            if otherTowerDone1 and otherTowerDone2 then
                return mission:progressEvent(163) -- third CS
            elseif otherTowerDone1 then
                return mission:progressEvent(162, cVar[6]) -- second CS. param mentions remaining tower.
            elseif otherTowerDone2 then
                return mission:progressEvent(162, cVar[7]) -- second CS. param mentions remaining tower.
            else
                return mission:progressEvent(161, cVar[5]) -- first CS. param mentions current tower.
            end
        end
    else
        return
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ALTAIEU] =
        {

            ['_0x0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(164)
                    end
                end,
            },

            ['_0x1'] =
            {
                onTrigger = rubiousCrystalOnTrigger
            },

            ['_0x2'] =
            {
                onTrigger = rubiousCrystalOnTrigger
            },

            ['_0x3'] =
            {
                onTrigger = rubiousCrystalOnTrigger
            },

            ['Ruaern'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local aernKills =
                    {
                        [ID.mob.RUAERN_BASE + 0] = '1-1KILL',
                        [ID.mob.RUAERN_BASE + 1] = '1-2KILL',
                        [ID.mob.RUAERN_BASE + 2] = '1-3KILL',
                        [ID.mob.RUAERN_BASE + 3] = '2-1KILL',
                        [ID.mob.RUAERN_BASE + 4] = '2-2KILL',
                        [ID.mob.RUAERN_BASE + 5] = '2-3KILL',
                        [ID.mob.RUAERN_BASE + 6] = '3-1KILL',
                        [ID.mob.RUAERN_BASE + 7] = '3-2KILL',
                        [ID.mob.RUAERN_BASE + 8] = '3-3KILL',
                    }

                    local varToSet = aernKills[mob:getID()]

                    if varToSet ~= nil then
                        mission:setVar(player, varToSet, 1)
                    end

                    if
                        mission:getVar(player, '1-1KILL') == 1 and
                        mission:getVar(player, '1-2KILL') == 1 and
                        mission:getVar(player, '1-3KILL') == 1
                    then
                        mission:setVar(player, 'SouthTower', 1)
                        clearKillVars(player, 1)
                    end

                    if
                        mission:getVar(player, '2-1KILL') == 1 and
                        mission:getVar(player, '2-2KILL') == 1 and
                        mission:getVar(player, '2-3KILL') == 1
                    then
                        mission:setVar(player, 'WestTower', 1)
                        clearKillVars(player, 2)
                    end

                    if
                        mission:getVar(player, '3-1KILL') == 1 and
                        mission:getVar(player, '3-2KILL') == 1 and
                        mission:getVar(player, '3-3KILL') == 1
                    then
                        mission:setVar(player, 'EastTower', 1)
                        clearKillVars(player, 3)
                    end
                end
            },

            onEventFinish =
            {
                [164] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [161] = function(player, csid, option, npc)
                    setCsVarsFromNpc(player, npc)
                end,

                [162] = function(player, csid, option, npc)
                    setCsVarsFromNpc(player, npc)
                end,

                [163] = function(player, csid, option, npc)
                    setCsVarsFromNpc(player, npc)
                    clearTowerVars(player)
                    mission:setVar(player, 'Status', 2)
                end,
            },

        },

        [xi.zone.GRAND_PALACE_OF_HUXZOI] =
        {
            ['_iya'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(1)
                    end
                end,
            },

            ['_iyb'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 3 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { xi.items.TAVNAZIAN_RING }) then
                        mission:setVar(player, 'Status', 3)
                    end
                end,

                [2] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        }
    }
}

return mission
