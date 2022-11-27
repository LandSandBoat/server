-----------------------------------
-- Whispers of Dawn
-- Wings of the Goddess Mission 47
-----------------------------------
-- !addmission 5 46
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.WHISPERS_OF_DAWN)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_DREAMY_INTERLUDE },
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

                    return mission:progressEvent(26, 89, 23, 1756, 0, 0, 8323073, 0, hasWeapons)
                end,
            },

            onEventFinish =
            {
                [26] = function(player, csid, option, npc)
                    if option == 1 then
                        xi.mission.setVar(player, xi.mission.log_id.WOTG, xi.mission.id.wotg.A_DREAMY_INTERLUDE, 'Timer', VanadielUniqueDay() + 1)
                        xi.mission.setMustZone(player, xi.mission.log_id.WOTG, xi.mission.id.wotg.A_DREAMY_INTERLUDE)

                        mission:complete(player)
                    end
                end,
            },
        },

    },
}

return mission
