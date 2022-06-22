-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Agonizer
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
    if mob:getHPP() <= 25 then
        if roll <= 0.25 then
            return 1252 -- Shadow_spread
        else
            return 1248 -- Trinary_absorption
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getTP() >= 2000 then
        mob:useMobAbility()
    end
    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() + 6) --Cumulator aggros at <20%
        if not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
