-----------------------------------
-- Area: Horlais Peak
-- Mob: Chlevnik
-- KSNM99 : Horns of War

-- TODO : Update Howl to give 25% Attack instead of 15% - Update Meteor to 1.6 fTP + dINT * 3(!)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'FINAL_METEOR_DEATH', function(mobArg, skillID)
        if skillID == xi.mobSkill.FINAL_METEOR then
            if mobArg:getAnimationSub() ~= 1 then
                mobArg:setAnimationSub(1)
            end

            mobArg:timer(6000, function(mobArgTimer)
                mobArgTimer:setUnkillable(false)
                mobArgTimer:setHP(0)
            end)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:addMod(xi.mod.STUNRES, 90)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setTP(3000)
    mob:setLocalVar('finalMeteor', 0)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('meteorDelay', GetSystemTime() + 30)
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar('meteorDelay')
    if GetSystemTime() > delay then -- Cooldown on Meteor is 30 seconds.
        mob:castSpell(xi.magic.spell.METEOR, target)
        mob:setLocalVar('meteorDelay', GetSystemTime() + 30)
    end

    if mob:getHP() == 1 and mob:getLocalVar('finalMeteor') == 0 then
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setLocalVar('finalMeteor', 1)
    end

    if mob:getLocalVar('finalMeteor') == 1 then
        mob:useMobAbility(xi.mobSkill.FINAL_METEOR, nil, nil, true) -- Ignoring distance based off retail capture.
        mob:setLocalVar('finalMeteor', 2)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 25, duration = 10 }) -- 25% chance to stun for 10 seconds.
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.METEOR then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

return entity
