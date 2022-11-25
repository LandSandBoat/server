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
require('scripts/globals/confrontation')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local horutotoID = require('scripts/zones/Outer_Horutoto_Ruins/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY },
}

local beginCardianFight = function(player, npc)
    local numToSpawn = 15

    local cardianIds = {}
    for cardianId = horutotoID.mob.CUSTOM_CARDIAN_OFFSET, horutotoID.mob.CUSTOM_CARDIAN_OFFSET + numToSpawn - 1, 1 do
        table.insert(cardianIds, cardianId)
    end

    -- TODO: Add immunities to cardians

    -- Remove KIs
    local removedKIs = 0
    if player:hasKeyItem(xi.ki.ORB_OF_SWORDS) then
        player:delKeyItem(xi.ki.ORB_OF_SWORDS)
        -- TODO: Remove slashing damage immunity
    end

    if player:hasKeyItem(xi.ki.ORB_OF_CUPS) then
        player:delKeyItem(xi.ki.ORB_OF_CUPS)
        -- TODO: Remove piercing damage immunity
    end

    if player:hasKeyItem(xi.ki.ORB_OF_BATONS) then
        player:delKeyItem(xi.ki.ORB_OF_BATONS)
        -- TODO: Remove blunt damage immunity
    end

    if player:hasKeyItem(xi.ki.ORB_OF_COINS) then
        player:delKeyItem(xi.ki.ORB_OF_COINS)
        -- TODO: Remove magic damage immunity
    end

    if removedKIs == 3 then
        numToSpawn = 10
    elseif removedKIs == 4 then
        numToSpawn = 5
    end

    xi.confrontation.start(player, npc, cardianIds, function(playerArg)
        npcUtil.giveKeyItem(playerArg, xi.keyItem.RIPE_STARFRUIT)
        npcUtil.giveKeyItem(playerArg, xi.keyItem.PEACH_CORAL_KEY)
    end)
end

mission.sections =
{
    -- Go get the Starfruit
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and not player:hasKeyItem(xi.ki.RIPE_STARFRUIT)
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
                onTrigger = function(player, npc)
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

    -- Got the Starfruit
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
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
                        if mission:complete(player) then
                            player:delGil(5000)
                            player:delKeyItem(xi.ki.RIPE_STARFRUIT)
                        end
                    end
                end,
            },
        },

        [xi.zone.OUTER_HORUTOTO_RUINS] =
        {
            ['qm1'] =
            {
                -- TODO: Reminder about the orbs
                onTrigger = function(player, npc)
                    return mission:messageSpecial(horutotoID.text.CANNOT_ENTER_BATTLEFIELD, xi.ki.RIPE_STARFRUIT):setPriority(1000)
                end,
            },
        },
    },
}

return mission
