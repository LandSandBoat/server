-----------------------------------
-- Betrayal at Beaucedine
-- Wings of the Goddess Mission 19
-----------------------------------
-- !addmission 5 18
-- Regal Pawprints : -15.066 -40.249 -217.276 136
-----------------------------------
local pastBeaucedineID = zones[xi.zone.BEAUCEDINE_GLACIER_S]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.BETRAYAL_AT_BEAUCEDINE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.ON_THIN_ICE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            ['Regal_Pawprints_2'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(15, 136, 300, 200, 100, 0, 9306122, 0, 0)
                    elseif missionStatus == 1 then
                        local zoneObj    = player:getZone()
                        local mobHalphas = zoneObj:queryEntitiesByName('Count_Halphas')[1]

                        if not mobHalphas:isSpawned() then
                            SpawnMob(mobHalphas:getID()):updateClaim(player)

                            return mission:messageSpecial(pastBeaucedineID.text.UNWANTED_ATTENTION)
                        else
                            if player:isEngaged() then
                                return mission:messageSpecial(pastBeaucedineID.text.NOW_IS_NOT_THE_TIME)
                            else
                                return mission:messageSpecial(pastBeaucedineID.text.UNUSUAL_PRESENCE)
                            end
                        end
                    elseif missionStatus == 2 then
                        return mission:progressEvent(16, 0, 300, 200, 100, 0, 0, 0, 0)
                    end
                end,
            },

            ['Count_Halphas'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 1 then
                        mission:setVar(player, 'Status', 2)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 3 then
                        return 30
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [16] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                    player:setPos(-15.036, -40.355, -219.202, 189, xi.zone.BEAUCEDINE_GLACIER_S)
                end,

                [30] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
