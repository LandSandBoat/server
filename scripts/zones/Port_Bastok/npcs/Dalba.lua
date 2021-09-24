-----------------------------------
-- Area: Port Bastok
--  NPC: Dalba
-- Type: Past Event Watcher
-- !pos -174.101 -7 -19.611 236
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Bastok Missions.
    local BastokMissions = 0xFFFFFFFE
    if (player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)) then
        BastokMissions = BastokMissions - 2 -- Fetichism.
    end
    if (player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.TO_THE_FORSAKEN_MINES)) then
        BastokMissions = BastokMissions - 4 -- To the Forsaken Mines.
    end

    -- Bastok Quests.
    local BastokQuests = 0xFFFFFFFE
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)) then
        BastokQuests = BastokQuests - 2         -- Beauty and the Galka.
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WELCOME_TO_BASTOK)) then
        BastokQuests = BastokQuests - 4         -- Welcome to Bastok.
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GUEST_OF_HAUTEUR)) then
        BastokQuests = BastokQuests - 8         -- Guest of Hauteur.
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)) then
        BastokQuests = BastokQuests - 16        -- Cid's Secret.
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_USUAL)) then
        BastokQuests = BastokQuests - 32        -- The Usual.
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE)) then
        BastokQuests = BastokQuests - 64        -- Love and Ice(pt.1).
        BastokQuests = BastokQuests - 128     -- Love and Ice(pt.2).
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)) then
        BastokQuests = BastokQuests - 256       -- A Test of True Love(pt.1).
        BastokQuests = BastokQuests - 512     -- A Test of True Love(pt.2).
        BastokQuests = BastokQuests - 1024     -- A Test of True Love(pt.3).
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)) then
        BastokQuests = BastokQuests - 2048      -- Lovers in the Dusk
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST)) then
        BastokQuests = BastokQuests - 4096      -- Ghosts of the Past(pt.1).
        BastokQuests = BastokQuests - 8192     -- Ghosts of the Past(pt.2).
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING)) then
        BastokQuests = BastokQuests - 16384     -- The First Meeting(pt.1).
        BastokQuests = BastokQuests - 32768     -- The First Meeting(pt.2).
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE)) then
        BastokQuests = BastokQuests - 65536     -- Ayame and Kaede(pt.1).
        BastokQuests = BastokQuests - 131072     -- Ayame and Kaede(pt.2).
        BastokQuests = BastokQuests - 262144     -- Ayame and Kaede(pt.3).
        BastokQuests = BastokQuests - 524288     -- Ayame and Kaede(pt.4).
        BastokQuests = BastokQuests - 1048576     -- Ayame and Kaede(pt.5).
    end
-- *Need to determine the correct csid/appropriate options for this cutscene
    --if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)) then
    --    BastokQuests = BastokQuests - 2097152   -- Trial by Earth.
    --end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WALLS_OF_YOUR_MIND)) then
        BastokQuests = BastokQuests - 4194304   -- The Walls of Your Mind(pt.1).
        BastokQuests = BastokQuests - 8388608     -- The Walls of Your Mind(pt.2).
        BastokQuests = BastokQuests - 16777216     -- The Walls of Your Mind(pt.3).
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FADED_PROMISES)) then
        BastokQuests = BastokQuests - 33554432  -- Faded Promises.
    end
    if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.OUT_OF_THE_DEPTHS)) then
        BastokQuests = BastokQuests - 67108864  -- Out of the Depths(pt.1).

-- *Need to determine the appropriate options for this cutscene
        -- BastokQuests = BastokQuests - 134217728 -- Out of the Depths(pt.2).
    end

    -- Other Quests.
    local OtherQuests = 0xFFFFFFFE
    if (player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER)) then
        OtherQuests = OtherQuests - 2 -- The Puppet Master(pt.1).
        OtherQuests = OtherQuests - 4 -- The Puppet Master(pt.2).
    end
    if (player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)) then
        OtherQuests = OtherQuests - 8  -- 20 in Pirate Years(pt.1).
        OtherQuests = OtherQuests - 16    -- 20 in Pirate Years(pt.2).
    end
    if (player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)) then
        OtherQuests = OtherQuests - 32 -- I'll Take the Big Box.
    end

-- *Need the correct csids
    -- if (player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CHASING_DREAMS)) then
    --     OtherQuests = OtherQuests - 64  -- Chasing Dreams(pt.1).
    --     OtherQuests = OtherQuests - 128 -- Chasing Dreams(pt.2).
    -- end

-- *This quest, as of the time this script was written, is not yet defined.
    -- if (player:hasCompletedQuest(**Unknown**, MONSTROSITY)) then
    --     OtherQuests = OtherQuests - 256 -- Monstrosity.
    -- end

    -- Promathia Missions.
    local PromathiaMissions = 0xFFFFFFFE
    if (player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)) then
        PromathiaMissions = PromathiaMissions - 2 -- The Call of the Wyrmking.
    end
    if (player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)) then
        PromathiaMissions = PromathiaMissions - 4 -- The Enduring Tumult of War.
    end

    -- Add-on Scenarios.
    local AddonScenarios = 0xFFFFFFFE
    if (player:hasCompletedMission(xi.mission.log_id.AMK, xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP)) then
        AddonScenarios = AddonScenarios - 2 -- Drenched! It Began with a Raindrop.
    end
-- *Need the correct csid
--    if (player:hasCompletedMission(xi.mission.log_id.AMK, xi.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO)) then
--        AddonScenarios = AddonScenarios - 4 -- Hasten! In a Jam in Jeuno?
--    end

    -- Determine if any cutscenes are available for the player.
    local gil = player:getGil()
    if (BastokMissions    == 0xFFFFFFFE and
        BastokQuests      == 0xFFFFFFFE and
        OtherQuests       == 0xFFFFFFFE and
        PromathiaMissions == 0xFFFFFFFE and
        AddonScenarios    == 0xFFFFFFFE)
    then -- Player has no cutscenes available to be viewed.
        gil = 0 -- Setting gil to a value less than 10(cost) will trigger the appropriate response from this npc.
    end

    player:startEvent(260, BastokMissions, BastokQuests, OtherQuests, PromathiaMissions, AddonScenarios, 0xFFFFFFFE, 10, gil)
end

entity.onEventUpdate = function(player, csid, option)
    if (player:delGil(10) == false) then
        player:setLocalVar("Dalba_PlayCutscene", 2)  -- Cancel the cutscene.
        player:updateEvent(0)
    else
        player:setLocalVar("Dalba_PlayCutscene", 1)
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

entity.onEventFinish = function(player, csid, option)
    if player:getLocalVar("Dalba_PlayCutscene") < 2 then
        for k, eventData in pairs(eventByOption) do
            if option == k then
                player:startEvent(unpack(eventData))
            end
        end
    end

    player:setLocalVar("Dalba_PlayCutscene", 0)
end

return entity
