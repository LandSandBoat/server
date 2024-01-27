-----------------------------------
-- Daughter of a Knight
-- Wings of the Goddess Mission 10
-----------------------------------
-- !addmission 5 9
-- Amaura                     : !pos -84.367 -6.949 91.148 230
-- CERNUNNOS_BULB             : !additem 2728
-- Humus-rich Earth (past)    : !pos -510.535 7.568 289.283 82
-- Humus-rich Earth (present) : !pos -510.535 7.568 289.283 104
-----------------------------------
local pastJugnerID = zones[xi.zone.JUGNER_FOREST_S]
local presentJugnerID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.DAUGHTER_OF_A_KNIGHT)

mission.reward =
{
    keyItem     = xi.ki.BOTTLE_OF_TREANT_TONIC,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_SPOONFUL_OF_SUGAR },
}

mission.sections =
{
    -- 0: Talk to Amaura at (G-6) in present day Southern San d'Oria.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    -- Observed: 647298804, 0, 1743, 1, 759, 600, 0, 4
                    return mission:progressEvent(935, 0, 2)
                end,
            },

            onEventFinish =
            {
                [935] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 1: Trade a Cernunnos Bulb to Amaura.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CERNUNNOS_BULB) then
                        -- TODO: What are these args from caps?
                        -- Observed : 647298804, 0, 1743, 1, 759, 600, 0, 4
                        return mission:progressEvent(937, 0, 2)
                    end
                end,

                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:event(936)
                    end
                end,
            },

            onEventFinish =
            {
                [936] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,

                [937] = function(player, csid, option, npc)
                    -- NOTE: We don't complete the trade, the player needs to keep the CERNUNNOS_BULB
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- 2. After the cutscene, go to the Maiden's Spring at (E-6) in Jugner Forest (S),
    -- and trade the Cernunnos Bulb to the "Humus-rich Earth." The message "You plant a Cernunnos Bulb."
    -- will display in the chat log.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CERNUNNOS_BULB) then
                        player:confirmTrade()
                        player:setMissionStatus(mission.areaId, 3)

                        return mission:messageSpecial(pastJugnerID.text.YOU_PLANT_ITEM, xi.item.CERNUNNOS_BULB)
                    end
                end,

                onTrigger = function(player, npc)
                    return mission:messageSpecial(pastJugnerID.text.IDEAL_PLACE_TO_PLANT_ITEM, xi.item.CERNUNNOS_BULB)
                end,
            },
        },
    },

    -- 3. Go to present day Jugner Forest at the same spot and examine the "Humus-rich Earth" for a cutscene.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(938):oncePerZone()
                end,
            },
        },

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(pastJugnerID.text.ITEM_IS_PLANTED_HERE, xi.item.CERNUNNOS_BULB)
                end,
            }
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(33, 104, 0, 0, 53) -- TODO: What is this?
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },
    },

    -- 4. Examine it again to fight the Cernunnos NM.
    --    Once Cernunnos is defeated, check the "Humus-rich Earth" again for a cutscene and Cernunnos Resin.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 4
        end,

        [xi.zone.JUGNER_FOREST] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('cernunnosDefeated') == 1 then
                        return mission:progressEvent(34, 104, 300, 200, 100, 0, 1648, 0, 0) -- TODO: What is this?
                    else
                        local mob = GetMobByID(presentJugnerID.mob.CERNUNNOS)

                        if not mob:isSpawned() then
                            SpawnMob(presentJugnerID.mob.CERNUNNOS):updateClaim(player)

                            return mission:messageSpecial(presentJugnerID.text.DRAWN_UNWANTED_ATTENTION)
                        else
                            return mission:messageSpecial(presentJugnerID.text.SENSE_UNUSUAL_PRESENCE)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [34] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CERNUNNOS_RESIN)

                    player:setLocalVar('cernunnosDefeated', 0)
                    player:setMissionStatus(mission.areaId, 5)
                end,
            },
        },
    },

    -- 5. Go back to Southern San d'Oria talk to Amaura for a cutscene.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 5
        end,

        [xi.zone.JUGNER_FOREST] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(presentJugnerID.text.DELIVER_TO_AMAURE)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(939, 0, 0, 0, 31, 0, 0, 1) -- TODO: What is this?
                end,
            },

            onEventFinish =
            {
                [939] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.CERNUNNOS_RESIN)
                    player:setMissionStatus(mission.areaId, 6)

                    mission:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    mission:setMustZone(player)
                end,
            },
        },
    },

    -- 6. Wait until the next game day, zone, and talk to her again for a cutscene and the Bottle of Treant Tonic.
    -- If you talk to her too soon, you must zone before trying again.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 6
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    if
                        not mission:getMustZone(player) and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return mission:progressEvent(941)
                    elseif mission:getLocalVar(player, 'amauraOption') == 0 then
                        -- This event is only encountered once per zone, and then reverts to the default
                        -- dialogue.

                        return mission:progressEvent(940)
                    end
                end,
            },

            onEventFinish =
            {
                [940] = function(player, csid, option, npc)
                    mission:setLocalVar(player, 'amauraOption', 1)
                    mission:setMustZone(player)
                end,

                [941] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
