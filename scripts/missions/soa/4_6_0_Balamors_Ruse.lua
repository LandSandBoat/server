-----------------------------------
-- Balamor's Ruse
-- Seekers of Adoulin M4-6
-----------------------------------
-- !addmission 12 104
-- Levil           : !pos -87.204 3.350 12.655 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.BALAMORS_RUSE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_CHARLATAN },
}

local keyItemOnMobDeath =
{
    onMobDeath = function(mob, player, optParams)
        -- TODO: Mobs that grant this KI and the rate in which it drops needs to be measured further.  This
        -- is currently set to a lower value than observed in capture.

        if math.random(1, 100) <= 20 then
            local playerZoneID = player:getZoneID()

            for _, partyMember in ipairs(player:getParty()) do
                if
                    partyMember:getZoneID() == playerZoneID and
                    partyMember:getCurrentMission(xi.mission.log_id.SOA) == xi.mission.id.soa.THE_CHARLATAN
                then
                    npcUtil.giveKeyItem(partyMember, xi.ki.CONSUMMATE_SIMULACRUM)
                end
            end
        end
    end,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 255, 0, 61110144, 4640962, 3903, 131181),
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            -- TODO: This might apply to all mobs in zone, but currently only implements mobs that
            -- were specifically mentioned in sources.

            ['Duskbringer_Bat']    = keyItemOnMobDeath,
            ['New_Moon_Bats']      = keyItemOnMobDeath,
            ['Skittering_Spider']  = keyItemOnMobDeath,
            ['Spoutdrenched_Toad'] = keyItemOnMobDeath,
            ['Waterway_Pugil']     = keyItemOnMobDeath,

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 369
                    end
                end,
            },

            onEventFinish =
            {
                [369] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.RALA_WATERWAYS_U] =
        {
            onEventFinish =
            {
                -- TODO: The assumption for this mission script is to catch Event 1000 which is
                -- sent once the battlefield has been cleared.  This needs to be verified upon
                -- implementation of the instance.
                [1000] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(309.98, -5.768, -299.833, 128, xi.zone.RALA_WATERWAYS)
                end,
            },
        },
    },
}

return mission
