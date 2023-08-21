-----------------------------------
-- The Emissary San d'Oria
-- Bastok M2-3
-----------------------------------
-- !addmission 1 6
-- Baraka  : !pos 36 -2 -2 231
-- Helaku  : !pos 49 -2 -12 231
-- Halver  : !pos 2 0.1 0.1 233
-----------------------------------
local chateauID          = zones[xi.zone.CHATEAU_DORAGUILLE]
local northernSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_SANDORIA)

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

                        return mission:progressEvent(501, { [7] = needsHalverTrust })
                    elseif missionStatus > 3 then
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 266)
                    end
                end,
            },

            onEventFinish =
            {
                [501] = function(player, csid, option, npc)
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
            ['Baraka'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        -- TODO: Verify this message, as it was previously hard-coded to ID 11141
                        return mission:messageText(northernSandoriaID.text.HERE_WITH_BUSINESS)
                    else
                        return mission:progressEvent(539)
                    end
                end,
            },

            ['Helaku'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        return mission:progressEvent(536)
                    elseif missionStatus == 3 then
                        return mission:messageText(northernSandoriaID.text.HELAKU_DIALOG)
                    elseif missionStatus == 4 then
                        return mission:progressEvent(542)
                    elseif missionStatus == 5 then
                        return mission:progressEvent(543)
                    end
                end,
            },

            ['Shakir'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(556)
                    end
                end,
            },

            onEventFinish =
            {
                [536] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [543] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setMissionStatus(mission.areaId, 6)
                        player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY)
                    end
                end,
            },
        },
    },
}

return mission
