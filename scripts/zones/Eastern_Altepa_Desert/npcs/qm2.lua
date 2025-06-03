-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: qm2 (???)
-- Involved In Quest: 20 in Pirate Years
-- !pos 47.852 -7.808 403.391 114
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local twentyInPirateYearsCS = player:getCharVar('twentyInPirateYearsCS')
    local tsuchigumoKilled = player:getCharVar('TsuchigumoKilled')

    if
        twentyInPirateYearsCS == 3 and
        tsuchigumoKilled <= 1 and
        not GetMobByID(ID.mob.TSUCHIGUMO_OFFSET):isSpawned() and
        not GetMobByID(ID.mob.TSUCHIGUMO_OFFSET + 1):isSpawned()
    then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.TSUCHIGUMO_OFFSET):updateClaim(player)
        SpawnMob(ID.mob.TSUCHIGUMO_OFFSET + 1):updateClaim(player)
    elseif twentyInPirateYearsCS == 3 and tsuchigumoKilled >= 2 then
        npcUtil.giveKeyItem(player, xi.ki.TRICK_BOX)
        player:setCharVar('twentyInPirateYearsCS', 4)
        player:setCharVar('TsuchigumoKilled', 0)
    end
end

return entity
