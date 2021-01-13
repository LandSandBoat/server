-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Cumulator
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.LINK_RADIUS, 50)
end

function onMobSpawn(mob)
end

function onMobEngaged(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() - 5) --Procreator aggros at <20%
        if not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
