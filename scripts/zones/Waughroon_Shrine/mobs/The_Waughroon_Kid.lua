-----------------------------------
-- Area: Waughroon Shrine
--  Mob: The Waughroon Kid
-- BCNM: The Final Bout
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Melee attacks have Additional effect: Weight.
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ATT, 300)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 30)
    mob:setMod(xi.mod.REGEN, 60) -- Observed a 2% HP per tic Regen
    mob:setLocalVar('counterstanceUsed', 0)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Repeats Blow & Blank Gaze twice in a row.
    local repeatMove = mob:getLocalVar('repeatMove')
    if repeatMove ~= 0 then
        mob:useMobAbility(repeatMove)
    end

    -- Uses Counterstance at 40% HP and below.
    if
        mob:getHPP() <= 40 and
        mob:getLocalVar('counterstanceUsed') == 0
    then
        mob:useMobAbility(xi.mobSkill.COUNTERSTANCE)
        mob:setLocalVar('counterstanceUsed', 1)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()
    if
        skillId == xi.mobSkill.BLOW or
        skillId == xi.mobSkill.BLANK_GAZE
    then
        local repeatMove = mob:getLocalVar('repeatMove')
        if
            repeatMove ~= 0 and
            skillId == repeatMove
        then
            mob:setLocalVar('repeatMove', 0)
        else
            mob:setLocalVar('repeatMove', skillId)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT, { chance = 20, power = 50 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
