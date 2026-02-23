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
    for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
        local pet = GetMobByID(i)
        if
            pet and
            pet:getCurrentAction() == xi.action.category.ROAMING
        then
            pet:updateEnmity(target)
        end
    end

    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
            local bodyguard = GetMobByID(ID.mob.MEDUSA + 1)
            if bodyguard and not bodyguard:isSpawned() then
                bodyguard:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                SpawnMob(i):updateEnmity(target)
                break
            end
        end
    end
end

entity.onMobDisengage = function(mob)
    for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
        DespawnMob(i)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.GORGONSTONE_SUNDERER)
        player:showText(mob, ID.text.MEDUSA_DEATH)
    end

    if optParams.isKiller or optParams.noKiller then
        for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
            DespawnMob(i)
        end
    end
end

return entity
