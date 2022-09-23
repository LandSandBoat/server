-----------------------------------
-- Area: Al'Taieu
--  NPC: qm_jailer_of_love (???)
-- Allows players to spawn the Jailer of Love by trading the Fourth Virtue, Fifth Virtue and Sixth Virtue to a ???.
-- Allows players to spawn Absolute Virtue by killing Jailer of Love.
-- !pos , 431 -0 -603
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
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

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)
end

return entity
