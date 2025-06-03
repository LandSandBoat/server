-----------------------------------
-- Area: Xarcabard
--  NPC: qm7 (???)
-- Involved in Quests: RNG AF3 quest - Unbridled Passion
-- !pos -295.065 -25.054 151.250 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCharVar('unbridledPassion') == 4 and
        not GetMobByID(ID.mob.KOENIGSTIGER):isSpawned()
    then
        player:startEvent(8)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 8 then
        SpawnMob(ID.mob.KOENIGSTIGER):updateClaim(player)
    end
end

return entity
