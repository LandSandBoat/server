-----------------------------------
-- Garden of Antiquity
-- Promathia 8-1
-----------------------------------
-- !addmission 6 800
-- Crystalline Field !pos .1 -10 -464 33
-----------------------------------
local altaieuID = zones[xi.zone.ALTAIEU]
local palaceID  = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)

local antiquityVars =
{
    -- [crystalOffset] = { thisFightDone, thisCsAcquired, otherCrystal, otherCrystal2, firstCsParam, secondCsParam1, secondCsParam2 }
    [0] = { 'SouthTower', 'SouthTowerCS', 1, 2, 0, 2, 1 }, -- !pos 0 -6.250 -736.912 33
    [1] = { 'WestTower',  'WestTowerCS',  0, 2, 2, 1, 0 }, -- !pos -683.709 -6.250 -222.142 33
    [2] = { 'EastTower',  'EastTowerCS',  0, 1, 1, 2, 0 }, -- !pos 683.718 -6.250 -222.167 33
}

local function rubiousCrystalOnTrigger(player, npc)
    local crystalOffset  = npc:getID() - altaieuID.npc.RUBIOUS_CRYSTAL_OFFSET
    local ruaernOffset   = altaieuID.mob.RUAERN_OFFSET + crystalOffset * 3
    local cVar           = antiquityVars[crystalOffset]

    -- check to see if all three aerns are killed for the tower
    local thisFightDone  = mission:getVar(player, ruaernOffset) == 1 and
            mission:getVar(player, ruaernOffset + 1) == 1 and
            mission:getVar(player, ruaernOffset + 2) == 1
    local thisCsAcquired = mission:getVar(player, cVar[2]) == 1

    -- spawn ru'aerns
    if not thisFightDone and not thisCsAcquired then
        npcUtil.popFromQM(player, npc, { ruaernOffset, ruaernOffset + 1, ruaernOffset + 2 }, { hide = 0 })
        return mission:messageSpecial(altaieuID.text.OMINOUS_SHADOW)

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
        return mission:messageSpecial(altaieuID.text.NOTHING_OF_INTEREST)
    end
end

local function rubiousCrystalOnEventFinish(player, csid, option)
    local crystalOffset = player:getEventTarget():getID() - altaieuID.npc.RUBIOUS_CRYSTAL_OFFSET
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
                        return mission:progressEvent(100)
                    elseif checkTowerCsVars(player) == 3 then
                        mission:setVar(player, 'Status', 2)
                        return mission:progressEvent(100)
                    elseif mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(164)
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

            ['Ruaern'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 1 then
                        mission:setVar(player, mob:getID(), 1)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option)
                    if option == 1 then
                        player:setPos(-20, 0.624, -355, 191, 34) -- { R }
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
                        return mission:messageSpecial(palaceID.text.PORTAL_DOES_NOT_RESPOND)
                    end
                end,
            },

            ['_iyb'] = -- East Particle Gate
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 3 then
                        return mission:progressEvent(2)
                    else
                        return mission:messageSpecial(palaceID.text.DOES_NOT_RESPOND)
                    end
                end,
            },

            ['_iyc'] = -- West Particle Gate
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(palaceID.text.DOES_NOT_RESPOND)
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option)
                    if npcUtil.giveItem(player, xi.item.TAVNAZIAN_RING) then
                        mission:setVar(player, 'Status', 3)
                    end
                end,

                [2] = function(player, csid, option)
                    mission:complete(player)
                    player:setCharVar('PromathiaStatus', 1) -- TODO need to change when convert A Fate Decided.
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
                        player:setPos(-20, 0.624, -355, 191, 34) -- { R }
                    end
                end,
            },
        },
    },
}

return mission
