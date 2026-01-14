-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Bugboy
-- ENM : Bionic Bug
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Use Mighty Strikes at 75%, 50%, and 25% HP.
    local mobHPP = mob:getHPP()
    local mightyStrikesCount = mob:getLocalVar('mightyStrikesCount')
    if mobHPP <= 75 and mightyStrikesCount == 0 then
        mob:setLocalVar('mightyStrikesCount', 1)
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
    elseif mobHPP <= 50 and mightyStrikesCount == 1 then
        mob:setLocalVar('mightyStrikesCount', 2)
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
    elseif mobHPP <= 25 and mightyStrikesCount == 2 then
        mob:setLocalVar('mightyStrikesCount', 3)
        mob:useMobAbility(xi.mobSkill.MIGHTY_STRIKES_1)
    end

    -- Takes 50% increased magic damage after using the 2nd Mighty Strikes and 100% after using the 3rd.
    if
        mightyStrikesCount == 2 and
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)
    then
        mob:setMod(xi.mod.UDMGMAGIC, 5000)
    elseif
        mightyStrikesCount == 3 and
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)
    then
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
    -- Bugboy always follows up Mighty Strikes with Heavy Blow.
    if skill:getID() == xi.mobSkill.MIGHTY_STRIKES_1 then
        mob:useMobAbility(xi.mobSkill.HEAVY_BLOW)
    end

    if mob:getLocalVar('skillUsed') ~= 0 then
        mob:setLocalVar('skillUsed', 0)
    else
        mob:setLocalVar('skillUsed', 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
