-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Goblin Wolfman
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addMod(xi.mod.ACC, 70) -- Very accurate
    mob:setLocalVar('weaponOn', 0)
end

entity.onMobFight = function(mob, target)
    local weaponOn = mob:getLocalVar('weaponOn')
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and weaponOn == 0 then
        mob:addMod(xi.mod.DELAY, 1500)
        mob:addMod(xi.mod.ATTP, 160)
        mob:setLocalVar('weaponOn', 1)
    elseif not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and weaponOn == 1 then
        mob:delMod(xi.mod.DELAY, 1500)
        mob:delMod(xi.mod.ATTP, 160)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 245)
end

return entity
