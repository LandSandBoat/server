-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Eald'narche (Phase 1)
-- Zilart Mission 16 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    --50% fast cast, no standback
    mob:addMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 25)
    mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 0, 1, 0, 0)
    mob:addStatusEffectEx(xi.effect.ARROW_SHIELD, 0, 1, 0, 0)
    mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 0)
end

entity.onMobEngage = function(mob, target)
    mob:addStatusEffectEx(xi.effect.SILENCE, 0, 1, 0, 5)
    GetMobByID(mob:getID() + 1):updateEnmity(target)
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() % 9 <= 2 then
        local orbitalOne = GetMobByID(mob:getID() + 3)
        local orbitalTwo = GetMobByID(mob:getID() + 4)

        if orbitalOne and not orbitalOne:isSpawned() then
            orbitalOne:setPos(mob:getPos())
            orbitalOne:spawn()
            orbitalOne:updateEnmity(target)
        elseif orbitalTwo and not orbitalTwo:isSpawned() then
            orbitalTwo:setPos(mob:getPos())
            orbitalTwo:spawn()
            orbitalTwo:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
