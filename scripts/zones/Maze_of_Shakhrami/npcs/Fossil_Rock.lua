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

    -- BLAST FROM THE PAST
    if offset == 8 and player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST) == QUEST_ACCEPTED then
        if not GetMobByID(ID.mob.ICHOROUS_IRE):isSpawned() and not player:hasItem(16511) then
            SpawnMob(ID.mob.ICHOROUS_IRE):updateClaim(player)
        else
            player:messageSpecial(ID.text.FOSSIL_EXTRACTED + 2) -- NM spawn point message.
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
