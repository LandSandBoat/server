-----------------------------------
-- Area: Al'Taieu
--  NPC: ??? (Jailer of Love and Absolute Virtue Spawn)
-- Allows players to spawn the Jailer of Love by trading the Fourth Virtue, Fifth Virtue and Sixth Virtue to a ???.
-- Allows players to spawn Absolute Virtue by killing Jailer of Love.
-- !pos , 431 -0 -603
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    --[[
    -- JAILER OF LOVE
    if (
        not GetMobByID(ID.mob.JAILER_OF_LOVE):isSpawned() and
        not GetMobByID(ID.mob.ABSOLUTE_VIRTUE):isSpawned() and
        trade:hasItemQty(1848, 1) and -- fourth_virtue
        trade:hasItemQty(1847, 1) and -- fifth_virtue
        trade:hasItemQty(1849, 1) and -- sixth_virtue
        trade:getItemCount() == 3
    ) then
        player:tradeComplete()
        SpawnMob(ID.mob.JAILER_OF_LOVE):updateClaim(player)
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
