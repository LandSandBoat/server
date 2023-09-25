-----------------------------------
-- Wings of the Goddess Helpers
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

xi = xi or {}
xi.wotg = xi.wotg or {}
xi.wotg.helpers = xi.wotg.helpers or {}

local memoryFragments =
{
    xi.ki.LARGE_MEMORY_FRAGMENT1,
    xi.ki.LARGE_MEMORY_FRAGMENT2,
    xi.ki.LARGE_MEMORY_FRAGMENT3,
    xi.ki.LARGE_MEMORY_FRAGMENT4,
}

-- NOTE: The naming convention here is: "meets requirements to complete mission X".
--       meetsMission3Reqs = This function goes in Mission 3.
--       I have completeted BURDEN_OF_SUSPICION or WRATH_OF_THE_GRIFFON
--       or A_MANIFEST_PROBLEM, and can now complete WOTG3, progressing on to WOTG4.
--
--      Compare the tables of the two wikis:
--      https://www.bg-wiki.com/ffxi/Category:Wings_of_the_Goddess_Missions
--      https://ffxiclopedia.fandom.com/wiki/Category:Wings_of_the_Goddess_Missions
--
--      They are laid out differently, so be careful!

xi.wotg.helpers.hasCompletedFirstQuest = function(player)
    return player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
end

-- WOTG3: Cait Sith
xi.wotg.helpers.meetsMission3Reqs = function(player)
    -- TODO: Add one day wait
    return player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT)
end

-- WOTG4: The Queen of the Dance
xi.wotg.helpers.meetsMission4Reqs = function(player)
    -- TODO: Add one day wait
    return player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BURDEN_OF_SUSPICION) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_MANIFEST_PROBLEM)
end

-- WOTG8: In the Name of the Father
xi.wotg.helpers.meetsMission8Reqs = function(player)
    -- TODO: Add one day wait
    return player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRE_IN_THE_HOLE) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.IN_A_HAZE_OF_GLORY) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_FEAST_FOR_GNATS)
end

-- WOTG15: Crossroads of Time
xi.wotg.helpers.meetsMission15Reqs = function(player)
    -- TODO: Add one day wait
    return player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HONOR_UNDER_FIRE) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BONDS_THAT_NEVER_DIE) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FORBIDDEN_PATH)
end

-- WOTG26: Fate in Haze
xi.wotg.helpers.meetsMission26Reqs = function(player)
    -- TODO: Add one day wait
    return player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WHAT_PRICE_LOYALTY) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BLOOD_OF_HEROES) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HOWL_FROM_THE_HEAVENS)
end

-- WOTG38: Adieu, Lilisette
xi.wotg.helpers.meetsMission38Reqs = function(player)
    -- TODO: Add one day wait
    return player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BONDS_OF_MYTHRIL) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.FACE_OF_THE_FUTURE) or
        player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.AT_JOURNEYS_END)
end

xi.wotg.helpers.helmTrade = function(player, helmType, broke)
    local wotgChance = 50
    local zoneId = player:getZoneID()

    if
        helmType == xi.helm.type.LOGGING and
        broke ~= 1 and
        math.random(1, 100) < wotgChance
    then
        if
            zoneId == xi.zone.EAST_RONFAURE_S and
            not player:hasKeyItem(xi.ki.RONFAURE_MAPLE_SYRUP) and
            xi.quest.getVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_PRICE_OF_VALOR, 'Prog') == 1
        then
            npcUtil.giveKeyItem(player, xi.ki.RONFAURE_MAPLE_SYRUP)
            return true
        elseif
            zoneId == xi.zone.JUGNER_FOREST_S and
            not player:hasKeyItem(xi.ki.LENGTH_OF_JUGNER_IVY) and
            xi.quest.getVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BONDS_THAT_NEVER_DIE, 'Prog') == 1
        then
            npcUtil.giveKeyItem(player, xi.ki.LENGTH_OF_JUGNER_IVY)
            return true
        end
    end

    return false
end

xi.wotg.helpers.checkMemoryFragments = function(player)
    local ID = zones[player:getZoneID()]
    local numFragments = 0

    for _, keyItemId in ipairs(memoryFragments) do
        if player:hasKeyItem(keyItemId) then
            numFragments = numFragments + 1
        end
    end

    if numFragments == 3 then
        player:messageName(ID.text.REPORT_TO_CAIT_SITH, nil)

        player:completeMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.HER_MEMORIES)
        player:addMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.FORGET_ME_NOT)
    end
end

xi.wotg.helpers.removeMemoryFragments = function(player)
    for _, keyItemId in ipairs(memoryFragments) do
        player:delKeyItem(keyItemId)
    end
end
