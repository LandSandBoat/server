-----------------------------------
-- Area: Al'Taieu
--  NPC: ??? (Jailer of Hope Spawn)
-- Allows players to spawn the Jailer of Hope by trading the First Virtue, Deed of Placidity and HQ Phuabo Organ to a ???.
-- !pos -693 -1 -62 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    -- JAILER OF HOPE
    if (
        not GetMobByID(ID.mob.JAILER_OF_HOPE):isSpawned() and
        trade:hasItemQty(1850, 1) and -- first_virtue
        trade:hasItemQty(1851, 1) and -- deed_of_placidity
        trade:hasItemQty(1852, 1) and -- high-quality_phuabo_organ
        trade:getItemCount() == 3
    ) then
        player:tradeComplete()
        SpawnMob(ID.mob.JAILER_OF_HOPE):updateClaim(player)
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
