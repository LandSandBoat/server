-----------------------------------
-- Pillar of Hope
-- Wings of the Goddess Mission 43
-----------------------------------
-- !addmission 5 42
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.PILLAR_OF_HOPE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.GLIMMER_OF_LIFE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Veridical_Conflux'] =
            {
                onTrigger = function(player, npc)
                    local hasWeapons = (player:getEquipID(xi.slot.MAIN) ~= 0 or player:getEquipID(xi.slot.SUB) ~= 0) and 1 or 0
                    local isRepeated = mission:getVar(player, 'Option')

                    return mission:progressEvent(28, 89, 23, 1743, isRepeated, 0, 0, 0, hasWeapons)
                end,
            },

            onEventFinish =
            {
                [28] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)

                        xi.mission.setVar(player, xi.mission.log_id.WOTG, xi.mission.id.wotg.GLIMMER_OF_LIFE, 'Timer', VanadielUniqueDay() + 1)
                        xi.mission.setMustZone(player, xi.mission.log_id.WOTG, xi.mission.id.wotg.GLIMMER_OF_LIFE)
                    else
                        mission:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },
}

return mission
