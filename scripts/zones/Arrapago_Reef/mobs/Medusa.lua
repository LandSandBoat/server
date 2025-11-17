-----------------------------------
-- Area: Arrapago Reef
--   NM: Medusa
-- !pos -458 -20 458
-- TODO: resists, attack/def boosts
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        chance = 75, -- "Is possible that she will not use Eagle Eye Shot at all." (guessing 75 percent)
        specials =
        {
            { id = xi.jsa.EES_LAMIA, hpp = math.random(5, 99) },
        },
    })
end

entity.onMobEngage = function(mob, target)
    target:showText(mob, ID.text.MEDUSA_ENGAGE)
    for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
        SpawnMob(i):updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        local mob1 = GetMobByID(ID.mob.MEDUSA + 1)
        if mob1 and not mob1:isSpawned() then
            mob1:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.MEDUSA + 1):updateEnmity(target)
        else
            local mob2 = GetMobByID(ID.mob.MEDUSA + 2)
            if mob2 and not mob2:isSpawned() then
                mob2:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                SpawnMob(ID.mob.MEDUSA + 2):updateEnmity(target)
            else
                local mob3 = GetMobByID(ID.mob.MEDUSA + 3)
                if mob3 and not mob3:isSpawned() then
                    mob3:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                    SpawnMob(ID.mob.MEDUSA + 3):updateEnmity(target)
                else
                    local mob4 = GetMobByID(ID.mob.MEDUSA + 4)
                    if mob4 and not mob4:isSpawned() then
                        mob4:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                        SpawnMob(ID.mob.MEDUSA + 4):updateEnmity(target)
                    end
                end
            end
        end
    end

    for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
        local pet = GetMobByID(i)
        if
            pet and
            pet:getCurrentAction() == xi.action.category.ROAMING
        then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDisengage = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.MEDUSA + i) end
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.MEDUSA_DEATH)
    player:addTitle(xi.title.GORGONSTONE_SUNDERER)
    for i = 1, 4 do DespawnMob(ID.mob.MEDUSA + i) end
end

entity.onMobDespawn = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.MEDUSA + i) end
end

return entity
