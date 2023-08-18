-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: qm1 (???)
-- !pos 203.939 0.000 -238.811 120
-- Notes: Spawns Dribblix Greasemaw for ACP mission "Gatherer of Light (I)"
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        not GetMobByID(ID.mob.DRIBBLIX_GREASEMAW):isSpawned() and
        player:hasKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB) and
        not player:hasKeyItem(xi.ki.SEEDSPALL_VIRIDIS) and
        not player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    then
        SpawnMob(ID.mob.DRIBBLIX_GREASEMAW):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
