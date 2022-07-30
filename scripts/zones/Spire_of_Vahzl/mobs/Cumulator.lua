-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Cumulator
-- TODO: Verify cmbDelay
-----------------------------------
mixins = {require("scripts/mixins/families/empty_terroanima")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local roll = math.random()
    if mob:getHPP() <= 35 then
        if roll <= 0.7 then
            return 1234 -- Carousel
        else
            return 1274 -- Impalement
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getTP() >= 2000 then
        mob:useMobAbility()
    end
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
