-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Korroloka Leech
-- Involved in Quest: Ayame and Kaede
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        GetMobByID(ID.mob.KORROLOKA_LEECH_I):isDead() and
        GetMobByID(ID.mob.KORROLOKA_LEECH_II):isDead() and
        GetMobByID(ID.mob.KORROLOKA_LEECH_III):isDead() and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE) == QUEST_ACCEPTED and
        player:getCharVar("AyameAndKaede_Event") == 2
    then
        player:setCharVar("KorrolokaLeeches_Killed", 1)
    end
end

return entity
