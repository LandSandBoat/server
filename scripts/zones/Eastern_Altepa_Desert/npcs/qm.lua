-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: ???
-- Involved In Quest: A Craftsman's Work
-- !pos 113 -7.972 -72 114
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local decurioKilled = player:getCharVar("Decurio_I_IIIKilled")

    if
        player:getCharVar("aCraftsmanWork") == 1 and
        decurioKilled == 0 and
        not GetMobByID(ID.mob.DECURIO_I_III):isSpawned()
    then
        SpawnMob(ID.mob.DECURIO_I_III, 300):updateClaim(player)
    elseif decurioKilled == 1 then
        player:addKeyItem(xi.ki.ALTEPA_POLISHING_STONE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ALTEPA_POLISHING_STONE)
        player:setCharVar("aCraftsmanWork", 2)
        player:setCharVar("Decurio_I_IIIKilled", 0)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
