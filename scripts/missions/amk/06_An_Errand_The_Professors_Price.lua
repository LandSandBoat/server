-----------------------------------
-- An Errand! The Professor's Price
-- A Moogle Kupo d'Etat M6
-- !addmission 10 5
-- qm1 : !pos 420 -10 745 194
-----------------------------------
require('scripts/globals/confrontation')
require('scripts/globals/missions')
require("scripts/globals/npc_util")
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY },
}

local beginCardianFight = function(player, npc)
    local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
    local numToSpawn = 15

    local cardianIds = {}
    for cardianId = ID.mob.CUSTOM_CARDIAN_OFFSET, ID.mob.CUSTOM_CARDIAN_OFFSET + numToSpawn - 1, 1 do
        table.insert(cardianIds, cardianId)
    end

    xi.confrontation.start(player, npc, cardianIds, function(playerArg)
        npcUtil.giveKeyItem(playerArg, xi.keyItem.RIPE_STARFRUIT)
    end)
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    player:delKeyItem(xi.keyItem.RIPE_STARFRUIT)
                    return mission:progressEvent(100)
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    if option == 1 then
                        beginCardianFight(player, npc)
                    end
                end,
            },
        },
    },
}

return mission
