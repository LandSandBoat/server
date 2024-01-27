-----------------------------------
-- Area: Sealions Den
--   NM: Ultima
-----------------------------------
local oneToBeFeared = require('scripts/zones/Sealions_Den/bcnms/one_to_be_feared_helper')
-----------------------------------
local entity = {}

local abilities = { 1259, 1260, 1269, 1270 }

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 728)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local stage = mob:getLocalVar('stage')
    if stage == 0 then
        local checker = math.random()
        if checker < 0.50 then
            return abilities[1]
        elseif checker < 0.75 then
            return abilities[3]
        else
            return abilities[4]
        end
    elseif stage == 3 then
        -- does a specific order of moves in final phase
        local order = mob:getLocalVar('order')

        if order == 0 then
            mob:setLocalVar('order', 1)
            return abilities[4]
        elseif order == 1 then
            mob:setLocalVar('order', 2)
            return abilities[2]
        else
            mob:setLocalVar('order', 0)
            return abilities[2]
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- After using Nuclear Waste use a random elemental conal attack
    if skill:getID() == 1268 then
        mob:timer(4000, function(mobArg)
            local ability = math.random(1262, 1267)
            mob:useMobAbility(ability)
        end)
    end
end

entity.onMobFight = function(mob, target)
    local stage = mob:getLocalVar('stage')
    local hpp = mob:getHPP()
    if stage == 0 and hpp < 70 then
        mob:setLocalVar('stage', 1)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 1190)
    elseif stage == 1 and hpp < 40 then
        mob:setLocalVar('stage', 2)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 1191)
    elseif stage == 2 and hpp < 20 then
        mob:setLocalVar('stage', 3)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 1192)
        mob:setMod(xi.mod.REGAIN, 100)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { duration = 60 })
end

entity.onMobDeath = function(mob, player, optParams)
    oneToBeFeared.handleUltimaDeath(mob, player, optParams)
end

return entity
