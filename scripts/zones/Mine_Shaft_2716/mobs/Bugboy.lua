-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Bugboy
-- ENM : Bionic Bug
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 20)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Use Mighty Strikes at 75%, 50%, and 25% HP.
    local hPP = mob:getHPP()
    local mightyStrikes = mob:getLocalVar('mightyStrikes')
    if hPP <= 75 and mightyStrikes == 0 then
        mob:setLocalVar('mightyStrikes', 1)
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
    elseif hPP <= 50 and mightyStrikes == 1 then
        mob:setLocalVar('mightyStrikes', 2)
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
    elseif hPP <= 25 and mightyStrikes == 2 then
        mob:setLocalVar('mightyStrikes', 3)
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
    end

    -- Takes double magic damage while under the effects of Mighty Strikes.
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        mob:setMod(xi.mod.UDMGMAGIC, 10000)
    else
        mob:setMod(xi.mod.UDMGMAGIC, 0)
    end

    -- 50% chance to follow up a TP move with a damaging TP move.
    local followUpSkills =
    {
        xi.mobSkill.HEAVY_BLOW,
        xi.mobSkill.HEAVY_WHISK,
        xi.mobSkill.FLYING_HIP_PRESS,
        xi.mobSkill.EARTH_SHOCK,
    }
    if
        mob:getLocalVar('skillUsed') ~= 0 and
        math.random(1, 100) <= 50
    then
        mob:useMobAbility(followUpSkills[math.random(1, #followUpSkills)])
        mob:setLocalVar('skillUsed', 1)
    else
        mob:setLocalVar('skillUsed', 0)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if mob:getLocalVar('skillUsed') ~= 0 then
        mob:setLocalVar('skillUsed', 0)
    else
        mob:setLocalVar('skillUsed', 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
