-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Fossil Rock
-- Used in Mission: Windurst Mission 2-1
-- !pos 17 18 184 198 + <many pos>
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.FOSSIL_ROCK_OFFSET
    local windyMiss = player:getCurrentMission(WINDURST)
    local windyStat = player:getCharVar("MissionStatus")
    local randfoss = player:getCharVar("MissionStatus_randfoss")

    -- LOST FOR WORDS
    if offset <= 6 and windyMiss == xi.mission.id.windurst.LOST_FOR_WORDS and (windyStat == 2 or windyStat == 3) then
        if randfoss == 0 or randfoss > 6 then -- account for values higher than 6 from defunct code
            randfoss = math.random(1, 6)
            player:setCharVar("MissionStatus_randfoss", randfoss)
        end

        if (offset == 0 and randfoss == 1) or (offset > 1 and offset == randfoss) then -- clicked target stone
            if player:hasKeyItem(xi.ki.LAPIS_CORAL) then
                player:messageSpecial(ID.text.FOSSIL_EXTRACTED)
            else
                player:setCharVar("MissionStatus", 3)
                npcUtil.giveKeyItem(player, xi.ki.LAPIS_CORAL)
            end
        else
            player:messageSpecial(ID.text.NOTHING_FOSSIL)
        end

    -- BLAST FROM THE PAST
    elseif offset == 8 and player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST) == QUEST_ACCEPTED then
        if not GetMobByID(ID.mob.ICHOROUS_IRE):isSpawned() and not player:hasItem(16511) then
            SpawnMob(ID.mob.ICHOROUS_IRE):updateClaim(player)
        else
            player:messageSpecial(ID.text.FOSSIL_EXTRACTED + 2) -- NM spawn point message.
        end

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.NOTHING_FOSSIL)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
