-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Korroloka Leech
-- Involved in Quest: Ayame and Kaede
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 180)
end

function onMobDeath(mob, player, isKiller)
    if
        GetMobByID(ID.mob.KORROLOKA_LEECH_I):isDead() and
        GetMobByID(ID.mob.KORROLOKA_LEECH_II):isDead() and
        GetMobByID(ID.mob.KORROLOKA_LEECH_III):isDead() and
        player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.AYAME_AND_KAEDE) == QUEST_ACCEPTED and
        player:getCharVar("AyameAndKaede_Event") == 2
    then
        player:setCharVar("KorrolokaLeeches_Killed", 1)
    end
end
