-----------------------------------
-- Wings of the Goddess Helpers
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

xi = xi or {}
xi.wotg = xi.wotg or {}
xi.wotg.helpers = xi.wotg.helpers or {}

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

-- WOTG3: Cait Sith
xi.wotg.helpers.meetsMission3Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.CLAWS_OF_THE_GRIFFON) == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.THE_TIGRESS_STRIKES)  == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.FIRES_OF_DISCONTENT)  == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end

-- WOTG4: The Queen of the Dance
xi.wotg.helpers.meetsMission4Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.BURDEN_OF_SUSPICION)  == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.WRATH_OF_THE_GRIFFON) == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.A_MANIFEST_PROBLEM)   == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end

-- WOTG8: In the Name of the Father
xi.wotg.helpers.meetsMission8Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.FIRE_IN_THE_HOLE)   == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.IN_A_HAZE_OF_GLORY) == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.A_FEAST_FOR_GNATS)  == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end

-- WOTG15: Crossroads of Time
xi.wotg.helpers.meetsMission15Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.HONOR_UNDER_FIRE)     == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.BONDS_THAT_NEVER_DIE) == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.THE_FORBIDDEN_PATH)   == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end

-- WOTG26: Fate in Haze
xi.wotg.helpers.meetsMission26Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.WHAT_PRICE_LOYALTY)    == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.BLOOD_OF_HEROES)       == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.HOWL_FROM_THE_HEAVENS) == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end

-- WOTG38: Adieu, Lilisette
xi.wotg.helpers.meetsMission38Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.BONDS_OF_MYTHRIL)   == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.FACE_OF_THE_FUTURE) == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.AT_JOURNEYS_END)    == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end
