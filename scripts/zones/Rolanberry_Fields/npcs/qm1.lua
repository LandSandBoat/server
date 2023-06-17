-----------------------------------
-- Area: Rolanberry Fields
--  NPC: qm1 (???)
-- !pos -686.216 -31.556 -369.723 110
-- Notes: Spawns Chuglix Berrypaws for ACP mission "Gatherer of Light (I)"
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        not GetMobByID(ID.mob.CHUGLIX_BERRYPAWS):isSpawned() and
        player:hasKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE) and
        not player:hasKeyItem(xi.ki.SEEDSPALL_CAERULUM) and
        not player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    then
        SpawnMob(ID.mob.CHUGLIX_BERRYPAWS):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
