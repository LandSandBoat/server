-----------------------------------
-- Area: Batallia Downs
--  NPC: qm2 (???)
-- Pop for the quest "Chasing Quotas"
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local sturmtigerKilled = player:getCharVar("SturmtigerKilled")

    if (player:getCharVar("ChasingQuotas_Progress") == 5 and sturmtigerKilled == 0) then
        SpawnMob(ID.mob.STURMTIGER, 300):updateClaim(player)
    elseif (sturmtigerKilled == 1) then
        player:addKeyItem(xi.ki.RANCHURIOMES_LEGACY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RANCHURIOMES_LEGACY)
        player:setCharVar("ChasingQuotas_Progress", 6)
        player:setCharVar("SturmtigerKilled", 0)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
