-----------------------------------
-- A Place to Return
-- Promathia 6-2
-----------------------------------
-- !addmission 6 618
-- Pherimociel      : !pos -31.627 1.002 67.956 243
-- Dilapidated Gate : !pos 260 9 -435 25
-----------------------------------
local misareauxID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pherimociel'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(28)
                    end
                end,
            },

            ['Auchefort'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(10055)
                    end
                end,
            },

            -- TODO: These persist across multiple missions.  Once the pattern has been established,
            -- these should move into a separate block.
            ['Adolie']          = mission:event(158),
            ['Chapi_Galepilai'] = mission:event(12),
            ['Colti']           = mission:event(22),
            ['Neraf-Najiruf']   = mission:event(31):oncePerZone(),

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(10048)
                    end
                end,
            },

            onEventFinish =
            {
                [10048] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        if mission:getVar(player, 'Option') == 7 then
                            return mission:progressEvent(10)
                        elseif
                            not GetMobByID(misareauxID.mob.PM6_2_MOB_OFFSET + 0):isSpawned() and
                            not GetMobByID(misareauxID.mob.PM6_2_MOB_OFFSET + 1):isSpawned() and
                            not GetMobByID(misareauxID.mob.PM6_2_MOB_OFFSET + 2):isSpawned()
                        then
                            SpawnMob(misareauxID.mob.PM6_2_MOB_OFFSET + 0):updateClaim(player)
                            SpawnMob(misareauxID.mob.PM6_2_MOB_OFFSET + 1):updateClaim(player)
                            SpawnMob(misareauxID.mob.PM6_2_MOB_OFFSET + 2):updateClaim(player)

                            return mission:noAction()
                        end
                    end
                end,
            },

            ['Warder_Aglaia'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 1 then
                        mission:setVarBit(player, 'Option', 0)
                    end
                end,
            },

            ['Warder_Euphrosyne'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 1 then
                        mission:setVarBit(player, 'Option', 1)
                    end
                end,
            },

            ['Warder_Thalia'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getVar(player, 'Status') == 1 then
                        mission:setVarBit(player, 'Option', 2)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
