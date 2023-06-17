-----------------------------------
-- A Land After Time
-- Rhapsodies of Vana'diel Mission 1-11
-----------------------------------
-- !addmission 13 26
-- Shattered Telepoint (Konschtat) : !pos 135 19 220 108
-- Shattered Telepoint (La Theine) : !pos 334 19 -60 102
-- Shattered Telepoint (Tahrongi)  : !pos 179 35 255 117
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.A_LAND_AFTER_TIME)

mission.reward =
{
    item        = xi.items.CIPHER_OF_LIONS_ALTER_EGO_II,
    keyItem     = xi.ki.RHAPSODY_IN_UMBER,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'hasSeenEvent') == 0 then
                        local rank6 = (player:getRank(player:getNation()) >= 6) and 1 or 0
                        local isLionGhost = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 1 or 0

                        -- We will need to access this for an event in M1-13, store here, as this event displays the blocking
                        -- message.
                        if rank6 == 0 then
                            player:setCharVar('Mission[13][30]wasBlocked', 1)
                        end

                        return mission:event(4, player:getZoneID(), 0, 0, 0, 0, 0, rank6, isLionGhost):setPriority(1005)
                    else
                        -- Note: mission:complete() calls npcUtil.completeMission() and checks giving item
                        -- reward first.  We can spam this until the player can successfully receive everything.
                        mission:complete(player)
                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if not mission:complete(player) then
                        mission:setVar(player, 'hasSeenEvent', 1)
                    end
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'hasSeenEvent') == 0 then
                        local rank6 = (player:getRank(player:getNation()) >= 6) and 1 or 0
                        local isLionGhost = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 1 or 0

                        if rank6 == 0 then
                            player:setCharVar('Mission[13][30]wasBlocked', 1)
                        end

                        return mission:event(15, player:getZoneID(), 0, 0, 0, 0, 0, rank6, isLionGhost):setPriority(1005)
                    else
                        mission:complete(player)
                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    if not mission:complete(player) then
                        mission:setVar(player, 'hasSeenEvent', 1)
                    end
                end,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Shattered_Telepoint'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'hasSeenEvent') == 0 then
                        local rank6 = (player:getRank(player:getNation()) >= 6) and 1 or 0
                        local isLionGhost = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 1 or 0

                        if rank6 == 0 then
                            player:setCharVar('Mission[13][30]wasBlocked', 1)
                        end

                        return mission:event(42, player:getZoneID(), 0, 0, 0, 0, 0, rank6, isLionGhost):setPriority(1005)
                    else
                        mission:complete(player)
                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [42] = function(player, csid, option, npc)
                    if not mission:complete(player) then
                        mission:setVar(player, 'hasSeenEvent', 1)
                    end
                end,
            },
        },
    },
}

return mission
