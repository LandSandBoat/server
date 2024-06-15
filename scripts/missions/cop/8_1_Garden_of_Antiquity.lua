-----------------------------------
-- Garden of Antiquity
-- Promathia 8-1
-----------------------------------
-- !addmission 6 800
-- _0x0 : !pos .1 -10 -464 33
-- _0x1 : !pos 0 -6.250 -736.912 33
-- _0x2 : !pos -683.709 -6.250 -222.142 33
-- _0x3 : !pos 683.718 -6.250 -222.167 33
-- _iya : !pos -20 0.1 -283 34
-----------------------------------
local altaieuID = zones[xi.zone.ALTAIEU]
local huxoiID   = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED },
}

-- NOTE: Tower event parameters do not align with NPCs in the database.  This table
-- maps to the expected parameter, and also is used to determine which bit is set
-- in missionStatus.

local towerOption =
{
    ['_0x1'] = 0,
    ['_0x2'] = 2,
    ['_0x3'] = 1,
}

local function setMissionStatusBit(player, bitNum)
    local statusIndex   = bitNum == 0 and xi.mission.status.CID or xi.mission.status.RUBIOUS
    local adjustedBit   = bitNum == 0 and 3 or bitNum - 1
    local missionStatus = player:getMissionStatus(mission.areaId, statusIndex)

    player:setMissionStatus(mission.areaId, utils.mask.setBit(missionStatus, adjustedBit, true), statusIndex)
end

local function getMissionStatusBit(player, bitNum)
    local statusIndex   = bitNum == 0 and xi.mission.status.CID or xi.mission.status.RUBIOUS
    local adjustedBit   = bitNum == 0 and 3 or bitNum - 1
    local missionStatus = player:getMissionStatus(mission.areaId, statusIndex)

    return utils.mask.getBit(missionStatus, adjustedBit)
end

local function getRubiousMask(player)
    local rubiousMask = 0

    for bitNum = 0, 3 do
        if getMissionStatusBit(player, bitNum) then
            rubiousMask = utils.mask.setBit(rubiousMask, bitNum, true)
        end
    end

    return rubiousMask
end

local rubiousOnTrigger = function(player, npc)
    local npcName    = npc:getName()
    local nmDefeated = utils.mask.getBit(mission:getLocalVar(player, 'nmDefeated'), towerOption[npcName])
    local nmOffset   = altaieuID.mob.RUAERN + (npc:getID() - altaieuID.npc.RUBIOUS_CRYSTAL) * 3

    if
        mission:getVar(player, 'Status') == 1 and
        not getMissionStatusBit(player, towerOption[npcName])
    then
        if
            not nmDefeated and
            npcUtil.popFromQM(player, npc, { nmOffset, nmOffset + 1, nmOffset + 2 }, { hide = 0 })
        then
            for _, member in ipairs(player:getAlliance()) do
                mission:setLocalVar(member, 'triggerNpc', npc:getID())
                mission:setLocalVar(member, 'nmOffset', nmOffset)
            end

            return mission:messageSpecial(altaieuID.text.OMINOUS_SHADOW)
        elseif nmDefeated then
            setMissionStatusBit(player, towerOption[npcName])
            local completedTowers = utils.mask.countBits(getRubiousMask(player), 3)

            if completedTowers == 1 then
                return mission:progressEvent(161, towerOption[npcName])
            elseif completedTowers == 3 then
                return mission:progressEvent(163)
            else
                for towerNum = 2, 0, -1 do
                    if not getMissionStatusBit(player, towerNum) then
                        return mission:progressEvent(162, towerNum)
                    end
                end
            end
        end
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
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(164)
                    elseif getRubiousMask(player) == 7 then
                        return mission:progressEvent(100)
                    end
                end,
            },

            ['_0x1'] = rubiousOnTrigger,
            ['_0x2'] = rubiousOnTrigger,
            ['_0x3'] = rubiousOnTrigger,

            ['Ruaern'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local nmOffset    = mission:getLocalVar(player, 'nmOffset')
                    local numDefeated = mission:getLocalVar(player, 'numDefeated')

                    if nmOffset > 0 then
                        for nmId = nmOffset, nmOffset + 2 do
                            if mob:getID() == nmId then
                                numDefeated = numDefeated + 1
                            end
                        end

                        if numDefeated == 3 then
                            local npcObj      = GetNPCByID(mission:getLocalVar(player, 'triggerNpc'))
                            local currentMask = mission:getLocalVar(player, 'nmDefeated')
                            mission:setLocalVar(player, 'nmDefeated', utils.mask.setBit(currentMask, towerOption[npcObj:getName()], true))
                            mission:setLocalVar(player, 'numDefeated', 0)
                        else
                            mission:setLocalVar(player, 'numDefeated', numDefeated)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)

                    if option == 1 then
                        player:setPos(-20, 0.624, -355, 191, 34)
                    end
                end,

                [164] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
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
                    else
                        -- TODO: Is this default until another condition is met? Verify
                        return mission:messageSpecial(huxoiID.text.DOES_NOT_RESPOND):setPriority(1000)
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
                    if npcUtil.giveItem(player, xi.item.TAVNAZIAN_RING) then
                        mission:setVar(player, 'Status', 3)
                    end
                end,

                [2] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.ALTAIEU] =
        {
            ['_0x0'] = mission:progressEvent(100),

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setPos(-20, 0.624, -355, 191, 34)
                    end
                end,
            },
        },
    },
}

return mission
