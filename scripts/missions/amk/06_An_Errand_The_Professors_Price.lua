-----------------------------------
-- An Errand! The Professor's Price
-- A Moogle Kupo d'Etat M6
-- !addmission 10 5
-- qm1 : !pos 420 -10 745 194
-- ORB_OF_SWORDS  : !addkeyitem 1139
-- ORB_OF_CUPS    : !addkeyitem 1140
-- ORB_OF_BATONS  : !addkeyitem 1141
-- ORB_OF_COINS   : !addkeyitem 1142
-- RIPE_STARFRUIT : !addkeyitem 1143
-- Shantotto      : !pos 122 -2 112 239
-----------------------------------
local horutotoID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY },
}

-- TODO: Test and make sure this works
local orbKeyItems =
{
    -- keyItem, mod, immune value, vulnerable value
    { xi.ki.ORB_OF_SWORDS, xi.mod.SLASH_SDT,       0, 1000 },
    { xi.ki.ORB_OF_CUPS,   xi.mod.BLUNT_SDT,       0, 1000 },
    { xi.ki.ORB_OF_BATONS, xi.mod.PIERCE_SDT,      0, 1000 },
    { xi.ki.ORB_OF_COINS,  xi.mod.UDMGMAGIC,  -10000,    0 },
}

local beginCardianFight = function(player, npc)
    local numToSpawn = 15

    local modsToAdd = {}

    -- Count KI's so we know how many Cardians to spawn
    local removedKIs = 0
    for _, entry in ipairs(orbKeyItems) do
        local keyItemId   = entry[1]
        local immunity    = entry[2]
        local immuneValue = entry[3]
        local vulnValue   = entry[4]

        if player:hasKeyItem(keyItemId) then
            table.insert(modsToAdd, { immunity, vulnValue })

            player:delKeyItem(keyItemId)
            removedKIs = removedKIs + 1
        else
            table.insert(modsToAdd, { immunity, immuneValue })
        end
    end

    if removedKIs == 3 then
        numToSpawn = 10
    elseif removedKIs == 4 then
        numToSpawn = 5
    end

    local cardianIds = {}
    for cardianId = horutotoID.mob.CUSTOM_CARDIAN_OFFSET, horutotoID.mob.CUSTOM_CARDIAN_OFFSET + numToSpawn - 1, 1 do
        table.insert(cardianIds, cardianId)
    end

    -- Spawn mobs and start battle
    xi.confrontation.start(player, npc, cardianIds, function(playerArg)
        npcUtil.giveKeyItem(playerArg, xi.keyItem.RIPE_STARFRUIT)
        npcUtil.giveKeyItem(playerArg, xi.keyItem.PEACH_CORAL_KEY)
    end)

    -- Apply mods
    for _, mobId in pairs(cardianIds) do
        local mob = GetMobByID(mobId)
        if mob then
            for _, entry in pairs(modsToAdd) do
                local mod = entry[1]
                local val = entry[2]
                mob:setMod(mod, val)
            end
        end
    end
end

mission.sections =
{
    -- Go get the Starfruit
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                missionStatus == 0 and
                not player:hasKeyItem(xi.ki.RIPE_STARFRUIT)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(508)
                end,
            },
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['qm1'] =
            {
                -- Only need one KI orb to start fight
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.ORB_OF_SWORDS) or
                        player:hasKeyItem(xi.ki.ORB_OF_CUPS) or
                        player:hasKeyItem(xi.ki.ORB_OF_BATONS) or
                        player:hasKeyItem(xi.ki.ORB_OF_COINS)
                    then
                        -- Prompt to start the fight
                        return mission:progressEvent(100)
                    else
                        -- Remind that orbs are needed
                        return mission:messageSpecial(horutotoID.text.IF_HAD_ORBS, xi.ki.ORB_OF_SWORDS, xi.ki.ORB_OF_CUPS, xi.ki.ORB_OF_BATONS, xi.ki.ORB_OF_COINS)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    -- Violence was chosen, start fight
                    if option == 1 then
                        beginCardianFight(player, npc)
                    end
                end,
            },
        },
    },

    -- Got the Starfruit
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                missionStatus == 0 and
                player:hasKeyItem(xi.ki.RIPE_STARFRUIT) and
                not player:needToZone()
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    local hasGil = player:getGil() >= 5000 and 0 or 1
                    return mission:progressEvent(507, 0, player:getGil(), hasGil)
                end,
            },

            onEventFinish =
            {
                [507] = function(player, csid, option, npc)
                    if option == 0 then -- Dont Pay
                        player:needToZone(true)
                    elseif option == 1 then -- Pay
                        player:delGil(5000)
                        player:delKeyItem(xi.ki.RIPE_STARFRUIT)
                        player:setMissionStatus(xi.mission.log_id.AMK, 1)
                    end
                end,
            },
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(horutotoID.text.CANNOT_ENTER_BATTLEFIELD, xi.ki.RIPE_STARFRUIT):setPriority(1000)
                end,
            },
        },
    },

    -- Watch Shantotto uncurse the moogle and get digging instructions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(509)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    local diggingZone = xi.amk.helpers.getDiggingZone(player)
                    local diggingZoneCsId = xi.amk.helpers.digSites[diggingZone].eventID
                    return mission:progressEvent(10182, diggingZoneCsId)
                end,
            },

            onEventFinish =
            {
                [10182] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
