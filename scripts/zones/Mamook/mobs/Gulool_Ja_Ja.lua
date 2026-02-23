-----------------------------------
-- Area: Mamook
--  Mob: Gulool Ja Ja
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobEngage = function(mob, target)
    for i = ID.mob.GULOOL_JA_JA + 1, ID.mob.GULOOL_JA_JA + 4 do
        SpawnMob(i):updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    for i = ID.mob.GULOOL_JA_JA + 1, ID.mob.GULOOL_JA_JA + 4 do
        local pet = GetMobByID(i)
        if pet and pet:getCurrentAction() == xi.action.category.ROAMING then
            pet:updateEnmity(target)
        end
    end

    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        for i = ID.mob.GULOOL_JA_JA + 1, ID.mob.GULOOL_JA_JA + 4 do
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
    for i = ID.mob.GULOOL_JA_JA + 1, ID.mob.GULOOL_JA_JA + 4 do
        DespawnMob(i)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.SHINING_SCALE_RIFLER)
    end

    if optParams.isKiller or optParams.noKiller then
        for i = ID.mob.GULOOL_JA_JA + 1, ID.mob.GULOOL_JA_JA + 4 do
            DespawnMob(i)
        end
    end
end

return entity
