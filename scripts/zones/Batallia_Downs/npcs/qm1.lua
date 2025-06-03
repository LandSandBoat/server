-----------------------------------
-- Area: Batallia Downs
--  NPC: qm1 (???)
-- !pos -407.526 -23.507 412.544 105
-- Notes: Spawns Vegnix Greenthumb for ACP mission "Gatherer of Light (I)"
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        not GetMobByID(ID.mob.VEGNIX_GREENTHUMB):isSpawned() and
        player:hasKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and
        not player:hasKeyItem(xi.ki.SEEDSPALL_ROSEUM) and
        not player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    then
        SpawnMob(ID.mob.VEGNIX_GREENTHUMB):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

return entity
