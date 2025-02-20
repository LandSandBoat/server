-----------------------------------
-- Area: Port Bastok
--  NPC: Dalba
-- Type: Past Event Watcher
-- !pos -174.101 -7 -19.611 236
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
    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA) then
        bastokQuests = bastokQuests - 2         -- Beauty and the Galka.
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.WELCOME_TO_BASTOK) then
        bastokQuests = bastokQuests - 4         -- Welcome to Bastok.
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.GUEST_OF_HAUTEUR) then
        bastokQuests = bastokQuests - 8         -- Guest of Hauteur.
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.CIDS_SECRET) then
        bastokQuests = bastokQuests - 16        -- Cid's Secret.
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.THE_USUAL) then
        bastokQuests = bastokQuests - 32        -- The Usual.
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE) then
        bastokQuests = bastokQuests - 64        -- Love and Ice(pt.1).
        bastokQuests = bastokQuests - 128     -- Love and Ice(pt.2).
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE) then
        bastokQuests = bastokQuests - 256       -- A Test of True Love(pt.1).
        bastokQuests = bastokQuests - 512     -- A Test of True Love(pt.2).
        bastokQuests = bastokQuests - 1024     -- A Test of True Love(pt.3).
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK) then
        bastokQuests = bastokQuests - 2048      -- Lovers in the Dusk
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST) then
        bastokQuests = bastokQuests - 4096      -- Ghosts of the Past(pt.1).
        bastokQuests = bastokQuests - 8192     -- Ghosts of the Past(pt.2).
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING) then
        bastokQuests = bastokQuests - 16384     -- The First Meeting(pt.1).
        bastokQuests = bastokQuests - 32768     -- The First Meeting(pt.2).
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE) then
        bastokQuests = bastokQuests - 65536     -- Ayame and Kaede(pt.1).
        bastokQuests = bastokQuests - 131072     -- Ayame and Kaede(pt.2).
        bastokQuests = bastokQuests - 262144     -- Ayame and Kaede(pt.3).
        bastokQuests = bastokQuests - 524288     -- Ayame and Kaede(pt.4).
        bastokQuests = bastokQuests - 1048576     -- Ayame and Kaede(pt.5).
    end
-- *Need to determine the correct csid/appropriate options for this cutscene
    --if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH) then
    --    bastokQuests = bastokQuests - 2097152   -- Trial by Earth.
    --end
    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.THE_WALLS_OF_YOUR_MIND) then
        bastokQuests = bastokQuests - 4194304   -- The Walls of Your Mind(pt.1).
        bastokQuests = bastokQuests - 8388608     -- The Walls of Your Mind(pt.2).
        bastokQuests = bastokQuests - 16777216     -- The Walls of Your Mind(pt.3).
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.FADED_PROMISES) then
        bastokQuests = bastokQuests - 33554432  -- Faded Promises.
    end

    if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.OUT_OF_THE_DEPTHS) then
        bastokQuests = bastokQuests - 67108864  -- Out of the Depths(pt.1).

-- *Need to determine the appropriate options for this cutscene
        -- bastokQuests = bastokQuests - 134217728 -- Out of the Depths(pt.2).
    end

    -- Other Quests.
    local otherQuests = 0xFFFFFFFE
    if player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER) then
        otherQuests = otherQuests - 2 -- The Puppet Master(pt.1).
        otherQuests = otherQuests - 4 -- The Puppet Master(pt.2).
    end

    if player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS) then
        otherQuests = otherQuests - 8  -- 20 in Pirate Years(pt.1).
        otherQuests = otherQuests - 16    -- 20 in Pirate Years(pt.2).
    end

    if player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) then
        otherQuests = otherQuests - 32 -- I'll Take the Big Box.
    end

-- *Need the correct csids
    -- if player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.CHASING_DREAMS) then
    --     otherQuests = otherQuests - 64  -- Chasing Dreams(pt.1).
    --     otherQuests = otherQuests - 128 -- Chasing Dreams(pt.2).
    -- end

-- *This quest, as of the time this script was written, is not yet defined.
    -- if player:hasCompletedQuest(**Unknown**, MONSTROSITY) then
    --     otherQuests = otherQuests - 256 -- Monstrosity.
    -- end

    -- Promathia Missions.
    local promathiaMissions = 0xFFFFFFFE
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING) then
        promathiaMissions = promathiaMissions - 2 -- The Call of the Wyrmking.
    end

    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR) then
        promathiaMissions = promathiaMissions - 4 -- The Enduring Tumult of War.
    end

    -- Add-on Scenarios.
    local addonScenarios = 0xFFFFFFFE
    if player:hasCompletedMission(xi.mission.log_id.AMK, xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP) then
        addonScenarios = addonScenarios - 2 -- Drenched! It Began with a Raindrop.
    end

-- *Need the correct csid
--    if player:hasCompletedMission(xi.mission.log_id.AMK, xi.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO) then
--        addonScenarios = addonScenarios - 4 -- Hasten! In a Jam in Jeuno?
--    end

    -- Determine if any cutscenes are available for the player.
    local gil = player:getGil()
    if
        bastokMissions == 0xFFFFFFFE and
        bastokQuests == 0xFFFFFFFE and
        otherQuests == 0xFFFFFFFE and
        promathiaMissions == 0xFFFFFFFE and
        addonScenarios == 0xFFFFFFFE
    then -- Player has no cutscenes available to be viewed.
        gil = 0 -- Setting gil to a value less than 10(cost) will trigger the appropriate response from this npc.
    end

    player:startEvent(260, bastokMissions, bastokQuests, otherQuests, promathiaMissions, addonScenarios, 0xFFFFFFFE, 10, gil)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if not player:delGil(10) then
        player:setLocalVar('Dalba_PlayCutscene', 2)  -- Cancel the cutscene.
        player:updateEvent(0)
    else
        player:setLocalVar('Dalba_PlayCutscene', 1)
    end
end

local eventByOption =
{
    [  1] = {  1008, }, -- Fetichism
    [  2] = {  1010, }, -- To the Forsaken Mines
    [ 33] = {     2, }, -- Beauty and the Galka
    [ 34] = {    52, }, -- Welcome to Bastok
    [ 35] = {    55, }, -- Guest of Hauteur
    [ 36] = {   133, }, -- Cid's Secret
    [ 37] = {   136, }, -- The Usual
    [ 38] = {   185, }, -- Love and Ice(pt.1)
    [ 39] = {   186, }, -- Love and Ice(pt.2)
    [ 40] = {   270, }, -- A Test of True Love(pt.1)
    [ 41] = {   272, }, -- A Test of True Love(pt.2)
    [ 42] = {   274, }, -- A Test of True Love(pt.3)
    [ 43] = {   275, }, -- Lovers in the Dusk
    [ 44] = {   231, }, -- Ghosts of the Past(pt.1)
    [ 45] = {   232, }, -- Ghosts of the Past(pt.2)
    [ 46] = {   233, }, -- The First Meeting(pt.1)
    [ 47] = {   234, }, -- The First Meeting(pt.2)
    [ 48] = {   240, }, -- Ayame and Kaede(pt.1)
    [ 49] = {   241, }, -- Ayame and Kaede(pt.2)
    [ 50] = {   242, }, -- Ayame and Kaede(pt.3)
    [ 51] = {   245, }, -- Ayame and Kaede(pt.4)
    [ 52] = {   246, }, -- Ayame and Kaede(pt.5)
--  [ 53] = {   250, 0, xi.ki.TUNING_FORK_OF_EARTH, 1 }, -- Trial by Earth
    [ 54] = {   286, }, -- The Walls of Your Mind(pt.1)
    [ 55] = {   289, }, -- The Walls of Your Mind(pt.2)
    [ 56] = {   290, }, -- The Walls of Your Mind(pt.3)
    [ 57] = {   296, }, -- Faded Promises
    [ 58] = {   307, }, -- Out of the Depths(pt.1)
--  [ 59] = {   309, 0, 0, 0, 601 }, -- Out of the Depths(pt.2)
    [ 65] = {   256, 0, xi.ki.TUNING_FORK_OF_EARTH, 0, 1169, 0, 0, 0, 0 }, -- The Puppet Master(pt.1)
    [ 66] = {   258, }, -- The Puppet Master(pt.2)
    [ 67] = {   261, }, -- 20 in Pirate Years(pt.1)
    [ 68] = {   263, }, -- 20 in Pirate Years(pt.2)
    [ 69] = {   264, }, -- I'll Take the Big Box
--  [ 70] = {   ???, }, -- Chasing Dreams(pt.1)
--  [ 71] = {   ???, }, -- Chasing Dreams(pt.2)
--  [ 72] = {   ???, }, -- Monstrosity
    [ 97] = {   305, }, -- The Call of the Wyrmking
    [ 98] = {   306, }, -- The Enduring Tumult of War
    [129] = { 30025, 0, 0, 0, 0, 0, 0, 236 }, -- Drenched! It Began with a Raindrop
}

entity.onEventFinish = function(player, csid, option, npc)
    if player:getLocalVar('Dalba_PlayCutscene') < 2 then
        for k, eventData in pairs(eventByOption) do
            if option == k then
                player:startEvent(unpack(eventData))
            end
        end
    end

    player:setLocalVar('Dalba_PlayCutscene', 0)
end

return entity
