-----------------------------------
-- Area: Al'Taieu
--  NPC: ??? (Jailer of Prudence Spawn)
-- Allows players to spawn the Jailer of Prudence by trading the Third Virtue, Deed of Sensibility, and High-Quality Hpemde Organ to a ???.
-- !pos , 706 -1 22
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    -- JAILER OF PRUDENCE
    if (
        not GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1):isSpawned() and
        not GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2):isSpawned() and
        trade:hasItemQty(1856, 1) and -- third_virtue
        trade:hasItemQty(1870, 1) and -- deed_of_sensibility
        trade:hasItemQty(1871, 1) and -- high-quality_hpemde_organ
        trade:getItemCount() == 3
    ) then
        player:tradeComplete()
        SpawnMob(ID.mob.JAILER_OF_PRUDENCE_1):updateClaim(player) -- Spawn Jailer of Prudence 1
        SpawnMob(ID.mob.JAILER_OF_PRUDENCE_2)                     -- Spawn Jailer of Prudence 2 unclaimed
    end
end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)
end
