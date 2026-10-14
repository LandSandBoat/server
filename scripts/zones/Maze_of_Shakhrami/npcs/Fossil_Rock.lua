-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Fossil Rock
-- Spawns Ichorous Ire
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local rockOffset = npc:getID() - ID.npc.FOSSIL_ROCK_OFFSET

    if rockOffset ~= 8 then
        return
    end

    local mob = GetMobByID(ID.mob.ICHOROUS_IRE)
    if
        mob and
        not mob:isSpawned() and
        GetSystemTime() >= mob:getLocalVar('cooldown') and
        not player:hasItem(xi.item.BURNITE_SHELL_STONE)
    then
        mob:spawn()
        mob:updateClaim(player)
    else
        player:messageSpecial(ID.text.FOSSIL_EXTRACTED + 2)
    end
end

return entity
