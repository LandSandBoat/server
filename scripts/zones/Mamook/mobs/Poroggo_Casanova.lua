-----------------------------------
-- Area: Mamook
-- Mob: Poroggo Casanova
-- ToAU Quest: Prince and the Hopper
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")

function onMobSpawn(mob)
end

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER) == QUEST_ACCEPTED and player:getCharVar("princeandhopper") == 4 then
        player:setCharVar("princeandhopper", 5)
    end
    for i = ID.mob.POROGGO_CASANOVA + 1, ID.mob.POROGGO_CASANOVA + 5 do
        DespawnMob(i)
    end
end

function onMobDespawn(mob)
    for i = ID.mob.POROGGO_CASANOVA + 1, ID.mob.POROGGO_CASANOVA + 5 do
        DespawnMob(i)
    end
end