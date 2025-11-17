-----------------------------------
-- Area: Halvung
--  Mob: Gurfurlur the Menacing
-- !pos -59.000 -23.000 3.000 62
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.HALVUNG]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        SpawnMob(i):updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        local mob1 = GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 1)
        if mob1 and not mob1:isSpawned() then
            mob1:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 1):updateEnmity(target)
        else
            local mob2 = GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 2)
            if mob2 and not mob2:isSpawned() then
                mob2:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 2):updateEnmity(target)
            else
                local mob3 = GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 3)
                if mob3 and not mob3:isSpawned() then
                    mob3:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                    SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 3):updateEnmity(target)
                else
                    local mob4 = GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 4)
                    if mob4 and not mob4:isSpawned() then
                        mob4:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                        SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 4):updateEnmity(target)
                    end
                end
            end
        end
    end

    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        local pet = GetMobByID(i)

        if pet and pet:getCurrentAction() == xi.action.category.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDisengage = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TROLL_SUBJUGATOR)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

entity.onMobDespawn = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

return entity
