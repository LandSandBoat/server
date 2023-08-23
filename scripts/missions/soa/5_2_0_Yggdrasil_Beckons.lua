-----------------------------------
-- Yggdrasil Beckons
-- Seekers of Adoulin M5-2
-----------------------------------
-- !addmission 12 112
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.YGGDRASIL_BECKONS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.RETURNING_TO_THE_TREES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 256),
        },

        [xi.zone.CIRDAS_CAVERNS] =
        {
            ['Wavering_Flux'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 2) then
                        return mission:progressEvent(34, 270, 0, 20, 100, 0, 0, 0, 0)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        mission:isVarBitsSet(player, 'Status', 3) and
                        not player:hasKeyItem(xi.ki.DHOKMAKS_BLOOD_SIGIL)
                    then
                        return 36
                    end
                end,
            },

            onEventFinish =
            {
                [34] = function(player, csid, option, npc)
                    -- NOTE: For future Instance implementation, ensure that this bit is set, and that
                    -- Sun Yellow Pome KI is removed upon instance entry and displays Lost KeyItem message.

                    mission:setVarBit(player, 'Status', 2)
                end,

                [36] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DHOKMAKS_BLOOD_SIGIL)

                    if player:hasKeyItem(xi.ki.ASHRAKKS_BLOOD_SIGIL) then
                        mission:complete(player)
                    end
                end,
            },
        },

        [xi.zone.CIRDAS_CAVERNS_U] =
        {
            onEventFinish =
            {
                -- TODO: The assumption for this mission script is to catch Event 1000 which is
                -- sent once the battlefield has been cleared.  This needs to be verified upon
                -- implementation of the instance.

                -- If instance does not handle, add "Vanquisher of Dhokmak" Title here.

                [1000] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Status', 3)
                    player:setPos(300, 29.998, -79, 64, xi.zone.CIRDAS_CAVERNS)
                end,
            },
        },

        [xi.zone.YORCIA_WEALD] =
        {
            ['Wavering_Flux'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 0) then
                        return mission:progressEvent(3, 263, 0, 200, 100, 379558, 1978, 544958, 0)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        mission:isVarBitsSet(player, 'Status', 1) and
                        not player:hasKeyItem(xi.ki.ASHRAKKS_BLOOD_SIGIL)
                    then
                        return 4
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    -- NOTE: For future Instance implementation, ensure that this bit is set, and that
                    -- Sky Blue Pome KI is removed upon instance entry and displays Lost KeyItem message.

                    mission:setVarBit(player, 'Status', 0)
                end,

                [4] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ASHRAKKS_BLOOD_SIGIL)

                    if player:hasKeyItem(xi.ki.DHOKMAKS_BLOOD_SIGIL) then
                        mission:complete(player)
                    end
                end,
            },
        },

        [xi.zone.YORCIA_WEALD_U] =
        {
            onEventFinish =
            {
                -- TODO: The assumption for this mission script is to catch Event 1000 which is
                -- sent once the battlefield has been cleared.  This needs to be verified upon
                -- implementation of the instance.

                -- If instance does not handle, add "Vanquisher of Ashrakk" Title here.

                [1000] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Status', 1)
                    player:setPos(34, 1.124, 372, 0, xi.zone.YORCIA_WEALD)
                end,
            },
        },

        [xi.zone.LEAFALLIA] =
        {
            ['Aged_Stump'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: This is assumed, and following the pattern for KI replacement from previous missions.
                    -- This needs to be verified

                    if
                        not player:hasKeyItem(xi.ki.SKY_BLUE_POME) and
                        not player:hasKeyItem(xi.ki.ASHRAKKS_BLOOD_SIGIL)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.SKY_BLUE_POME)
                    end

                    if
                        not player:hasKeyItem(xi.ki.SUN_YELLOW_POME) and
                        not player:hasKeyItem(xi.ki.DHOKMAKS_BLOOD_SIGIL)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.SUN_YELLOW_POME)
                    end

                    return mission:noAction()
                end,
            },
        },
    },
}

return mission
