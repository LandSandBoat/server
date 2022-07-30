-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Procreator
-- TODO: Verify cmbDelay
-----------------------------------
mixins = {require("scripts/mixins/families/empty_terroanima")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("maxBabies", 4)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 10)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local fission = 755
    local random = math.random()
    if mob:getHPP() <= 50 then
        if random < 0.6 then
            return fission
        else
            return 0
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getTP() >= 2000 then
        mob:useMobAbility()
    end
    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() - 1) --Agonizer aggros at <20%
        if not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    local momma = mob:getID()
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
end

return entity
