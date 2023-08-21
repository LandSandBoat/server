-----------------------------------
-- Into the Beast's Maw
-- Wings of the Goddess Mission 33
-----------------------------------
-- !addmission 5 32
-- Rally Point: Red : !pos -106.071 -25.5 -52.841 137
-- Peculiar Glint   : !pos 179.439 -24.056 100.032 138
-----------------------------------
local pastBaileysID   = zones[xi.zone.CASTLE_ZVAHL_BAILEYS_S]
local pastXarcabardID = zones[xi.zone.XARCABARD_S]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.INTO_THE_BEASTS_MAW)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_HUNTER_ENSNARED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.XARCABARD_S] =
        {
            ['Rally_Point_Red'] = mission:messageSpecial(pastXarcabardID.text.JOIN_ALLIED_FORCE),
        },

        [xi.zone.CASTLE_ZVAHL_BAILEYS_S] =
        {
            ['Ornate_Block'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.DISTRESS_SIGNAL_FLARE) and
                        mission:getVar(player, 'Status') == 4
                    then
                        if mission:getVar(player, 'Timer') <= VanadielUniqueDay() then
                            return mission:progressEvent(11, 138)
                        else
                            player:messageName(pastBaileysID.text.CANNOT_FIND_FLARE, nil, xi.ki.DISTRESS_SIGNAL_FLARE)

                            return mission:noAction()
                        end
                    end
                end,
            },

            ['Peculiar_Glint'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Instance entry requires the Distress Signal Flare awarded after the
                    -- cutscene (or replaced by the Ornate Block).  Entry Event 6, Options 0, 32.
                    -- Upon entering, the player is sent to Ghoyu's Reverie (467.375, -0.173, 119.999, R=2)

                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return mission:progressEvent(2, 53, 23, 1756, 0, 0, 16384001, 0, 0)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return 1
                    elseif missionStatus == 2 then
                        return 14
                    elseif missionStatus == 3 then
                        return 15
                    elseif missionStatus == 5 then
                        return 3
                    end
                end,
            },

            onEventUpdate =
            {
                [14] = function(player, csid, option, npc)
                    if option == 5 then
                        player:updateEvent(138, 23, 1756, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [2] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(183.405, -24.041, 100.041, 126, xi.zone.CASTLE_ZVAHL_BAILEYS_S)
                end,

                [3] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [11] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.DISTRESS_SIGNAL_FLARE)
                    end
                end,

                [14] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                    player:setPos(183.405, -24.041, 100.041, 126, xi.zone.CASTLE_ZVAHL_BAILEYS_S)
                end,

                [15] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DISTRESS_SIGNAL_FLARE)
                    mission:setVar(player, 'Status', 4)
                end,
            },
        },

        [xi.zone.GHOYUS_REVERIE] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    -- TODO: The assumption for this mission script is to catch Event 10000 which is
                    -- sent once the battlefield has been cleared.  This needs to be verified upon
                    -- implementation of the instance.

                    mission:setVar(player, 'Status', 5)
                    player:setPos(179.987, -24.046, 94.225, 194, xi.zone.CASTLE_ZVAHL_BAILEYS_S)
                end,
            },
        },
    },
}

return mission
