-----------------------------------
-- Seal of the Serpent
-- Aht Uhrgan Mission 26
-----------------------------------
-- !addmission 4 25
-- Imperial Whitegate : !pos 152 -2 0 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.SEAL_OF_THE_SERPENT)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.MISPLACED_NOBILITY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3115, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getEquipID(xi.slot.MAIN) == 0 and
                        player:getEquipID(xi.slot.SUB) == 0
                    then
                        return mission:progressEvent(3111, 0, 1, 1, 0, 0, 0, 0, 128)
                    else
                        return mission:event(3114, 0, 1, 0, 0, 0, 0, 1, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3111] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
