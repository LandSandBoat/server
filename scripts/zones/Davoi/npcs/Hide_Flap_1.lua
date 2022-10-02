-----------------------------------
-- Area: Davoi
--  NPC: Hide Flap 1
-- Involved in Quest: The Doorman
-- !pos 293 3 -213 149 (WAR)(K-9)
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- THE DOORMAN
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN) == QUEST_ACCEPTED and not player:hasKeyItem(xi.ki.SWORD_GRIP_MATERIAL) then
        if player:getCharVar("theDoormanKilledNM") >= 2 then
            npcUtil.giveKeyItem(player, xi.ki.SWORD_GRIP_MATERIAL)
            player:setCharVar("theDoormanMyMob", 0)
            player:setCharVar("theDoormanKilledNM", 0)
        elseif not GetMobByID(ID.mob.GAVOTVUT):isSpawned() and not GetMobByID(ID.mob.BARAKBOK):isSpawned() then
            SpawnMob(ID.mob.GAVOTVUT):updateClaim(player)
            SpawnMob(ID.mob.BARAKBOK):updateClaim(player)
            player:setCharVar("theDoormanMyMob", 1)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
