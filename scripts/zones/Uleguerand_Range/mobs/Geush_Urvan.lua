-----------------------------------
-- Area: Uleguerand Range
--   NM: Geush Urvan
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setBaseSpeed(45) -- Note: setBaseSpeed() also updates the animation speed to match.
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 15000)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(225)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.ATT, 400)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMod(xi.mod.REFRESH, 100)
end

entity.onMobFight = function(mob, target)
    if
        mob:getHPP() <= 90 and
        GetSystemTime() >= mob:getLocalVar('counterstanceTime')
    then
        mob:setLocalVar('counterstanceTime', GetSystemTime() + 180) -- Counterstance will only be used once every 3 minutes at most
        mob:useMobAbility(xi.mobSkill.COUNTERSTANCE_1)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [2] = { xi.magic.spell.BLIZZARD_IV,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [3] = { xi.magic.spell.BINDGA,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,      0, 100 },
        [4] = { xi.magic.spell.PARALYGA,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.mobSkill.COUNTERSTANCE_1 then
        mob:messageText(target, zones[xi.zone.ULEGUERAND_RANGE].text.GEUSH_COUNTER, false)
    end
end

return entity
