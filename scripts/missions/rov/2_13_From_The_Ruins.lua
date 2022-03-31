-----------------------------------
-- From The Ruins
-- Rhapsodies of Vana'diel Mission 2-13
-----------------------------------
-- !addmission 13 70
-- NPC: Imperial Whitegate : !pos 152, -2, 0, 50
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.FROM_THE_RUINS)

mission.reward =
{
    keyItem     = xi.ki.RHAPSODY_IN_CRIMSON,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.CAUTERIZE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
             ['Imperial_Whitegate'] =
            {
                -- Todo: Find trigger point
                -- 0 x x x use Alphau name
                -- 1 x x x uses Nashmeira name
                -- x 0 x x don't know about maw
                -- x 1 x x know about maw
                -- no difference from other option

                onTrigger = function(player, npc)

                    if xi.rhapsodies.charactersAvailable(player) then
                            return mission:event(169, 0, 0, 0, 0, 0 , 0, 0, 0, 0):setPriority(1005)
                            -- capture @10min https://www.youtube.com/watch?v=_Ks5orwjMag
                    end

                end,
            },

            onEventFinish =
            {
                [169] = function(player, csid, option, npc)
                        mission:complete(player)
                end,
            },
        },
    },
}

return mission
