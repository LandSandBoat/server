-----------------------------------
-- The Three Kingdoms San d'Oria
-- Windurst M2-3
-----------------------------------
-- !addmission 2 6
-- Halver          : !pos 2 0.1 0.1 233
-- Warchief Vatgit : !pos -74.960 -34.692 256.968 140
-- Kasaroro        : !pos -72 -3 34 231
-----------------------------------
local chateauID          = zones[xi.zone.CHATEAU_DORAGUILLE]
local northernSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        local needsHalverTrust = (not player:hasSpell(xi.magic.spell.HALVER) and not player:findItem(xi.item.CIPHER_OF_HALVERS_ALTER_EGO)) and 1 or 0

                        return mission:progressEvent(502, { [7] = needsHalverTrust })
                    else
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 279)
                    end
                end,
            },

            onEventFinish =
            {
                [502] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)

                    if
                        not player:hasSpell(xi.magic.spell.HALVER) and
                        not player:findItem(xi.item.CIPHER_OF_HALVERS_ALTER_EGO)
                    then
                        npcUtil.giveItem(player, xi.item.CIPHER_OF_HALVERS_ALTER_EGO)
                    end
                end,
            },
        },

        [xi.zone.GHELSBA_OUTPOST] =
        {
            ['Warchief_Vatgit'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:getMissionStatus(mission.areaId) == 4 then
                        player:setMissionStatus(mission.areaId, 5)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Kasaroro'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        return mission:messageText(northernSandoriaID.text.KASARORO_DIALOG)
                    elseif missionStatus == 4 then
                        return mission:progressEvent(549)
                    elseif missionStatus == 5 then
                        return mission:progressEvent(550)
                    end
                end,
            },

            onEventFinish =
            {
                [550] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
                        player:setMissionStatus(mission.areaId, 6)
                    end
                end,
            },
        },
    },
}

return mission
