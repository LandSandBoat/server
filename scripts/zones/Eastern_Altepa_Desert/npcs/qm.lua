-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: ???
-- Involved In Quest: A Craftsman's Work
-- !pos 113 -7.972 -72 114
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local decurioKilled = player:getCharVar('Decurio_I_IIIKilled')

    if
        player:getCharVar('aCraftsmanWork') == 1 and
        decurioKilled == 0 and
        not GetMobByID(ID.mob.DECURIO_I_III):isSpawned()
    then
        SpawnMob(ID.mob.DECURIO_I_III, 300):updateClaim(player)
    elseif decurioKilled == 1 then
        npcUtil.giveKeyItem(player, xi.ki.ALTEPA_POLISHING_STONE)
        player:setCharVar('aCraftsmanWork', 2)
        player:setCharVar('Decurio_I_IIIKilled', 0)
    end
end

return entity
