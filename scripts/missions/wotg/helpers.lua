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
