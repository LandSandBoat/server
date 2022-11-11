-----------------------------------
-- Calm Before the Storm
-- Promathia 7-4
-----------------------------------
-- !addmission 6 738
-- Cryptonberries : !pos 120.615 -5.457 -390.133 2
-- Boggelmann     : !pos -312.52 -34.233 187.217 25
-- Dalham         : !pos 100.221 -44.691 940.547 4
-- Cid            : !pos -12 -12 1 237
-- Sueleen        : !pos 612 132 774 32
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local carpentersID = require("scripts/zones/Carpenters_Landing/IDs")
local bibikiBayID  = require("scripts/zones/Bibiki_Bay/IDs")
local misareauxID  = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH },
}

local function setMissionStatusBit(player, statusBit)
    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.CID)

    player:setMissionStatus(mission.areaId, utils.mask.setBit(missionStatus, statusBit, true), xi.mission.status.COP.CID)
end

local function getMissionStatusBit(player, statusBit)
    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.CID)

    return utils.mask.getBit(missionStatus, statusBit)
end

local function isCarpentersNmSpawned()
    for nmId = carpentersID.mob.CRYPTONBERRY_EXECUTOR, carpentersID.mob.CRYPTONBERRY_EXECUTOR + 3 do
        if GetMobByID(nmId):isSpawned() then
            return true
        end
    end

    return false
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BIBIKI_BAY] =
        {
            ['qm_dalham'] =
            {
                onTrigger = function(player, npc)
                    if not getMissionStatusBit(player, 2) then
                        local dalham = player:getZone():queryEntitiesByName('Dalham')[1]
                        if mission:getLocalVar(player, 'nmBibiki') == 1 then
                            return mission:progressEvent(41)
                        elseif not dalham:isSpawned() then
                            dalham:spawn()
                            dalham:updateClaim(player)
                            return mission:messageSpecial(bibikiBayID.text.YOU_ARE_NOT_ALONE)
                        end
                    end
                end,
            },

            ['Dalham'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getLocalVar(player, 'nmBibiki') == 0 then
                        mission:setLocalVar(player, 'nmBibiki', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    setMissionStatusBit(player, 2)
                end,
            },
        },

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['qm_cryptonberries'] =
            {
                onTrigger = function(player, npc)
                    if not getMissionStatusBit(player, 1) then
                        local nmProgress = mission:getLocalVar(player, 'carpentersNm')

                        if nmProgress == 15 then
                            return mission:progressEvent(37)
                        elseif not isCarpentersNmSpawned() then
                            local executor = GetMobByID(carpentersID.mob.CRYPTONBERRY_EXECUTOR)

                            executor:spawn()
                            executor:updateClaim(player)
                            executor:setCE(player, 0)

                            return mission:messageSpecial(carpentersID.text.CRYPTONBERRY_EXECUTOR_POP)
                        end
                    end
                end,
            },

            ['Cryptonberry_Assassin'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local nmProgress = mission:getLocalVar(player, 'carpentersNm')
                    local nmOffset = mob:getID() - carpentersID.mob.CRYPTONBERRY_EXECUTOR

                    mission:setLocalVar(player, 'carpentersNm', utils.mask.setBit(nmProgress, nmOffset, true))
                end,
            },

            ['Cryptonberry_Executor'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local nmProgress = mission:getLocalVar(player, 'carpentersNm')
                    local nmOffset = mob:getID() - carpentersID.mob.CRYPTONBERRY_EXECUTOR

                    mission:setLocalVar(player, 'carpentersNm', utils.mask.setBit(nmProgress, nmOffset, true))
                    mob:messageText(mob, carpentersID.text.CRYPTONBERRY_EXECUTOR_DIE)
                end,
            },

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    setMissionStatusBit(player, 1)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p4'] =
            {
                onTrigger = function(player, npc)
                    if not getMissionStatusBit(player, 0) then
                        if mission:getLocalVar(player, 'nmMisareaux') == 1 then
                            return mission:progressEvent(13, { [1] = xi.items.DUCAL_GUARDS_RING })
                        elseif not GetMobByID(misareauxID.mob.BOGGELMANN):isSpawned() then
                            SpawnMob(misareauxID.mob.BOGGELMANN):updateClaim(player)

                            return mission:messageSpecial(misareauxID.text.CREATURE_HAS_APPEARED)
                        end
                    end
                end,
            },

            ['Boggelmann'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getLocalVar(player, 'nmMisareaux') == 0 then
                        mission:setLocalVar(player, 'nmMisareaux', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    setMissionStatusBit(player, 0)
                    npcUtil.giveKeyItem(player, xi.ki.VESSEL_OF_LIGHT)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.CID) == 7 then
                        if not player:hasKeyItem(xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE) then
                            return mission:progressEvent(892)
                        else
                            return mission:progressEvent(895):oncePerZone()
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [892] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE)
                end,
            },
        },

        [xi.zone.SEALIONS_DEN] =
        {
            ['Sueleen'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE) then
                        return mission:progressEvent(17)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
