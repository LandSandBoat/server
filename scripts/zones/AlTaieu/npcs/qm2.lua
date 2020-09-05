-----------------------------------
-- Area: Al'Taieu
--  NPC: ??? (Jailer of Justice Spawn)
-- Allows players to spawn the Jailer of Justice by trading the Second Virtue, Deed of Moderation, and HQ Xzomit Organ to a ???.
-- !pos , -278 0 -463
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    --[[
    -- JAILER OF JUSTICE
    if (
        not GetMobByID(ID.mob.JAILER_OF_JUSTICE):isSpawned() and
        trade:hasItemQty(1853, 1) and -- second_virtue
        trade:hasItemQty(1854, 1) and -- deed_of_moderation
        trade:hasItemQty(1855, 1) and -- hq_xzomit_organ
        trade:getItemCount() == 3
    ) then
        player:tradeComplete()
        SpawnMob(ID.mob.JAILER_OF_JUSTICE):updateClaim(player)
    end
    --]]
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
