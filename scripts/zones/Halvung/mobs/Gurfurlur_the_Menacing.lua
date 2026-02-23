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
    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        local pet = GetMobByID(i)

        if pet and pet:getCurrentAction() == xi.action.category.ROAMING then
            pet:updateEnmity(target)
        end
    end

    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
            local bodyguard = GetMobByID(i)
            if bodyguard and not bodyguard:isSpawned() then
                bodyguard:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
                SpawnMob(i):updateEnmity(target)
                break
            end
        end
    end
end

entity.onMobDisengage = function(mob)
    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        DespawnMob(i)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.TROLL_SUBJUGATOR)
    end

    if optParams.isKiller or optParams.noKiller then
        for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
            DespawnMob(i)
        end
    end
end

return entity
