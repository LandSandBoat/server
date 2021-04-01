-----------------------------------
-- Area: Mamook
-- Mob: Poroggo Casanova
-- ToAU Quest: Prince and the Hopper
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER) == QUEST_ACCEPTED and player:getCharVar("princeandhopper") == 4 then
        player:setCharVar("princeandhopper", 5)
    end
    for i = ID.mob.POROGGO_CASANOVA + 1, ID.mob.POROGGO_CASANOVA + 5 do
        DespawnMob(i)
    end
end

entity.onMobDespawn = function(mob)
    for i = ID.mob.POROGGO_CASANOVA + 1, ID.mob.POROGGO_CASANOVA + 5 do
        DespawnMob(i)
    end
end

return entity
