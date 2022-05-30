-----------------------------------
-- Area: Sacrarium
--  Mob: Old Professor Mariselle
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local opMariselle = mob:getID()

    -- Summons a pupil every 30 seconds.
    -- TODO: Casting animation for summons. When he spawns them isn't retail accurate.
    -- TODO: Make him and the clones teleport around the room every 30s

    if (mob:getBattleTime() % 30 < 3 and mob:getBattleTime() > 3) then
        local xPos = mob:getXPos()
        local yPos = mob:getYPos()
        local zPos = mob:getZPos()

        for i = opMariselle + 1, opMariselle + 2 do
            local m = GetMobByID(i)
            if not m:isSpawned() then
                m:spawn()
                m:updateEnmity(target)
                m:setPos(xPos + 1, yPos, zPos + 1) -- Set pupil x and z position +1 from Mariselle
                return
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    local opMariselle = mob:getID()

    for i = opMariselle + 1, opMariselle + 2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function( mob )
    local opMariselle = mob:getID()

    for i = opMariselle + 1, opMariselle + 2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    -- randomize Old Prof. Mariselle's spawn location
    local nextSpawn = math.random(0,5)
    for i = 0, 5 do
        GetNPCByID(ID.npc.QM_MARISELLE_OFFSET + i):setLocalVar("hasProfessorMariselle", (i == nextSpawn) and 1 or 0)
    end
end

return entity
