-----------------------------------
-- Area: Bastok Markets
--  NPC: Lamepaue
-- Type: Past Event Watcher
-- !pos -172.136 -5 -69.632 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Bastok Missions.
    local bastokMissions = 0xFFFFFFFE
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM) then
        bastokMissions = bastokMissions - 2 -- Fetichism.
    end

    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.TO_THE_FORSAKEN_MINES) then
        bastokMissions = bastokMissions - 4 -- To the Forsaken Mines.
    end

    -- Bastok Quests.
    local bastokQuests = 0xFFFFFFFE
    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER) then
        bastokQuests = bastokQuests - 2     -- The Return of the Adventurer
    end
-- *Need the correct csid
--     if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING) then
--         bastokQuests = bastokQuests - 4     -- The First Meeting
--     end
    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR) then
        bastokQuests = bastokQuests - 8     -- Wish Upon a Star (pt.1)
        bastokQuests = bastokQuests - 16    -- Wish Upon a Star (pt.2)
        bastokQuests = bastokQuests - 32    -- Wish Upon a Star (pt.3)
    end

-- *Need the correct csid/parameters
--    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.ALL_BY_MYSELF) then
--        bastokQuests = bastokQuests - 64    -- All by Myself
--    end
    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.ACHIEVING_TRUE_POWER) then
        bastokQuests = bastokQuests - 128   -- Achieving True Power
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.TOO_MANY_CHEFS) then
        bastokQuests = bastokQuests - 512   -- Too Many Chefs
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.A_PROPER_BURIAL) then
        bastokQuests = bastokQuests - 1024  -- A Proper Burial (pt.1)
        bastokQuests = bastokQuests - 2048  -- A Proper Burial (pt.2)
        bastokQuests = bastokQuests - 4096  -- A Proper Burial (pt.3)
        bastokQuests = bastokQuests - 8192  -- A Proper Burial (pt.4)
        bastokQuests = bastokQuests - 16384 -- A Proper Burial (pt.5)
        bastokQuests = bastokQuests - 32768 -- A Proper Burial (pt.6)
    end

    -- Other Quests.
    local otherQuests = 0xFFFFFFFE
    if player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN) then
        otherQuests = otherQuests - 2      -- Beat Around the Bushin
    end

    if player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.CONFESSIONS_OF_A_BELLMAKER) then
        otherQuests = otherQuests - 4      -- Confessions of a Bellmaker
    end

    if player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.PICTURE_PERFECT) then
        otherQuests = otherQuests - 8      -- Picture Perfect (pt.1)
        otherQuests = otherQuests - 16     -- Picture Perfect (pt.2)
        otherQuests = otherQuests - 32     -- Picture Perfect (pt.3)
        otherQuests = otherQuests - 64     -- Picture Perfect (pt.4)
    end

    if player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED) then
        otherQuests = otherQuests - 128    -- No Strings Attached
    end

    if player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES) then
        otherQuests = otherQuests - 256    -- Puppetmaster Blues (pt.1)
        otherQuests = otherQuests - 512    -- Puppetmaster Blues (pt.2)
    end

    if player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN) then
        otherQuests = otherQuests - 1024   -- Comeback Queen
    end

-- *This quest, as of the time this script was written, is not yet defined.
--     if player:hasCompletedQuest(**Unknown**, DANCER_ATTIRE) then
--         otherQuests = otherQuests - 2048   -- Dancer Attire (pt.1)
--         otherQuests = otherQuests - 4096   -- Dancer Attire (pt.2)
--     end
    if player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.DRAFTED_BY_THE_DUCHY) then
        otherQuests = otherQuests - 8192   -- Drafted by the Duchy
    end

    if player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BATTLE_ON_A_NEW_FRONT) then
        otherQuests = otherQuests - 16384  -- Battle on a New Front
    end

    if player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.VOIDWALKER_OP_126) then
        otherQuests = otherQuests - 32768  -- VW Op. #126: Qufim Incursion
    end

-- *This quest, as of the time this script was written, is not yet defined.
--     if player:hasCompletedQuest(**Unknown**, RECORDS_OF_EMINENCE) then
--         otherQuests = otherQuests - 65536  -- Records of Eminence
--     end

-- *This quest, as of the time this script was written, is not yet defined.
--     if player:hasCompletedQuest(**Unknown**, TRUST_MUMOR) then
--         otherQuests = otherQuests - 131072 -- Trust (Mumor)
--     end

-- *This quest, as of the time this script was written, is not yet defined.
--     if player:hasCompletedQuest(**Unknown**, UNITY_CONCORD) then
--         otherQuests = otherQuests - 262144 -- Unity Concord (pt.1)
--         otherQuests = otherQuests - 524288 -- Unity Concord (pt.2)
--     end

    -- Seekers of Adoulin
    local seekersOfAdoulin = 0xFFFFFFFE
-- *Need the correct csid
--    if player:hasCompletedMission (xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST) then
--        seekersOfAdoulin = seekersOfAdoulin - 2 -- Rumors from the West
--    end

    -- Determine if any cutscenes are available for the player.
    local gil = player:getGil()
    if
        bastokMissions == 0xFFFFFFFE and
        bastokQuests == 0xFFFFFFFE and
        otherQuests == 0xFFFFFFFE and
        seekersOfAdoulin == 0xFFFFFFFE
    then -- Player has no cutscenes available to be viewed.
        gil = 0 -- Setting gil to a value less than 10(cost) will trigger the appropriate response from this npc.
    end

    player:startEvent(326, bastokMissions, bastokQuests, otherQuests, seekersOfAdoulin, 0xFFFFFFFE, 0xFFFFFFFE, 10, gil)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if not player:delGil(10) then
        player:setLocalVar('Lamepaue_PlayCutscene', 2)  -- Cancel the cutscene.
        player:updateEvent(0)
    else
        player:setLocalVar('Lamepaue_PlayCutscene', 1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if player:getLocalVar('Lamepaue_PlayCutscene') < 2 then
        if option == 1 then        -- Fetichism.
            player:startEvent(1008)
        elseif option == 2 then        -- To the Forsaken Mines.
            player:startEvent(1010)
        elseif option == 33 then        -- The Return of the Adventurer
            player:startEvent(243)
--        elseif option == 34 then        -- The First Meeting
--            player:startEvent(CSID)
        elseif option == 35 then        -- Wish Upon a Star (pt.1)
            player:startEvent(329)
        elseif option == 36 then        -- Wish Upon a Star (pt.2)
            player:startEvent(332)
        elseif option == 37 then        -- Wish Upon a Star (pt.3)
            player:startEvent(334)
--        elseif option == 38 then        -- All by Myself
--            player:startEvent(185)
        elseif option == 39 then        -- Achieving True Power
            player:startEvent(441)
        elseif option == 40 then        -- Too Many Chefs
            player:startEvent(411)
        elseif option == 41 then        -- A Proper Burial (pt.1)
            player:startEvent(475)
        elseif option == 42 then        -- A Proper Burial (pt.2)
            player:startEvent(477)
        elseif option == 43 then        -- A Proper Burial (pt.3)
            player:startEvent(479)
        elseif option == 44 then        -- A Proper Burial (pt.4)
            player:startEvent(481)
        elseif option == 45 then        -- A Proper Burial (pt.5)
            player:startEvent(483)
        elseif option == 46 then        -- A Proper Burial (pt.6)
            player:startEvent(485)
        elseif option == 65 then        -- Beat Around the Bushin
            player:startEvent(342)
        elseif option == 66 then        -- Confessions of a Bellmaker
            player:startEvent(402)
-- Picture Perfect cutscenes need to be verified.
        elseif option == 67 then        -- Picture Perfect (pt.1)
            player:startEvent(403)
        elseif option == 68 then        -- Picture Perfect (pt.2)
            player:startEvent(404)
        elseif option == 69 then        -- Picture Perfect (pt.3)
            player:startEvent(405)
        elseif option == 70 then        -- Picture Perfect (pt.4)
            player:startEvent(406)
        elseif option == 71 then        -- No Strings Attached
            player:startEvent(434)
        elseif option == 72 then        -- Puppetmaster Blues (pt.1)
            player:startEvent(437)
        elseif option == 73 then        -- Puppetmaster Blues (pt.2)
            player:startEvent(439)
        elseif option == 74 then        -- Comeback Queen
            player:startEvent(490)
--        elseif option == 75 then        -- Dancer Attire (pt.1)
--            player:startEvent(CSID)
--        elseif option == 76 then        -- Dancer Attire (pt.2)
--            player:startEvent(CSID)
-- Drafted by the Duchy and Battle on a New Front cutscenes need to be verified, ids may need to be changed or have additional parameters.
        elseif option == 77 then        -- Drafted by the Duchy
            player:startEvent(18)
        elseif option == 78 then        -- Battle on a New Front
            player:startEvent(12)
        elseif option == 79 then        -- VW Op. #126: Qufim Incursion
            player:startEvent(258)
--        elseif option == 80 then        -- Records of Eminence
--            player:startEvent(CSID)
--        elseif option == 81 then        -- Trust (Mumor)
--            player:startEvent(CSID)
--        elseif option == 82 then        -- Unity Concord (pt.1)
--            player:startEvent(CSID)
--        elseif option == 83 then        -- Unity Concord (pt.2)
--            player:startEvent(CSID)
--        elseif option == 129 then        -- Rumors from the West
--            player:startEvent(CSID)
        end
    end

    player:setLocalVar('Lamepaue_PlayCutscene', 0)
end

return entity
