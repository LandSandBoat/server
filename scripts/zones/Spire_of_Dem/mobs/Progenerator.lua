-----------------------------------
-- Area: Spire of Dem
--  Mob: Progenerator
-- TODO: Verify cmbDelay
-----------------------------------
mixins = { require("scripts/mixins/families/empty_terroanima") }
-----------------------------------

local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.TRIPLE_ATTACK, 10)
    mob:addMod(xi.mod.DEFP, 35)
    mob:setMod(xi.mod.STORETP, 100)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("maxBabies", 4)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local fission = 755
    local random = math.random()

    if mob:getHPP() <= 50 then
        if random < 0.6 then
            return fission
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 35 then
        mob:setMod(xi.mod.STORETP, 250)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local momma = mob:getID()
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
end

return entity
