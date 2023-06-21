-----------------------------------
-- Area: Sacrarium
--  Mob: Mariselles' Pupils
-----------------------------------
local ID = require('scripts/zones/Sacrarium/IDs')
local professorTables = require('scripts/zones/Sacrarium/globals')
require('scripts/globals/missions')
require('scripts/globals/utils')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setCarefulPathing(true)

    for i = 0, 5 do
        if GetNPCByID(ID.npc.QM_MARISELLE_OFFSET + i):getLocalVar('hasProfessorMariselle') == 1 then
            mob:setLocalVar('spawnLocation', i)
        end
    end
end

entity.onMobFight = function(mob, target)
    local teleTime = mob:getLocalVar('teleTime')
    if
        mob:getBattleTime() - teleTime > 30 and
        mob:getBattleTime() > 59 and
        mob:actionQueueEmpty()
    then
        local profLocation = mob:getLocalVar('spawnLocation')
        local randomPosition = math.random(1, 9)
        utils.mobTeleport(mob, 2000, professorTables.locations[profLocation][randomPosition])
        mob:setLocalVar('teleTime', mob:getBattleTime())
    end

    if mob:checkDistance(mob:getTarget()) > 55 then
        mob:disengage()
        mob:resetEnmity(target)
    end
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('teleTime', 0)
end

return entity
